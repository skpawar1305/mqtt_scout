class TopicMatcher {
  static bool matches(String topic, String filter) {
    // Split topics into levels
    final topicLevels = topic.split('/');
    final filterLevels = filter.split('/');

    // If lengths don't match and filter doesn't end with #, no match
    if (topicLevels.length != filterLevels.length && !filter.endsWith('#')) {
      return false;
    }

    for (int i = 0; i < filterLevels.length; i++) {
      final filterLevel = filterLevels[i];

      if (filterLevel == '#') {
        // Multi-level wildcard - matches everything from here
        return true;
      }

      if (filterLevel == '+') {
        // Single-level wildcard - matches any single level
        continue;
      }

      if (i >= topicLevels.length) {
        return false;
      }

      final topicLevel = topicLevels[i];
      if (topicLevel != filterLevel) {
        return false;
      }
    }

    return true;
  }

  static List<String> extractMatchedTopics(List<String> topics, String filter) {
    return topics.where((topic) => matches(topic, filter)).toList();
  }

  static bool isValidFilter(String filter) {
    if (filter.isEmpty) return false;

    final levels = filter.split('/');

    // Check for invalid wildcard usage
    for (int i = 0; i < levels.length; i++) {
      final level = levels[i];

      if (level.contains('#')) {
        // # can only be used alone and must be the last level
        if (level != '#' || i != levels.length - 1) {
          return false;
        }
      }

      if (level.contains('+')) {
        // + can only be used alone in a level
        if (level != '+') {
          return false;
        }
      }
    }

    return true;
  }

  static List<String> expandFilter(String filter) {
    // For UI purposes, could expand a filter to show possible matches
    // This is a simplified implementation
    if (!filter.contains('#') && !filter.contains('+')) {
      return [filter];
    }

    // For now, just return the filter itself
    return [filter];
  }
}