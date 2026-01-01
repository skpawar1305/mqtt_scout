import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/providers/mqtt_providers.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../tree/presentation/topic_tree_panel.dart';
import '../../../viewer/presentation/message_viewer_panel.dart';
import '../../../publish/presentation/publish_panel.dart';

class MobileHome extends ConsumerStatefulWidget {
  const MobileHome({super.key});

  @override
  ConsumerState<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends ConsumerState<MobileHome> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    TopicTreePanel(),
    PublishPanel(),
    MessageViewerPanel(),
  ];

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
                onPressed: () {
                  final newMode = themeMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                  ref.read(themeModeProvider.notifier).state = newMode;
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(connectionManagerProvider).disconnect();
              if (context.mounted) {
                context.go('/');
              }
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(LucideIcons.listTree),
            label: 'Explorer',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.send),
            label: 'Publish',
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.fileText),
            label: 'Viewer',
          ),
        ],
      ),
    );
  }
}
