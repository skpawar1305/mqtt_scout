import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/connection/presentation/connect_screen.dart';
import '../features/tree/presentation/topic_tree_screen.dart';

// Placeholder screens - will be implemented in features
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MQTT Scout')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to MQTT Scout'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/connect'),
              child: const Text('Connect to Broker'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/topics'),
              child: const Text('View Topic Tree'),
            ),
          ],
        ),
      ),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/connect',
        builder: (context, state) => const ConnectScreen(),
      ),
      GoRoute(
        path: '/topics',
        builder: (context, state) => const TopicTreeScreen(),
      ),
    ],
  );
});