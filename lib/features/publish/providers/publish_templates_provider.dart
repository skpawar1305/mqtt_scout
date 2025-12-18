import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../domain/publish_template.dart';

/// Provider for managing publish templates
final publishTemplatesProvider = StateNotifierProvider<PublishTemplatesNotifier, List<PublishTemplate>>((ref) {
  return PublishTemplatesNotifier();
});

class PublishTemplatesNotifier extends StateNotifier<List<PublishTemplate>> {
  static const String _storageKey = 'publish_templates';

  PublishTemplatesNotifier() : super([]) {
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final templatesJson = prefs.getStringList(_storageKey) ?? [];

      final templates = templatesJson
          .map((json) => PublishTemplate.fromJson(jsonDecode(json)))
          .toList();

      state = templates;
    } catch (e) {
      // If loading fails, start with empty list
      state = [];
    }
  }

  Future<void> _saveTemplates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final templatesJson = state
          .map((template) => jsonEncode(template.toJson()))
          .toList();

      await prefs.setStringList(_storageKey, templatesJson);
    } catch (e) {
      // Silently fail - templates will be lost on restart
    }
  }

  Future<void> addTemplate(PublishTemplate template) async {
    final newTemplate = template.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
    );

    state = [...state, newTemplate];
    await _saveTemplates();
  }

  Future<void> updateTemplate(String id, PublishTemplate updatedTemplate) async {
    state = state.map((template) {
      return template.id == id ? updatedTemplate : template;
    }).toList();
    await _saveTemplates();
  }

  Future<void> removeTemplate(String id) async {
    state = state.where((template) => template.id != id).toList();
    await _saveTemplates();
  }

  PublishTemplate? getTemplate(String id) {
    return state.where((template) => template.id == id).firstOrNull;
  }

  List<PublishTemplate> searchTemplates(String query) {
    if (query.isEmpty) return state;

    final lowercaseQuery = query.toLowerCase();
    return state.where((template) {
      return template.name.toLowerCase().contains(lowercaseQuery) ||
             template.topic.toLowerCase().contains(lowercaseQuery) ||
             template.payload.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}