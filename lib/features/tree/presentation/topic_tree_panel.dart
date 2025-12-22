import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/tree_providers.dart';
import '../../../core/providers/mqtt_providers.dart';
import '../../../core/tree/virtualized_topic_tree.dart';
import '../../../core/tree/topic_tree.dart';
import '../../../core/tree/topic_node.dart';
import '../../../features/publish/presentation/publish_panel.dart';

class TopicTreePanel extends ConsumerStatefulWidget {
  const TopicTreePanel({super.key});

  @override
  ConsumerState<TopicTreePanel> createState() => _TopicTreePanelState();
}

class _TopicTreePanelState extends ConsumerState<TopicTreePanel> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final expirationManager = ref.read(topicExpirationManagerProvider);
      expirationManager.startCleanup();
    });
  }

  @override
  Widget build(BuildContext context) {
    final treeAsync = ref.watch(treeChangedProvider);
    final statistics = ref.watch(treeStatisticsProvider);

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Row(
            children: [
              const Text('Topic Tree', style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.send, size: 20),
                onPressed: () => _showPublishPanel(context),
                tooltip: 'Publish',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.refresh, size: 20),
                onPressed: () {
                  final tree = ref.read(topicTreeProvider);
                  tree.clear();
                },
                tooltip: 'Clear',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.info_outline, size: 20),
                onPressed: () => _showStatisticsDialog(context, statistics),
                tooltip: 'Stats',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),

        // Statistics bar
        _buildStatisticsBar(statistics),

        // Tree view
        Expanded(
          child: treeAsync.when(
            data: (tree) => VirtualizedTopicTree(
              root: tree.root,
              onNodeTap: (node) => _onNodeTap(context, node),
              onNodeExpand: (node) => _onNodeExpand(node),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsBar(TreeStatistics statistics) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${statistics.totalTopics} topics', style: Theme.of(context).textTheme.bodySmall),
          Text('${statistics.totalMessages} msgs', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  void _onNodeTap(BuildContext context, TopicNode node) {
    ref.read(selectedNodeProvider.notifier).state = node;
  }

  void _onNodeExpand(TopicNode node) {
    // Handle node expansion
  }

  void _showPublishPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const PublishPanel(),
    );
  }

  void _showStatisticsDialog(BuildContext context, TreeStatistics statistics) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tree Statistics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Topics: ${statistics.totalTopics}'),
            Text('Total Messages: ${statistics.totalMessages}'),
            Text('Retained Messages: ${statistics.retainedMessages}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
