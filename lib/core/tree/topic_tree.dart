import 'dart:async';
import 'topic_node.dart';
import '../../domain/models/mqtt_message.dart';

/// Efficient MQTT topic tree builder with path caching
class TopicTree {
  final TopicNode root = TopicNode(name: 'root', fullPath: '');
  final Map<String, TopicNode> _pathCache = {};
  final StreamController<TopicNode> _nodeUpdatedController = StreamController<TopicNode>.broadcast();
  final StreamController<TopicTree> _treeChangedController = StreamController<TopicTree>.broadcast();

  /// Stream that emits when a node is updated with a new message
  Stream<TopicNode> get nodeUpdated => _nodeUpdatedController.stream;

  /// Stream that emits when the tree structure changes
  Stream<TopicTree> get treeChanged => _treeChangedController.stream;

  /// Insert a message into the topic tree
  void insertMessage(MqttMessage message) {
    final parts = message.topic.split('/');
    TopicNode current = root;
    final pathBuilder = StringBuffer();

    for (int i = 0; i < parts.length; i++) {
      final part = parts[i];
      if (part.isEmpty) continue; // Skip empty parts

      pathBuilder.write(part);
      final currentPath = pathBuilder.toString();

      // Check cache first for performance
      if (_pathCache.containsKey(currentPath)) {
        current = _pathCache[currentPath]!;
      } else {
        // Create new node if it doesn't exist
        if (!current.children.containsKey(part)) {
          final newNode = TopicNode(
            name: part,
            fullPath: currentPath,
          );
          current.children[part] = newNode;
          _treeChangedController.add(this);
        }
        current = current.children[part]!;
        _pathCache[currentPath] = current;
      }

      if (i < parts.length - 1) {
        pathBuilder.write('/');
      }
    }

    // Update leaf node with message data
    _updateNodeWithMessage(current, message);
    _nodeUpdatedController.add(current);
  }

  void _updateNodeWithMessage(TopicNode node, MqttMessage message) {
    node.messages.add(message);
    node.lastMessage = message;
    node.messageCount++;
    node.isRetained = message.retained;
    node.lastActivity = message.timestamp;

    // Keep only recent messages to prevent memory bloat
    if (node.messages.length > 100) {
      node.messages.removeAt(0);
    }
  }

  /// Get a node by its full path
  TopicNode? getNode(String path) {
    return _pathCache[path];
  }

  /// Get all topic paths (for expiration manager)
  Map<String, TopicNode> get pathCache => _pathCache;

  /// Get all topic paths
  List<String> getAllTopicPaths() {
    return _pathCache.keys.toList();
  }

  /// Get statistics about the tree
  TreeStatistics getStatistics() {
    return TreeStatistics.calculate(root);
  }

  /// Clear the entire tree
  void clear() {
    root.children.clear();
    _pathCache.clear();
    _treeChangedController.add(this);
  }

  /// Remove a specific topic path
  void removeTopic(String topicPath) {
    final parts = topicPath.split('/');
    if (parts.isEmpty) return;

    TopicNode? current = root;
    final pathToRemove = <TopicNode>[];

    // Traverse to the node
    for (final part in parts) {
      if (part.isEmpty) continue;
      current = current?.children[part];
      if (current == null) return;
      pathToRemove.add(current);
    }

    // Remove from cache
    _pathCache.remove(topicPath);

    // Remove from tree (start from leaf and go up)
    for (int i = pathToRemove.length - 1; i >= 0; i--) {
      final node = pathToRemove[i];
      final parent = i > 0 ? pathToRemove[i - 1] : root;

      if (node.children.isEmpty && node.messageCount == 0) {
        parent.children.remove(node.name);
      } else {
        break; // Stop if node has children or messages
      }
    }

    _treeChangedController.add(this);
  }

  void dispose() {
    _nodeUpdatedController.close();
    _treeChangedController.close();
  }
}

/// Statistics about the topic tree
class TreeStatistics {
  final int totalTopics;
  final int totalMessages;
  final int retainedMessages;
  final Map<int, int> qosDistribution;
  final DateTime? oldestMessage;
  final DateTime? newestMessage;

  TreeStatistics({
    required this.totalTopics,
    required this.totalMessages,
    required this.retainedMessages,
    required this.qosDistribution,
    this.oldestMessage,
    this.newestMessage,
  });

  static TreeStatistics calculate(TopicNode root) {
    int totalTopics = 0;
    int totalMessages = 0;
    int retainedMessages = 0;
    final qosDistribution = <int, int>{};
    DateTime? oldestMessage;
    DateTime? newestMessage;

    void traverse(TopicNode node) {
      totalTopics++;
      totalMessages += node.messageCount;

      if (node.isRetained) {
        retainedMessages++;
      }

      for (final message in node.messages) {
        qosDistribution[message.qos] = (qosDistribution[message.qos] ?? 0) + 1;

        if (oldestMessage == null || message.timestamp.isBefore(oldestMessage!)) {
          oldestMessage = message.timestamp;
        }
        if (newestMessage == null || message.timestamp.isAfter(newestMessage!)) {
          newestMessage = message.timestamp;
        }
      }

      for (final child in node.children.values) {
        traverse(child);
      }
    }

    for (final child in root.children.values) {
      traverse(child);
    }

    return TreeStatistics(
      totalTopics: totalTopics,
      totalMessages: totalMessages,
      retainedMessages: retainedMessages,
      qosDistribution: qosDistribution,
      oldestMessage: oldestMessage,
      newestMessage: newestMessage,
    );
  }
}