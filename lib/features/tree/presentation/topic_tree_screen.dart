import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/tree_providers.dart';
import '../../../core/tree/virtualized_topic_tree.dart';
import '../../../core/tree/topic_node.dart';
import '../../../core/tree/topic_tree.dart';

class TopicTreeScreen extends ConsumerStatefulWidget {
  const TopicTreeScreen({super.key});

  @override
  ConsumerState<TopicTreeScreen> createState() => _TopicTreeScreenState();
}

class _TopicTreeScreenState extends ConsumerState<TopicTreeScreen> {
  @override
  void initState() {
    super.initState();
    // Start topic expiration cleanup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final expirationManager = ref.read(topicExpirationManagerProvider);
      expirationManager.startCleanup();
    });
  }

  @override
  Widget build(BuildContext context) {
    final treeAsync = ref.watch(treeChangedProvider);
    final statistics = ref.watch(treeStatisticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Topic Tree'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final tree = ref.read(topicTreeProvider);
              tree.clear();
            },
            tooltip: 'Clear Tree',
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showStatisticsDialog(context, statistics),
            tooltip: 'Statistics',
          ),
        ],
      ),
      body: Column(
        children: [
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
                child: Text('Error loading tree: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsBar(TreeStatistics statistics) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        children: [
          _buildStatItem('Topics', statistics.totalTopics.toString()),
          const SizedBox(width: 16.0),
          _buildStatItem('Messages', statistics.totalMessages.toString()),
          const SizedBox(width: 16.0),
          _buildStatItem('Retained', statistics.retainedMessages.toString()),
          const Spacer(),
          if (statistics.newestMessage != null)
            Text(
              'Last: ${_formatTimeAgo(statistics.newestMessage!)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  void _onNodeTap(BuildContext context, TopicNode node) {
    // Navigate to message details or show context menu
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildNodeDetailsSheet(node),
    );
  }

  void _onNodeExpand(TopicNode node) {
    // Handle node expansion - could trigger lazy loading here
    print('Node expanded: ${node.fullPath}');
  }

  Widget _buildNodeDetailsSheet(TopicNode node) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            node.fullPath,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16.0),
          _buildDetailRow('Messages', node.messageCount.toString()),
          _buildDetailRow('Children', node.children.length.toString()),
          _buildDetailRow('Retained', node.isRetained ? 'Yes' : 'No'),
          if (node.lastActivity != null)
            _buildDetailRow('Last Activity', _formatTimeAgo(node.lastActivity!)),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to message list for this topic
                  Navigator.of(context).pop();
                },
                child: const Text('View Messages'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
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
            _buildDetailRow('Total Topics', statistics.totalTopics.toString()),
            _buildDetailRow('Total Messages', statistics.totalMessages.toString()),
            _buildDetailRow('Retained Messages', statistics.retainedMessages.toString()),
            const SizedBox(height: 16.0),
            const Text('QoS Distribution:'),
            ...statistics.qosDistribution.entries.map(
              (entry) => _buildDetailRow('QoS ${entry.key}', entry.value.toString()),
            ),
            if (statistics.oldestMessage != null)
              _buildDetailRow('Oldest Message', _formatDateTime(statistics.oldestMessage!)),
            if (statistics.newestMessage != null)
              _buildDetailRow('Newest Message', _formatDateTime(statistics.newestMessage!)),
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

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inSeconds}s ago';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
           '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}