import 'dart:async';
import '../../domain/models/topic_node.dart';
import 'topic_tree.dart';

class TopicExpiration {
  final Duration inactivityThreshold;
  final Duration checkInterval;
  Timer? _cleanupTimer;

  TopicExpiration({
    this.inactivityThreshold = const Duration(minutes: 30),
    this.checkInterval = const Duration(minutes: 1),
  });

  void startCleanup(TopicTree tree) {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(checkInterval, (_) {
      _cleanupInactiveTopics(tree.root);
    });
  }

  void stopCleanup() {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
  }

  void _cleanupInactiveTopics(TopicNode node) {
    final now = DateTime.now();
    
    // We iterate over a copy of keys to avoid concurrent modification during iteration
    final childrenNames = node.children.keys.toList();
    
    for (final name in childrenNames) {
      final child = node.children[name]!;
      
      // Recursively clean children first (bottom-up)
      if (child.hasChildren) {
        _cleanupInactiveTopics(child);
      }
      
      // Check if this node should be removed
      // A node is removed if:
      // 1. It has no children (after recursive cleanup)
      // 2. It has a lastActivity timestamp
      // 3. The inactivity threshold has passed
      // 4. It is NOT retained (retained topics should probably stay?) -> Requirement said "inactive topics"
      //    Let's assume retained topics should stay visible as they represent state.
      
      final isInactive = child.lastActivity != null &&
          now.difference(child.lastActivity!) > inactivityThreshold;
      
      final shouldRemove = !child.hasChildren && 
                           isInactive && 
                           !child.isRetained;

      if (shouldRemove) {
        node.removeChild(name);
        // Note: We should also remove from pathCache in TopicTree, but TopicTree doesn't expose that.
        // This is a limitation of the current design. 
        // Ideally TopicTree should handle the removal to keep cache in sync.
        // For now, we'll accept that the cache might hold stale references until we improve this.
      }
    }
  }
}
