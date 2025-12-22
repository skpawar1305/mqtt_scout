import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:intl/intl.dart';
import '../../../core/providers/tree_providers.dart';
import '../../../domain/models/topic_node.dart';
import '../../../domain/models/mqtt_message.dart';

class MessageViewerPanel extends ConsumerWidget {
  const MessageViewerPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNode = ref.watch(selectedNodeProvider);
    
    // Listen to node updates to trigger rebuild when the selected node changes
    ref.watch(nodeUpdatedProvider.select((value) {
      if (selectedNode != null && value.value?.fullPath == selectedNode.fullPath) {
        return value.value;
      }
      return null;
    }));

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                const Text('Message Details', style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
              ],
            ),
          ),
          
          // Content
        Expanded(
          child: selectedNode == null
              ? const Center(child: Text('Select a topic to view details'))
              : selectedNode.lastMessage == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Topic: ${selectedNode.fullPath}', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          const Text('No messages received yet'),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(context, 'Topic', selectedNode.fullPath, isTitle: true),
                          const SizedBox(height: 16),
                          _buildMessageDetails(context, selectedNode.lastMessage!),
                          const SizedBox(height: 24),
                          const Text('Payload', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          _buildPayloadView(context, selectedNode.lastMessage!.payload, isDark),
                        ],
                      ),
                    ),
        ),
      ],
    ));
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, {bool isTitle = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        SelectableText(
          value,
          style: isTitle
              ? Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildMessageDetails(BuildContext context, MqttMessage message) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildInfoRow(context, 'QoS', message.qos.toString()),
        _buildInfoRow(context, 'Retained', message.retained ? 'Yes' : 'No'),
        _buildInfoRow(context, 'Received', dateFormat.format(message.timestamp)),
        if (message.contentType != null)
          _buildInfoRow(context, 'Content Type', message.contentType!),
        if (message.responseTopic != null)
          _buildInfoRow(context, 'Response Topic', message.responseTopic!),
      ],
    );
  }

  Widget _buildPayloadView(BuildContext context, String payload, bool isDark) {
    // Try to format JSON
    String formattedPayload = payload;
    String language = 'plaintext';
    
    try {
      if (payload.trim().startsWith('{') || payload.trim().startsWith('[')) {
        final jsonObject = json.decode(payload);
        const encoder = JsonEncoder.withIndent('  ');
        formattedPayload = encoder.convert(jsonObject);
        language = 'json';
      }
    } catch (_) {
      // Not JSON
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: HighlightView(
              formattedPayload,
              language: language,
              theme: isDark ? draculaTheme : githubTheme,
              padding: const EdgeInsets.all(12),
              textStyle: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.copy, size: 16),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: formattedPayload));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payload copied to clipboard')),
                );
              },
              tooltip: 'Copy Payload',
              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
