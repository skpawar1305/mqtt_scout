import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/mqtt_providers.dart';
import '../../../core/mqtt/models/mqtt_connection_state.dart';
import '../../../domain/models/broker_profile.dart';
import '../../../domain/models/subscription.dart';

class ConnectionPanel extends ConsumerStatefulWidget {
  const ConnectionPanel({super.key});

  @override
  ConsumerState<ConnectionPanel> createState() => _ConnectionPanelState();
}

class _ConnectionPanelState extends ConsumerState<ConnectionPanel> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController(text: 'test.mosquitto.org');
  final _portController = TextEditingController(text: '1883');
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _clientIdController = TextEditingController(
    text: 'mqtt_scout_${DateTime.now().millisecondsSinceEpoch}',
  );
  bool _useTls = false;
  bool _validateCertificates = true;
  bool _autoDetectProtocol = true;
  MqttScheme _scheme = MqttScheme.tcp;

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _clientIdController.dispose();
    super.dispose();
  }

  Widget _buildConnectionButton(MqttConnectionState state) {
    final isConnected = state == MqttConnectionState.connected;
    
    return ElevatedButton(
      onPressed: _handleConnectionToggle,
      style: ElevatedButton.styleFrom(
        backgroundColor: isConnected ? Colors.red : Colors.green,
        foregroundColor: Colors.white,
      ),
      child: Text(isConnected ? 'Disconnect' : 'Connect'),
    );
  }

  Future<void> _handleConnectionToggle() async {
    final connectionManager = ref.read(connectionManagerProvider);

    final currentState = ref.read(connectionStateProvider).value;
    if (currentState == MqttConnectionState.connected) {
      await connectionManager.disconnect();
      return;
    }

    if (currentState == MqttConnectionState.connecting ||
        currentState == MqttConnectionState.reconnecting) {
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    final profile = BrokerProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '${_hostController.text}:${_portController.text}',
      host: _hostController.text,
      port: int.parse(_portController.text),
      useTls: _useTls,
      clientId: _clientIdController.text,
      username: _usernameController.text.isEmpty ? null : _usernameController.text,
      password: _passwordController.text.isEmpty ? null : _passwordController.text,
      validateCertificates: _validateCertificates,
      protocolVersion: MqttProtocolVersion.v5, // Default, will auto-detect if enabled
      autoDetectProtocol: _autoDetectProtocol,
      scheme: _scheme,
    );

    try {
      await connectionManager.connect(profile);

      // Always auto-subscribe to #
      try {
        final subscriptionManager = ref.read(subscriptionManagerProvider);
        final sub = Subscription(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          topic: '#',
          qos: 0,
          noLocal: false,
        );
        await subscriptionManager.subscribe(sub);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Subscribed to all topics (#)')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Auto-subscribe failed: $e')),
          );
        }
      }

      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Connection failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<String>>(mqttErrorProvider, (prev, next) {
      next.whenData((error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('MQTT error: $error')),
          );
        }
      });
    });

    final connectionState = ref.watch(connectionStateProvider);
    final protocolVersion = ref.watch(protocolVersionProvider);

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Row(
            children: [
              const Text('Connection', style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: protocolVersion == MqttProtocolVersion.v5
                      ? Colors.blue
                      : Colors.orange,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  protocolVersion == MqttProtocolVersion.v5
                      ? 'MQTT 5.0'
                      : 'MQTT 3.1.1',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
        
        // Form
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<MqttScheme>(
                    value: _scheme,
                    decoration: const InputDecoration(
                      labelText: 'Connection Scheme',
                      isDense: true,
                    ),
                    items: MqttScheme.values.map((scheme) {
                      return DropdownMenuItem(
                        value: scheme,
                        child: Text(scheme.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _scheme = value);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _hostController,
                    decoration: const InputDecoration(
                      labelText: 'Host',
                      hintText: 'test.mosquitto.org',
                      isDense: true,
                    ),
                    validator: (value) =>
                        value?.isEmpty == true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _portController,
                    decoration: const InputDecoration(
                      labelText: 'Port',
                      hintText: '1883',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value?.isEmpty == true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Optional',
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Optional',
                      isDense: true,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _clientIdController,
                    decoration: const InputDecoration(
                      labelText: 'Client ID',
                      hintText: 'Auto-generated',
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Use TLS'),
                    value: _useTls,
                    onChanged: (value) => setState(() => _useTls = value),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  if (_useTls)
                    SwitchListTile(
                      title: const Text('Validate Certs'),
                      value: _validateCertificates,
                      onChanged: (value) => setState(() => _validateCertificates = value),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  SwitchListTile(
                    title: const Text('Auto-detect'),
                    value: _autoDetectProtocol,
                    onChanged: (value) =>
                        setState(() => _autoDetectProtocol = value),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Footer
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: connectionState.when(
            data: (state) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildConnectionButton(state),
                const SizedBox(height: 8),
                Text(
                  state.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error', style: const TextStyle(color: Colors.red)),
          ),
        ),
      ],
    );
  }
}
