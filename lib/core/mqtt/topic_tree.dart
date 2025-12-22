import 'dart:async';
import '../../domain/models/mqtt_message.dart';
import '../../domain/models/topic_node.dart';

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
}

class TopicTree {
  final TopicNode root = TopicNode(name: 'root', fullPath: '');
  final Map<String, TopicNode> _pathCache = {};
  
  final _treeChangedController = StreamController<TopicTree>.broadcast();
  final _nodeUpdatedController = StreamController<TopicNode>.broadcast();

  Stream<TopicTree> get treeChanged => _treeChangedController.stream;
  Stream<TopicNode> get nodeUpdated => _nodeUpdatedController.stream;
  
  Map<String, TopicNode> get pathCache => Map.unmodifiable(_pathCache);

  void insertMessage(MqttMessage message) {
    // Handle root-level topics or empty topics gracefully
    if (message.topic.isEmpty) return;

    final parts = message.topic.split('/');
    TopicNode current = root;
    final pathBuilder = StringBuffer();

    for (int i = 0; i < parts.length; i++) {
      final part = parts[i];
      if (i > 0) pathBuilder.write('/');
      pathBuilder.write(part);
      final currentPath = pathBuilder.toString();

      // Check cache first
      if (_pathCache.containsKey(currentPath)) {
        current = _pathCache[currentPath]!;
      } else {
        // Create new node if it doesn't exist
        if (!current.children.containsKey(part)) {
          final newNode = TopicNode(
            name: part,
            fullPath: currentPath,
          );
          current.addChild(newNode);
          _pathCache[currentPath] = newNode;
          _treeChangedController.add(this); // Notify tree structure change
        }
        current = current.children[part]!;
      }
      
      // Update activity for every node in the path
      current.lastActivity = message.timestamp;
    }

    // Update leaf node details
    current.lastMessage = message;
    current.messageCount++;
    current.isRetained = message.retained;
    // lastActivity is already updated in the loop
    
    _nodeUpdatedController.add(current); // Notify node update
  }

  void removeTopic(String path) {
    final node = _pathCache[path];
    if (node == null) return;

    // Find parent
    final parts = path.split('/');
    if (parts.isEmpty) return;
    
    final parentPath = parts.take(parts.length - 1).join('/');
    final nodeName = parts.last;
    
    TopicNode? parent;
    if (parentPath.isEmpty) {
      parent = root;
    } else {
      parent = _pathCache[parentPath];
    }

    if (parent != null) {
      parent.removeChild(nodeName);
      _pathCache.remove(path);
      // We should technically remove all children from cache too if we remove a branch
      // But for now assuming leaf removal or simple cleanup
      _treeChangedController.add(this);
    }
  }

  void clear() {
    root.children.clear();
    _pathCache.clear();
    _treeChangedController.add(this);
  }
  
  TopicNode? getNode(String path) {
    return _pathCache[path];
  }

  void clearRetainedFlag(String path) {
    final node = getNode(path);
    if (node != null) {
      node.isRetained = false;
      // Also clear the retained flag on the last message if it exists
      if (node.lastMessage != null) {
        node.lastMessage = node.lastMessage!.copyWith(retained: false);
      }
      _nodeUpdatedController.add(node);
    }
  }
  
  List<String> getAllTopicPaths() {
    return _pathCache.keys.toList();
  }

  // Alias for UI components
  List<String> getAllTopics() => getAllTopicPaths();
  
  TreeStatistics getStatistics() {
    int totalMessages = 0;
    int retainedMessages = 0;
    final qosDistribution = <int, int>{0: 0, 1: 0, 2: 0};
    DateTime? oldest;
    DateTime? newest;
    
    for (final node in _pathCache.values) {
      totalMessages += node.messageCount;
      if (node.isRetained) retainedMessages++;
      
      if (node.lastMessage != null) {
        final msg = node.lastMessage!;
        qosDistribution[msg.qos] = (qosDistribution[msg.qos] ?? 0) + 1;
        
        if (oldest == null || msg.timestamp.isBefore(oldest)) {
          oldest = msg.timestamp;
        }
        if (newest == null || msg.timestamp.isAfter(newest)) {
          newest = msg.timestamp;
        }
      }
    }
    
    return TreeStatistics(
      totalTopics: _pathCache.length,
      totalMessages: totalMessages,
      retainedMessages: retainedMessages,
      qosDistribution: qosDistribution,
      oldestMessage: oldest,
      newestMessage: newest,
    );
  }
  
  void dispose() {
    _treeChangedController.close();
    _nodeUpdatedController.close();
  }
}
