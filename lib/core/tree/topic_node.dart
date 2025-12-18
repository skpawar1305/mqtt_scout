import 'dart:collection';
import '../../domain/models/mqtt_message.dart';

/// Represents a node in the MQTT topic tree hierarchy
class TopicNode {
  final String name;
  final String fullPath;
  final Map<String, TopicNode> children = {};
  final List<MqttMessage> messages = [];
  MqttMessage? lastMessage;
  int messageCount = 0;
  bool isRetained = false;
  DateTime? lastActivity;
  bool isExpanded = false;

  TopicNode({
    required this.name,
    required this.fullPath,
  });

  bool get hasChildren => children.isNotEmpty;
  bool get isLeaf => children.isEmpty;

  /// Get all descendant nodes in breadth-first order
  List<TopicNode> getAllDescendants() {
    final result = <TopicNode>[];
    final queue = Queue<TopicNode>.from(children.values);

    while (queue.isNotEmpty) {
      final node = queue.removeFirst();
      result.add(node);
      queue.addAll(node.children.values);
    }

    return result;
  }

  /// Get visible nodes when tree is virtualized
  List<TopicNode> getVisibleNodes({int maxDepth = -1}) {
    final visible = <TopicNode>[];
    _collectVisibleNodes(visible, 0, maxDepth);
    return visible;
  }

  void _collectVisibleNodes(List<TopicNode> visible, int currentDepth, int maxDepth) {
    if (maxDepth >= 0 && currentDepth > maxDepth) return;

    visible.add(this);

    if (isExpanded || currentDepth == 0) {
      for (final child in children.values) {
        child._collectVisibleNodes(visible, currentDepth + 1, maxDepth);
      }
    }
  }

  void toggleExpanded() {
    isExpanded = !isExpanded;
  }

  @override
  String toString() => 'TopicNode(name: $name, path: $fullPath, children: ${children.length}, messages: $messageCount)';
}