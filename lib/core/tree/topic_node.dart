import 'dart:collection';
import '../../domain/models/mqtt_message.dart';
import 'topic_filter.dart';

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

  List<TopicNode> getVisibleNodes({int maxDepth = -1, TopicFilter? filter}) {
    final visibleNodes = <TopicNode>[];
    if (filter != null && !filter.isEmpty) {
      _collectFilteredNodes(this, visibleNodes, filter);
    } else {
      _collectVisibleNodes(this, visibleNodes, 0, maxDepth);
    }
    return visibleNodes;
  }

  // Returns true if this node or any descendant matches the filter
  bool _collectFilteredNodes(
    TopicNode node,
    List<TopicNode> result,
    TopicFilter filter,
  ) {
    bool selfMatches = filter.matches(node.name, node.fullPath, isRetained: node.isRetained);
    bool anyChildMatches = false;

    // We need to check all children to know if we should be visible as a parent
    // And we also want to collect them if they match or have matching descendants
    
    // To preserve order, we need to decide whether to add self before children.
    // Yes, pre-order traversal for tree view.
    
    // But we don't know if we should add self until we check children?
    // No, we can filter children first into a temporary list? 
    // Or just iterate them.
    
    // Optimized approach:
    // 1. Sort children
    // 2. Iterate. Recurse.
    // 3. If child returns true, it means it has a match.
    
    // Issue: We need to add 'node' to 'result' ONLY if (selfMatches || anyChildMatches).
    // And 'node' must be added BEFORE children.
    // So we can't add children to 'result' directly in the loop unless we know 'node' is added.
    
    // Solution: Two pass or temporary buffer?
    // Or simple recursion with lazy addition?
    
    // Let's use a standard pattern:
    // This method adds 'node' and its valid children to 'result'.
    // Returns true if 'node' matches or has matching descendants.
    
    // BUT: The recursive call will try to add child to result. 
    // If parent isn't added yet, order is wrong.
    
    // Refined Logic:
    // This method determines if 'node' should be visible.
    // If so, adds it, then calls recursion on children.
    
    // But we don't know if we should add 'node' until we check children! 
    // Catch-22.
    
    // Break it down:
    // string search: "foo".
    // root -> a -> foo.
    // root matches? No. Children match? Yes (a).
    // so root is added.
    // a matches? No. Children match? Yes (foo).
    // so a is added.
    // foo matches? Yes. 
    // so foo is added.
    
    // We need a helper that returns "hasMatch" and populates a "subtree list" if true?
    // Or we perform a "check match" pass then a "collect" pass? 
    // Double traversal is safer for order.
    
    // Pass 1: Annotate or Compute "hasMatch" boolean for the subtree?
    // We can't annotate TopicNode easily without mutable state.
    // Let's do it in one pass with a buffer.
    
    final childNodes = <TopicNode>[];
    final sortedChildren = node.children.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
      
    for (final child in sortedChildren) {
      // Recursively collect into a separate list
      final childResult = <TopicNode>[];
      final childHasMatch = _collectFilteredNodes(child, childResult, filter);
      
      if (childHasMatch) {
         anyChildMatches = true;
         childNodes.addAll(childResult);
      }
    }
    
    if (selfMatches || anyChildMatches) {
       // Root node (dummy) handling
       if (node.fullPath.isNotEmpty) {
         result.add(node);
       }
       result.addAll(childNodes);
       return true;
    }
    
    return false;
  }

  void _collectVisibleNodes(
    TopicNode node,
    List<TopicNode> result,
    int currentDepth,
    int maxDepth,
  ) {
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

  void toggleExpanded() {
    isExpanded = !isExpanded;
  }

  @override
  String toString() => 'TopicNode(name: $name, path: $fullPath, children: ${children.length}, messages: $messageCount)';
}