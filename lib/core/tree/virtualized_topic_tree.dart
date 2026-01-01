import 'package:flutter/material.dart';
import 'topic_node.dart';
import 'topic_filter.dart';

/// Efficient virtualized tree view for large topic hierarchies
class VirtualizedTopicTree extends StatefulWidget {
  final TopicNode root;
  final int maxVisibleDepth;
  final TopicFilter? filter;
  final Function(TopicNode)? onNodeTap;
  final Function(TopicNode)? onNodeExpand;

  const VirtualizedTopicTree({
    super.key,
    required this.root,
    this.maxVisibleDepth = -1,
    this.filter,
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
    final visibleNodes = widget.root.getVisibleNodes(maxDepth: widget.maxVisibleDepth, filter: widget.filter);

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
    
    // Calculate indentation
    final indent = depth * 16.0;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 28.0, // Compact height like MQTT Explorer
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor.withOpacity(0.1),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: indent),
            
            // Expansion indicator
            if (hasChildren)
              InkWell(
                onTap: onExpand,
                child: Icon(
                  node.isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                  size: 18.0,
                  color: theme.iconTheme.color?.withOpacity(0.7),
                ),
              )
            else
              const SizedBox(width: 18.0),

            const SizedBox(width: 4.0),

            // Topic Name
            Expanded(
              flex: 2,
              child: Text(
                node.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: node.isRetained ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Value Preview (if leaf or has message)
            if (node.lastMessage != null) ...[
              const SizedBox(width: 8.0),
              Expanded(
                flex: 3,
                child: Text(
                  node.lastMessage!.payload,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                ),
              ),
            ],

            // Message count / Retained flag
            const SizedBox(width: 8.0),
            if (node.isRetained)
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Icon(
                  Icons.save,
                  size: 12.0,
                  color: theme.colorScheme.secondary,
                ),
              ),
              
            if (node.messageCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  node.messageCount.toString(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}