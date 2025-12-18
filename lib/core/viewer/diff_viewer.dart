import 'package:flutter/material.dart';
import 'message_diff.dart';

/// Widget for displaying differences between two message payloads
class DiffViewer extends StatelessWidget {
  final MessageDiff diff;

  const DiffViewer({
    super.key,
    required this.diff,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Diff summary
        _buildDiffSummary(context),

        // Diff content
        Expanded(
          child: ListView.builder(
            itemCount: diff.chunks.length,
            itemBuilder: (context, index) {
              final chunk = diff.chunks[index];
              return _buildDiffLine(context, chunk, index + 1);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDiffSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        children: [
          Icon(
            diff.hasChanges ? Icons.compare_arrows : Icons.check_circle,
            color: diff.hasChanges ? Theme.of(context).colorScheme.primary : Colors.green,
          ),
          const SizedBox(width: 8.0),
          Text(
            diff.hasChanges
                ? '${diff.additions} additions, ${diff.deletions} deletions'
                : 'No changes',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiffLine(BuildContext context, DiffChunk chunk, int lineNumber) {
    Color? backgroundColor;
    Color? textColor;
    String prefix = '';

    switch (chunk.type) {
      case DiffType.added:
        backgroundColor = Colors.green.withOpacity(0.2);
        textColor = Colors.green[800];
        prefix = '+';
        break;
      case DiffType.removed:
        backgroundColor = Colors.red.withOpacity(0.2);
        textColor = Colors.red[800];
        prefix = '-';
        break;
      case DiffType.unchanged:
        backgroundColor = null;
        textColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.7);
        prefix = ' ';
        break;
    }

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
      child: Row(
        children: [
          // Line number
          SizedBox(
            width: 50.0,
            child: Text(
              '$lineNumber',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 8.0),

          // Diff indicator
          SizedBox(
            width: 20.0,
            child: Text(
              prefix,
              style: TextStyle(
                color: textColor,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Content
          Expanded(
            child: Text(
              chunk.content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textColor,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}