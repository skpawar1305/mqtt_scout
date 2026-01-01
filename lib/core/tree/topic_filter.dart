import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_filter.freezed.dart';

@freezed
class TopicFilter with _$TopicFilter {
  const factory TopicFilter({
    @Default('') String query,
    @Default(false) bool isRegex,
    @Default(false) bool showRetainedOnly,
    @Default(false) bool showActiveOnly, // Future use
  }) = _TopicFilter;

  const TopicFilter._();

  bool get isEmpty => query.isEmpty && !showRetainedOnly && !showActiveOnly;

  bool matches(String name, String fullPath, {bool isRetained = false}) {
    if (showRetainedOnly && !isRetained) return false;

    if (query.isEmpty) return true;

    if (isRegex) {
      try {
        final regex = RegExp(query, caseSensitive: false);
        return regex.hasMatch(name) || regex.hasMatch(fullPath);
      } catch (_) {
        return false; // Invalid regex
      }
    } else {
      final q = query.toLowerCase();
      return name.toLowerCase().contains(q) || fullPath.toLowerCase().contains(q);
    }
  }
}
