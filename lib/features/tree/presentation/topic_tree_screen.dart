import 'package:flutter/material.dart';
import 'topic_tree_panel.dart';

class TopicTreeScreen extends StatelessWidget {
  const TopicTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Topic Tree')),
      body: const TopicTreePanel(),
    );
  }
}