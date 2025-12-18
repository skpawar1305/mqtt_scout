import 'package:flutter_riverpod/flutter_riverpod.dart';
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

// Tree statistics provider
final treeStatisticsProvider = Provider<TreeStatistics>((ref) {
  final tree = ref.watch(topicTreeProvider);
  return tree.getStatistics();
});

// Stream of tree changes
final treeChangedProvider = StreamProvider<TopicTree>((ref) {
  final tree = ref.watch(topicTreeProvider);
  return tree.treeChanged;
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