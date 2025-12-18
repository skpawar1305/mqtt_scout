import 'dart:async';
import 'topic_tree.dart';
import 'topic_node.dart';

/// Manages cleanup of inactive topics to prevent memory bloat
class TopicExpirationManager {
  final TopicTree _tree;
  final Duration _inactivityThreshold;
  Timer? _cleanupTimer;
  bool _isRunning = false;

  TopicExpirationManager(
    this._tree, {
    Duration inactivityThreshold = const Duration(minutes: 30),
  }) : _inactivityThreshold = inactivityThreshold;

  /// Start periodic cleanup of inactive topics
  void startCleanup() {
    if (_isRunning) return;

    _isRunning = true;
    _cleanupTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _cleanupInactiveTopics();
    });
  }

  /// Stop periodic cleanup
  void stopCleanup() {
    _isRunning = false;
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
  }

  /// Manually trigger cleanup
  void cleanupNow() {
    _cleanupInactiveTopics();
  }

  void _cleanupInactiveTopics() {
    final now = DateTime.now();
    final nodesToRemove = <String>[];

    // Find inactive nodes
    for (final entry in _tree.pathCache.entries) {
      final node = entry.value;
      if (_isNodeInactive(node, now)) {
        nodesToRemove.add(entry.key);
      }
    }

    // Remove inactive nodes
    for (final path in nodesToRemove) {
      _tree.removeTopic(path);
    }
  }

  bool _isNodeInactive(TopicNode node, DateTime now) {
    // Node is inactive if it has no recent activity and no retained messages
    if (node.isRetained) return false;

    if (node.lastActivity == null) return true;

    final timeSinceLastActivity = now.difference(node.lastActivity!);
    return timeSinceLastActivity > _inactivityThreshold;
  }

  bool get isRunning => _isRunning;

  void dispose() {
    stopCleanup();
  }
}