import 'package:flutter/material.dart';
import 'topic_node.dart';

/// Efficient virtualized tree view for large topic hierarchies
class VirtualizedTopicTree extends StatefulWidget {
  final TopicNode root;
  final int maxVisibleDepth;
  final Function(TopicNode)? onNodeTap;
  final Function(TopicNode)? onNodeExpand;

  const VirtualizedTopicTree({
    super.key,
    required this.root,
    this.maxVisibleDepth = -1,
    this.onNodeTap,
    this.onNodeExpand,
  });

  @override
  State<VirtualizedTopicTree> createState() => _VirtualizedTopicTreeState();
}

class _VirtualizedTopicTreeState extends State<VirtualizedTopicTree> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleNodes = widget.root.getVisibleNodes(maxDepth: widget.maxVisibleDepth);

    return ListView.builder(
      controller: _scrollController,
      itemCount: visibleNodes.length,
      itemBuilder: (context, index) {
        final node = visibleNodes[index];
        final depth = _calculateDepth(node);

        return TopicNodeTile(
          node: node,
          depth: depth,
          onTap: () => widget.onNodeTap?.call(node),
          onExpand: () {
            setState(() {
              node.toggleExpanded();
            });
            widget.onNodeExpand?.call(node);
          },
        );
      },
    );
  }

  int _calculateDepth(TopicNode node) {
    int depth = 0;
    String path = node.fullPath;

    while (path.contains('/')) {
      depth++;
      final lastSlash = path.lastIndexOf('/');
      if (lastSlash == -1) break;
      path = path.substring(0, lastSlash);
    }

    return depth;
  }
}

/// Individual tile for a topic node
class TopicNodeTile extends StatelessWidget {
  final TopicNode node;
  final int depth;
  final VoidCallback? onTap;
  final VoidCallback? onExpand;

  const TopicNodeTile({
    super.key,
    required this.node,
    required this.depth,
    this.onTap,
    this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasChildren = node.hasChildren;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: depth * 20.0 + 16.0, right: 16.0),
        height: 48.0,
        child: Row(
          children: [
            // Expansion indicator
            if (hasChildren)
              IconButton(
                icon: Icon(
                  node.isExpanded ? Icons.expand_more : Icons.chevron_right,
                  size: 20.0,
                ),
                onPressed: onExpand,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 24.0,
                  minHeight: 24.0,
                ),
              )
            else
              const SizedBox(width: 24.0),

            // Topic icon
            Icon(
              _getTopicIcon(),
              size: 20.0,
              color: _getTopicColor(theme),
            ),
            const SizedBox(width: 8.0),

            // Topic name
            Expanded(
              child: Text(
                node.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: node.isRetained ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Message count
            if (node.messageCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  node.messageCount.toString(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // Retained indicator
            if (node.isRetained)
              Icon(
                Icons.bookmark,
                size: 16.0,
                color: theme.colorScheme.secondary,
              ),
          ],
        ),
      ),
    );
  }

  IconData _getTopicIcon() {
    if (node.isRetained) return Icons.bookmark_border;
    if (node.hasChildren) return Icons.folder;
    return Icons.article;
  }

  Color _getTopicColor(ThemeData theme) {
    if (node.isRetained) return theme.colorScheme.secondary;
    if (node.hasChildren) return theme.colorScheme.primary;
    return theme.colorScheme.onSurface;
  }
}