import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/mqtt_message.dart';
import '../../core/viewer/message_viewer.dart';

/// Screen for viewing individual MQTT messages with advanced visualization
class MessageViewerScreen extends ConsumerStatefulWidget {
  final MqttMessage message;
  final MqttMessage? previousMessage;

  const MessageViewerScreen({
    super.key,
    required this.message,
    this.previousMessage,
  });

  @override
  ConsumerState<MessageViewerScreen> createState() => _MessageViewerScreenState();
}

class _MessageViewerScreenState extends ConsumerState<MessageViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Viewer'),
        actions: [
          // Copy payload action
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'Copy Payload',
            onPressed: _copyPayload,
          ),
          // Share action (placeholder for future implementation)
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share Message',
            onPressed: _shareMessage,
          ),
        ],
      ),
      body: MessageViewer(
        message: widget.message,
        previousMessage: widget.previousMessage,
      ),
    );
  }

  void _copyPayload() {
    // TODO: Implement clipboard functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payload copied to clipboard')),
    );
  }

  void _shareMessage() {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon')),
    );
  }
}