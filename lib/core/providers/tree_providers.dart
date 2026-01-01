import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'mqtt_providers.dart';
import '../tree/topic_tree.dart';
import '../tree/topic_expiration_manager.dart';
import '../tree/topic_node.dart';

// Core topic tree provider
final topicTreeProvider = Provider<TopicTree>((ref) {
  final tree = TopicTree();

  // Listen to MQTT messages and insert them into the tree
  final messageSubscription = ref.listen(
    mqttMessagesProvider,
    (previous, next) {
      next.whenData((message) {
        tree.insertMessage(message);
      });
    },
  );

  ref.onDispose(() {
    messageSubscription.close();
    tree.dispose();
  });

  return tree;
});

// Topic expiration manager provider
final topicExpirationManagerProvider = Provider<TopicExpirationManager>((ref) {
  final tree = ref.watch(topicTreeProvider);
  final manager = TopicExpirationManager(tree);

  ref.onDispose(() => manager.dispose());

  return manager;
});

// Tree statistics provider with throttling
final treeStatisticsProvider = NotifierProvider<TreeStatisticsNotifier, TreeStatistics>(TreeStatisticsNotifier.new);

class TreeStatisticsNotifier extends Notifier<TreeStatistics> {
  Timer? _timer;
  bool _isDirty = false;

  @override
  TreeStatistics build() {
    final tree = ref.watch(topicTreeProvider);
    
    // Listen to changes
    ref.listen(treeChangedProvider, (_, __) => _scheduleUpdate());
    ref.listen(nodeUpdatedProvider, (_, __) => _scheduleUpdate());
    
    // Cancel timer on dispose
    ref.onDispose(() {
      _timer?.cancel();
    });

    return tree.getStatistics();
  }

  void _scheduleUpdate() {
    _isDirty = true;
    if (_timer == null) {
      _timer = Timer(const Duration(milliseconds: 16), _flush);
    }
  }

  void _flush() {
    _timer = null;
    if (_isDirty) {
      // Use ref.read to avoid creating a dependency loop or rebuilding the notifier
      // The tree instance itself is stable.
      final tree = ref.read(topicTreeProvider);
      state = tree.getStatistics();
      _isDirty = false;
    }
  }
}

// Stream of tree changes
final treeChangedProvider = StreamProvider<TopicTree>((ref) async* {
  final tree = ref.watch(topicTreeProvider);
  yield tree;
  yield* tree.treeChanged;
});

// Stream of node updates
final nodeUpdatedProvider = StreamProvider<TopicNode>((ref) {
  final tree = ref.watch(topicTreeProvider);
  return tree.nodeUpdated;
});

// Provider for getting a specific node by path
final topicNodeProvider = Provider.family<TopicNode?, String>((ref, path) {
  final tree = ref.watch(topicTreeProvider);
  return tree.getNode(path);
});

// Provider for all topic paths
final allTopicPathsProvider = Provider<List<String>>((ref) {
  final tree = ref.watch(topicTreeProvider);
  return tree.getAllTopicPaths();
});

// Selected node provider for UI selection
final selectedNodeProvider = StateProvider<TopicNode?>((ref) => null);