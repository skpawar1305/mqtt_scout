import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/topic_tree_filter_provider.dart';

class TopicTreeSearchBar extends ConsumerWidget {
  const TopicTreeSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(topicFilterProvider);
    final notifier = ref.read(topicFilterProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
                height: 36,
                child: TextField(
                  onChanged: notifier.setQuery,
                  decoration: InputDecoration(
                    hintText: 'Search topics...',
                    prefixIcon: const Icon(Icons.search, size: 18),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
            ),
          ),
          const SizedBox(width: 4),
          // Regex Toggle
          IconButton(
            icon: Text(
                '.*', 
                style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: filter.isRegex ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor,
                )
            ),
            onPressed: notifier.toggleRegex,
            tooltip: 'Use Regex',
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
          ),
          // Retained Toggle
          IconButton(
            icon: Icon(
                Icons.save, 
                size: 18,
                color: filter.showRetainedOnly ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor,
            ),
            onPressed: notifier.toggleRetainedOnly,
            tooltip: 'Show Retained Only',
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}
