import 'mqtt_message.dart';

class TopicNode {
  final String name;
  final String fullPath;
  final Map<String, TopicNode> children;

  MqttMessage? lastMessage;
  int messageCount;
  bool isRetained;
  DateTime? lastActivity;

  // For UI state
  bool isExpanded;
  bool isSubscribed;

  TopicNode({
    required this.name,
    required this.fullPath,
    Map<String, TopicNode>? children,
    this.lastMessage,
    this.messageCount = 0,
    this.isRetained = false,
    this.lastActivity,
    this.isExpanded = false,
    this.isSubscribed = false,
  }) : children = children ?? {};

  // Computed properties
  int get totalMessageCount =>
      messageCount + children.values.fold(0, (sum, child) => sum + child.totalMessageCount);

  bool get hasChildren => children.isNotEmpty;

  // Helper methods
  TopicNode? getChild(String name) => children[name];

  void addChild(TopicNode child) {
    children[child.name] = child;
  }

  void removeChild(String name) {
    children.remove(name);
  }

  TopicNode copyWith({
    String? name,
    String? fullPath,
    Map<String, TopicNode>? children,
    MqttMessage? lastMessage,
    int? messageCount,
    bool? isRetained,
    DateTime? lastActivity,
    bool? isExpanded,
    bool? isSubscribed,
  }) {
    return TopicNode(
      name: name ?? this.name,
      fullPath: fullPath ?? this.fullPath,
      children: children ?? Map.from(this.children),
      lastMessage: lastMessage ?? this.lastMessage,
      messageCount: messageCount ?? this.messageCount,
      isRetained: isRetained ?? this.isRetained,
      lastActivity: lastActivity ?? this.lastActivity,
      isExpanded: isExpanded ?? this.isExpanded,
      isSubscribed: isSubscribed ?? this.isSubscribed,
    );
  }
  // UI Helper methods
  void toggleExpanded() {
    isExpanded = !isExpanded;
  }

  List<TopicNode> getVisibleNodes({int maxDepth = -1}) {
    final visibleNodes = <TopicNode>[];
    _collectVisibleNodes(this, visibleNodes, 0, maxDepth);
    return visibleNodes;
  }

  void _collectVisibleNodes(
    TopicNode node,
    List<TopicNode> result,
    int currentDepth,
    int maxDepth,
  ) {
    // Don't include root in the list usually, but let's see how VirtualizedTopicTree uses it.
    // It passes root.getVisibleNodes.
    // If root is "root" (dummy), we might want to skip it or handle it.
    // Assuming we start with children of root if root is hidden, but here we recurse.
    
    // If this is the root node (dummy), we don't add it, but we process its children
    if (node.fullPath.isNotEmpty) {
      result.add(node);
    }

    if (node.isExpanded && (maxDepth == -1 || currentDepth < maxDepth)) {
      final sortedChildren = node.children.values.toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      
      for (final child in sortedChildren) {
        _collectVisibleNodes(child, result, currentDepth + 1, maxDepth);
      }
    } else if (node.fullPath.isEmpty) {
      // Always expand root
      final sortedChildren = node.children.values.toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      
      for (final child in sortedChildren) {
        _collectVisibleNodes(child, result, currentDepth + 1, maxDepth);
      }
    }
  }
}