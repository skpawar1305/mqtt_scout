/// Represents the type of difference in a diff chunk
enum DiffType {
  added,
  removed,
  unchanged,
}

/// A chunk of text that has been added, removed, or unchanged
class DiffChunk {
  final DiffType type;
  final String content;

  const DiffChunk({
    required this.type,
    required this.content,
  });
}

/// Result of computing differences between two payloads
class MessageDiff {
  final List<DiffChunk> chunks;
  final int additions;
  final int deletions;

  const MessageDiff({
    required this.chunks,
    required this.additions,
    required this.deletions,
  });

  /// Compute differences between two payloads using a simple diff algorithm
  static MessageDiff compute(String oldPayload, String newPayload) {
    final oldLines = oldPayload.split('\n');
    final newLines = newPayload.split('\n');

    final chunks = <DiffChunk>[];
    int additions = 0;
    int deletions = 0;

    // Simple line-by-line diff (could be enhanced with Myers algorithm)
    final maxLines = oldLines.length > newLines.length ? oldLines.length : newLines.length;

    for (int i = 0; i < maxLines; i++) {
      final oldLine = i < oldLines.length ? oldLines[i] : null;
      final newLine = i < newLines.length ? newLines[i] : null;

      if (oldLine == null && newLine != null) {
        // Line added
        chunks.add(DiffChunk(type: DiffType.added, content: newLine));
        additions++;
      } else if (oldLine != null && newLine == null) {
        // Line removed
        chunks.add(DiffChunk(type: DiffType.removed, content: oldLine));
        deletions++;
      } else if (oldLine != newLine) {
        // Line changed (show as remove + add)
        if (oldLine!.isNotEmpty) {
          chunks.add(DiffChunk(type: DiffType.removed, content: oldLine));
          deletions++;
        }
        if (newLine!.isNotEmpty) {
          chunks.add(DiffChunk(type: DiffType.added, content: newLine));
          additions++;
        }
      } else {
        // Line unchanged
        chunks.add(DiffChunk(type: DiffType.unchanged, content: oldLine!));
      }
    }

    return MessageDiff(
      chunks: chunks,
      additions: additions,
      deletions: deletions,
    );
  }

  /// Check if there are any differences
  bool get hasChanges => additions > 0 || deletions > 0;
}