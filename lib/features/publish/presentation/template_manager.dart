import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/broker_profile.dart';
import '../../../core/providers/mqtt_providers.dart';
import '../domain/publish_template.dart';
import '../providers/publish_templates_provider.dart';

/// Widget for managing publish templates
class TemplateManager extends ConsumerWidget {
  const TemplateManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(publishTemplatesProvider);
    final protocolVersion = ref.watch(mqttServiceProvider.select(
      (s) => s.negotiatedVersion,
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Publish Templates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateTemplateDialog(context, ref),
            tooltip: 'Create Template',
          ),
        ],
      ),
      body: templates.isEmpty
          ? _buildEmptyState(context, ref)
          : _buildTemplatesList(context, templates, protocolVersion, ref),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16.0),
          Text(
            'No templates yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Save frequently used messages as templates',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          ElevatedButton.icon(
            onPressed: () => _showCreateTemplateDialog(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Create First Template'),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesList(
    BuildContext context,
    List<PublishTemplate> templates,
    MqttProtocolVersion protocolVersion,
    WidgetRef ref,
  ) {
    return ListView.builder(
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];

        // Show warning if template has MQTT 5 props but connected as 3.1.1
        final hasV5Props = template.contentType != null ||
            template.responseTopic != null ||
            template.messageExpiryInterval != null ||
            (template.userProperties?.isNotEmpty ?? false);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text(template.name),
                ),
                if (hasV5Props) ...[
                  const SizedBox(width: 8.0),
                  Icon(
                    Icons.filter_5,
                    size: 16.0,
                    color: protocolVersion == MqttProtocolVersion.v5
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.error,
                  ),
                ],
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.topic,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (hasV5Props &&
                    protocolVersion == MqttProtocolVersion.v3_1_1)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'MQTT 5.0 properties will be ignored',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
              ],
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                template.qos.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'use':
                    _useTemplate(context, template);
                    break;
                  case 'edit':
                    _showEditTemplateDialog(context, ref, template);
                    break;
                  case 'duplicate':
                    _duplicateTemplate(ref, template);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, ref, template);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'use',
                  child: Row(
                    children: [
                      Icon(Icons.send),
                      SizedBox(width: 8.0),
                      Text('Use Template'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8.0),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'duplicate',
                  child: Row(
                    children: [
                      Icon(Icons.copy),
                      SizedBox(width: 8.0),
                      Text('Duplicate'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8.0),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () => _useTemplate(context, template),
          ),
        );
      },
    );
  }

  void _useTemplate(BuildContext context, PublishTemplate template) {
    // Return the template to the caller (publish panel)
    Navigator.of(context).pop(template);
  }

  void _showCreateTemplateDialog(BuildContext context, WidgetRef ref) {
    _showTemplateDialog(context, ref, null);
  }

  void _showEditTemplateDialog(BuildContext context, WidgetRef ref, PublishTemplate template) {
    _showTemplateDialog(context, ref, template);
  }

  void _showTemplateDialog(BuildContext context, WidgetRef ref, PublishTemplate? template) {
    showDialog(
      context: context,
      builder: (context) => TemplateDialog(
        template: template,
        onSave: (newTemplate) {
          if (template == null) {
            ref.read(publishTemplatesProvider.notifier).addTemplate(newTemplate);
          } else {
            ref.read(publishTemplatesProvider.notifier).updateTemplate(template.id, newTemplate);
          }
        },
      ),
    );
  }

  void _duplicateTemplate(WidgetRef ref, PublishTemplate template) {
    final duplicated = template.copyWith(
      id: '', // Will be set by the provider
      name: '${template.name} (Copy)',
      createdAt: null, // Will be set by the provider
    );
    ref.read(publishTemplatesProvider.notifier).addTemplate(duplicated);
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, PublishTemplate template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Template'),
        content: Text('Are you sure you want to delete "${template.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(publishTemplatesProvider.notifier).removeTemplate(template.id);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Dialog for creating/editing templates
class TemplateDialog extends StatefulWidget {
  final PublishTemplate? template;
  final Function(PublishTemplate) onSave;

  const TemplateDialog({
    super.key,
    this.template,
    required this.onSave,
  });

  @override
  State<TemplateDialog> createState() => _TemplateDialogState();
}

class _TemplateDialogState extends State<TemplateDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _topicController;
  late final TextEditingController _payloadController;
  late int _qos;
  late bool _retain;

  // MQTT 5.0 properties
  late final TextEditingController _contentTypeController;
  late final TextEditingController _responseTopicController;
  late final TextEditingController _messageExpiryController;
  final Map<String, String> _userProperties = {};

  @override
  void initState() {
    super.initState();
    final template = widget.template;

    _nameController = TextEditingController(text: template?.name ?? '');
    _topicController = TextEditingController(text: template?.topic ?? '');
    _payloadController = TextEditingController(text: template?.payload ?? '');
    _qos = template?.qos ?? 0;
    _retain = template?.retain ?? false;

    _contentTypeController = TextEditingController(text: template?.contentType ?? '');
    _responseTopicController = TextEditingController(text: template?.responseTopic ?? '');
    _messageExpiryController = TextEditingController(text: template?.messageExpiryInterval?.toString() ?? '');

    if (template?.userProperties != null) {
      _userProperties.addAll(template!.userProperties!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _topicController.dispose();
    _payloadController.dispose();
    _contentTypeController.dispose();
    _responseTopicController.dispose();
    _messageExpiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.template != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Template' : 'Create Template'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Template name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Template Name',
                hintText: 'e.g., Sensor Reading',
              ),
            ),
            const SizedBox(height: 16.0),

            // Topic
            TextField(
              controller: _topicController,
              decoration: const InputDecoration(
                labelText: 'Topic',
                hintText: 'e.g., sensors/temperature',
              ),
            ),
            const SizedBox(height: 16.0),

            // Payload
            TextField(
              controller: _payloadController,
              decoration: const InputDecoration(
                labelText: 'Payload',
                hintText: 'Message payload',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),

            // QoS and Retain
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: _qos,
                    decoration: const InputDecoration(labelText: 'QoS'),
                    items: [0, 1, 2].map((qos) => DropdownMenuItem(
                      value: qos,
                      child: Text('QoS $qos'),
                    )).toList(),
                    onChanged: (qos) => setState(() => _qos = qos!),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Retain'),
                    value: _retain,
                    onChanged: (retain) => setState(() => _retain = retain ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _saveTemplate,
          child: Text(isEditing ? 'Save' : 'Create'),
        ),
      ],
    );
  }

  void _saveTemplate() {
    if (_nameController.text.isEmpty || _topicController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and topic are required')),
      );
      return;
    }

    final template = PublishTemplate(
      id: widget.template?.id ?? '',
      name: _nameController.text,
      topic: _topicController.text,
      payload: _payloadController.text,
      qos: _qos,
      retain: _retain,
      contentType: _contentTypeController.text.isEmpty ? null : _contentTypeController.text,
      responseTopic: _responseTopicController.text.isEmpty ? null : _responseTopicController.text,
      messageExpiryInterval: _messageExpiryController.text.isEmpty
          ? null
          : int.tryParse(_messageExpiryController.text),
      userProperties: _userProperties.isNotEmpty ? Map.from(_userProperties) : null,
    );

    widget.onSave(template);
    Navigator.of(context).pop();
  }
}