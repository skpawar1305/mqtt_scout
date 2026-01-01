import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/tree/topic_filter.dart';

class TopicFilterNotifier extends StateNotifier<TopicFilter> {
  TopicFilterNotifier() : super(const TopicFilter());

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void toggleRegex() {
    state = state.copyWith(isRegex: !state.isRegex);
  }

  void toggleRetainedOnly() {
    state = state.copyWith(showRetainedOnly: !state.showRetainedOnly);
  }
}

final topicFilterProvider = StateNotifierProvider<TopicFilterNotifier, TopicFilter>((ref) {
  return TopicFilterNotifier();
});
