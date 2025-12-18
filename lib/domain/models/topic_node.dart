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
}