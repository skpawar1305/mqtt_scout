import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/mqtt/mqtt_service.dart';
import '../../../core/providers/mqtt_providers.dart';
import '../../../domain/models/broker_profile.dart';
import '../../../core/providers/tree_providers.dart';
import '../domain/publish_template.dart';
import '../providers/publish_templates_provider.dart';
import 'template_manager.dart';

/// Publish panel for sending MQTT messages
class PublishPanel extends ConsumerStatefulWidget {
  const PublishPanel({super.key});

  @override
  ConsumerState<PublishPanel> createState() => _PublishPanelState();
}

class _PublishPanelState extends ConsumerState<PublishPanel> {
  final _topicController = TextEditingController();
  final _payloadController = TextEditingController();
  int _qos = 0;
  bool _retain = false;

  // MQTT 5.0 properties
  String? _contentType;
  String? _responseTopic;
  int? _messageExpiryInterval;
  final Map<String, String> _userProperties = {};

  @override
  void dispose() {
    _topicController.dispose();
    _payloadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mqttService = ref.watch(mqttServiceProvider);
    final isConnected = mqttService.isConnected;
    final protocolVersion = mqttService.negotiatedVersion;

    return Container(
      padding: const EdgeInsets.all(16.0),
      constraints: const BoxConstraints(maxHeight: 600),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.send),
              const SizedBox(width: 8.0),
              Text(
                'Publish Message',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              // Template buttons
              IconButton(
                icon: const Icon(Icons.bookmark_add),
                onPressed: _saveAsTemplate,
                tooltip: 'Save as Template',
              ),
              IconButton(
                icon: const Icon(Icons.bookmark),
                onPressed: _loadTemplate,
                tooltip: 'Load Template',
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Close',
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Topic input with autocomplete
          Autocomplete<String>(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) return [];
              final tree = ref.read(topicTreeProvider);
              return tree.getAllTopics()
                  .where((topic) =>
                      topic.toLowerCase().contains(textEditingValue.text.toLowerCase()))
                  .take(10) // Limit suggestions
                  .toList();
            },
            onSelected: (topic) {
              _topicController.text = topic;
            },
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  labelText: 'Topic',
                  hintText: 'e.g., sensors/temperature',
                  border: OutlineInputBorder(),
                ),
                enabled: isConnected,
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    width: MediaQuery.of(context).size.width - 32,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final topic = options.elementAt(index);
                        return ListTile(
                          title: Text(topic),
                          onTap: () => onSelected(topic),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16.0),

          // Payload editor
          TextField(
            controller: _payloadController,
            decoration: const InputDecoration(
              labelText: 'Payload',
              hintText: 'Enter message payload (JSON, text, etc.)',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
            enabled: isConnected,
          ),
          const SizedBox(height: 16.0),

          // Basic options
          Row(
            children: [
              // QoS selector
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _qos,
                  decoration: const InputDecoration(
                    labelText: 'QoS',
                    border: OutlineInputBorder(),
                  ),
                  items: [0, 1, 2].map((qos) => DropdownMenuItem(
                    value: qos,
                    child: Text('QoS $qos'),
                  )).toList(),
                  onChanged: isConnected ? (qos) => setState(() => _qos = qos!) : null,
                ),
              ),
              const SizedBox(width: 16.0),

              // Retain checkbox
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Retain'),
                  value: _retain,
                  onChanged: isConnected ? (retain) => setState(() => _retain = retain ?? false) : null,
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // MQTT 5.0 properties (conditional)
          if (protocolVersion == MqttProtocolVersion.v5) ...[
            const Divider(),
            Text(
              'MQTT 5.0 Properties',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            // Content Type
            TextField(
              decoration: const InputDecoration(
                labelText: 'Content Type',
                hintText: 'e.g., application/json',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _contentType = value.isEmpty ? null : value),
              enabled: isConnected,
            ),
            const SizedBox(height: 8.0),

            // Response Topic
            TextField(
              decoration: const InputDecoration(
                labelText: 'Response Topic',
                hintText: 'Topic for responses',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _responseTopic = value.isEmpty ? null : value),
              enabled: isConnected,
            ),
            const SizedBox(height: 8.0),

            // Message Expiry
            TextField(
              decoration: const InputDecoration(
                labelText: 'Message Expiry (seconds)',
                hintText: 'Time until message expires',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() =>
                _messageExpiryInterval = value.isEmpty ? null : int.tryParse(value)),
              enabled: isConnected,
            ),
            const SizedBox(height: 8.0),

            // User Properties
            ExpansionTile(
              title: const Text('User Properties'),
              children: [
                ..._userProperties.entries.map((entry) => ListTile(
                  title: Text('${entry.key}: ${entry.value}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => setState(() => _userProperties.remove(entry.key)),
                  ),
                )),
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Add Property'),
                  onTap: _showAddPropertyDialog,
                ),
              ],
            ),
          ],

          const SizedBox(height: 16.0),

          // Publish button
          ElevatedButton.icon(
            onPressed: isConnected ? _publish : null,
            icon: const Icon(Icons.send),
            label: const Text('Publish'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
          ),

          // Connection status
          if (!isConnected) ...[
            const SizedBox(height: 8.0),
            Text(
              'Connect to a broker to publish messages',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _publish() async {
    if (_topicController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a topic')),
      );
      return;
    }

    try {
      final mqttService = ref.read(mqttServiceProvider);

      await mqttService.publish(
        _topicController.text,
        _payloadController.text,
        qos: _qos,
        retain: _retain,
        contentType: _contentType,
        responseTopic: _responseTopic,
        messageExpiryInterval: _messageExpiryInterval,
        userProperties: _userProperties.isNotEmpty ? _userProperties : null,
      );

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Message published to ${_topicController.text}'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );

        // Close the panel
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to publish: $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _showAddPropertyDialog() {
    String? key;
    String? value;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add User Property'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Key'),
              onChanged: (v) => key = v,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Value'),
              onChanged: (v) => value = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (key?.isNotEmpty == true && value?.isNotEmpty == true) {
                setState(() => _userProperties[key!] = value!);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _saveAsTemplate() {
    if (_topicController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Topic is required to save template')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => TemplateDialog(
        onSave: (template) {
          ref.read(publishTemplatesProvider.notifier).addTemplate(template);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Template "${template.name}" saved')),
          );
        },
      ),
    );
  }

  void _loadTemplate() async {
    final template = await showDialog<PublishTemplate>(
      context: context,
      builder: (context) => const TemplateManager(),
    );

    if (template != null && mounted) {
      setState(() {
        _topicController.text = template.topic;
        _payloadController.text = template.payload;
        _qos = template.qos;
        _retain = template.retain;

        // Load MQTT 5.0 properties if available
        if (template.contentType != null) {
          _contentType = template.contentType;
        }
        if (template.responseTopic != null) {
          _responseTopic = template.responseTopic;
        }
        if (template.messageExpiryInterval != null) {
          _messageExpiryInterval = template.messageExpiryInterval;
        }
        if (template.userProperties != null) {
          _userProperties.clear();
          _userProperties.addAll(template.userProperties!);
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Template "${template.name}" loaded')),
      );
    }
  }
}