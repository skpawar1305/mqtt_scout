import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/theme_provider.dart';
import 'connection_panel.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect'),
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
        ],
      ),
      body: const ConnectionPanel(),
    );
  }
}
