import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/mqtt_providers.dart';
import '../../../core/providers/theme_provider.dart';
import '../../tree/presentation/topic_tree_panel.dart';
import '../../viewer/presentation/message_viewer_panel.dart';
import '../../publish/presentation/publish_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MQTT Scout'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final themeMode = ref.watch(themeModeProvider);
              return IconButton(
                icon: Icon(
                  themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : themeMode == ThemeMode.dark
                          ? Icons.light_mode
                          : Icons.brightness_auto,
                ),
                tooltip: 'Toggle Theme',
                onPressed: () {
                  final newMode = themeMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                  ref.read(themeModeProvider.notifier).state = newMode;
                },
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Disconnect',
                onPressed: () async {
                  await ref.read(connectionManagerProvider).disconnect();
                  if (context.mounted) {
                    context.go('/');
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SplitView(
        viewMode: SplitViewMode.Horizontal,
        indicator: const SplitIndicator(viewMode: SplitViewMode.Horizontal),
        activeIndicator: const SplitIndicator(
          viewMode: SplitViewMode.Horizontal,
          isActive: true,
        ),
        controller: SplitViewController(
          limits: [
            WeightLimit(min: 0.2, max: 0.5), // Topic Tree
            WeightLimit(min: 0.5, max: 0.8), // Right Pane
          ],
        ),
        children: [
          const TopicTreePanel(),
          SplitView(
            viewMode: SplitViewMode.Vertical,
            indicator: const SplitIndicator(viewMode: SplitViewMode.Vertical),
            activeIndicator: const SplitIndicator(
              viewMode: SplitViewMode.Vertical,
              isActive: true,
            ),
            controller: SplitViewController(
              limits: [
                WeightLimit(min: 0.3, max: 0.7), // Message Viewer
                WeightLimit(min: 0.3, max: 0.7), // Publish Panel
              ],
            ),
            children: const [
              MessageViewerPanel(),
              PublishPanel(),
            ],
          ),
        ],
      ),
    );
  }
}
