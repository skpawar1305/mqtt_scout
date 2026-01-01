import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:intl/intl.dart';
import '../../../core/providers/tree_providers.dart';
import '../../../core/providers/mqtt_providers.dart';
import '../../../core/tree/topic_node.dart';
import '../../../domain/models/mqtt_message.dart';
import '../../home/presentation/widgets/topic_chart.dart';

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
                          
                          if (_hasNumericHistory(selectedNode)) ...[
                             const SizedBox(height: 16),
                             Container(
                               height: 220,
                               decoration: BoxDecoration(
                                 border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.2)),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               padding: const EdgeInsets.all(8),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.stretch,
                                 children: [
                                   Text('History', style: Theme.of(context).textTheme.labelSmall),
                                   Expanded(child: TopicChart(topicNode: selectedNode, isDark: isDark)),
                                 ],
                               )
                             ),
                          ],

                          const SizedBox(height: 16),
                          _buildMessageDetails(context, ref, selectedNode.lastMessage!, selectedNode.fullPath),
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

  bool _hasNumericHistory(TopicNode node) {
    if (node.messages.length < 2) return false;
    int numericCount = 0;
    // Check last 20 messages to avoid iterating everything
    final checkCount = node.messages.length > 20 ? 20 : node.messages.length;
    final recentMessages = node.messages.sublist(node.messages.length - checkCount);
    
    for (final msg in recentMessages) {
      if (double.tryParse(msg.payload) != null) numericCount++;
    }
    // Return true if at least 50% of recent messages are numeric
    return numericCount >= checkCount * 0.5;
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

  Widget _buildMessageDetails(BuildContext context, WidgetRef ref, MqttMessage message, String topic) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _buildInfoRow(context, 'QoS', message.qos.toString()),
        Row(
            mainAxisSize: MainAxisSize.min,
            children: [
                _buildInfoRow(context, 'Retained', message.retained ? 'Yes' : 'No'),
                if (message.retained) ...[
                    const SizedBox(width: 8),
                    SizedBox(
                        height: 24,
                        child: OutlinedButton(
                            onPressed: () {
                                _showClearRetainedDialog(context, ref, topic);
                            },
                            style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                textStyle: const TextStyle(fontSize: 10),
                                side: BorderSide(color: Theme.of(context).colorScheme.error),
                                foregroundColor: Theme.of(context).colorScheme.error,
                            ),
                            child: const Text('CLEAR'),
                        ),
                    ),
                ]
            ],
        ),
        _buildInfoRow(context, 'Received', dateFormat.format(message.timestamp)),
        if (message.contentType != null)
          _buildInfoRow(context, 'Content Type', message.contentType!),
        if (message.responseTopic != null)
          _buildInfoRow(context, 'Response Topic', message.responseTopic!),
      ],
    );
  }

  Future<void> _showClearRetainedDialog(BuildContext context, WidgetRef ref, String topic) async {
      final confirm = await showDialog<bool>(
          context: context, 
          builder: (context) => AlertDialog(
              title: const Text('Clear Retained Message?'),
              content: Text('This will publish an empty retained message to "$topic", which should clear it from the broker.'),
              actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                  TextButton(
                      onPressed: () => Navigator.pop(context, true), 
                      style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                      child: const Text('Clear'),
                    ),
              ],
          ),
      );

      if (confirm == true) {
          try {
              await ref.read(mqttServiceProvider).clearRetainedMessage(topic);
              if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Retained message cleared')),
                  );
              }
          } catch (e) {
              if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error clearing retained message: $e')),
                  );
              }
          }
      }
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
