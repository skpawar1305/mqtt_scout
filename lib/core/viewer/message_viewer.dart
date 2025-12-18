import 'dart:convert';
import 'package:flutter/material.dart';
import '../../domain/models/mqtt_message.dart';
import '../parsing/payload_parser.dart';
import 'json_viewer.dart';
import 'diff_viewer.dart';
import 'binary_viewer.dart';
import 'message_diff.dart';

/// Unified message viewer that automatically selects the appropriate viewer based on payload type
class MessageViewer extends StatefulWidget {
  final MqttMessage message;
  final MqttMessage? previousMessage; // For diff view

  const MessageViewer({
    super.key,
    required this.message,
    this.previousMessage,
  });

  @override
  State<MessageViewer> createState() => _MessageViewerState();
}

class _MessageViewerState extends State<MessageViewer> with TickerProviderStateMixin {
  TabController? _tabController;
  late PayloadType _payloadType;

  @override
  void initState() {
    super.initState();
    _payloadType = PayloadParser.detectType(widget.message.payload);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = _getAvailableTabs();

    // Initialize tab controller if not already done or if tabs changed
    if (_tabController == null || _tabController!.length != tabs.length) {
      _tabController?.dispose();
      _tabController = TabController(length: tabs.length, vsync: this);
    }

    return Column(
      children: [
        // Message header
        _buildMessageHeader(),

        // Tab bar
        if (tabs.length > 1)
          TabBar(
            controller: _tabController,
            tabs: tabs.map((tab) => Tab(text: tab.title)).toList(),
            isScrollable: true,
          ),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: tabs.map((tab) => tab.content).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageHeader() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Topic and timestamp
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.message.topic,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                _formatTimestamp(widget.message.timestamp),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),

          // Payload info
          Row(
            children: [
              Icon(
                _getPayloadTypeIcon(),
                size: 16.0,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 4.0),
              Text(
                PayloadParser.getTypeDescription(_payloadType),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 12.0),
              Text(
                '${widget.message.payload.length} chars',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                'QoS ${widget.message.qos}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              if (widget.message.retained) ...[
                const SizedBox(width: 8.0),
                Icon(
                  Icons.bookmark,
                  size: 14.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  List<_ViewerTab> _getAvailableTabs() {
    final tabs = <_ViewerTab>[];

    // Raw view (always available)
    tabs.add(_ViewerTab(
      title: 'Raw',
      content: _buildRawView(),
    ));

    // Formatted view (for JSON, XML)
    if (PayloadParser.shouldFormat(_payloadType)) {
      tabs.add(_ViewerTab(
        title: 'Formatted',
        content: _buildFormattedView(),
      ));
    }

    // JSON tree view (for JSON)
    if (_payloadType == PayloadType.json) {
      tabs.add(_ViewerTab(
        title: 'Tree',
        content: _buildJsonTreeView(),
      ));
    }

    // Binary view (for binary data)
    if (_payloadType == PayloadType.binary) {
      tabs.add(_ViewerTab(
        title: 'Hex',
        content: _buildBinaryView(),
      ));
    }

    // Diff view (if previous message available)
    if (widget.previousMessage != null) {
      tabs.add(_ViewerTab(
        title: 'Diff',
        content: _buildDiffView(),
      ));
    }

    return tabs;
  }

  Widget _buildRawView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: SelectableText(
        widget.message.payload,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _buildFormattedView() {
    final formatted = PayloadParser.format(widget.message.payload, _payloadType);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: SelectableText(
        formatted,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _buildJsonTreeView() {
    try {
      final json = jsonDecode(widget.message.payload) as Map<String, dynamic>;
      return JsonViewerWidget(
        json: json,
        message: widget.message,
      );
    } catch (e) {
      return Center(
        child: Text(
          'Invalid JSON: $e',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      );
    }
  }

  Widget _buildBinaryView() {
    final bytes = PayloadParser.toBytes(widget.message.payload);
    return BinaryViewer(bytes: bytes);
  }

  Widget _buildDiffView() {
    final diff = MessageDiff.compute(
      widget.previousMessage!.payload,
      widget.message.payload,
    );

    return DiffViewer(diff: diff);
  }

  IconData _getPayloadTypeIcon() {
    switch (_payloadType) {
      case PayloadType.json:
        return Icons.data_object;
      case PayloadType.xml:
        return Icons.code;
      case PayloadType.binary:
        return Icons.memory;
      case PayloadType.number:
        return Icons.numbers;
      case PayloadType.boolean:
        return Icons.check_circle;
      case PayloadType.text:
        return Icons.text_fields;
      case PayloadType.empty:
        return Icons.clear;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inSeconds}s ago';
    }
  }
}

/// Internal class for tab definition
class _ViewerTab {
  final String title;
  final Widget content;

  const _ViewerTab({
    required this.title,
    required this.content,
  });
}