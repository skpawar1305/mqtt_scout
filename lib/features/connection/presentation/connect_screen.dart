import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/mqtt_providers.dart';
import '../../../core/mqtt/mqtt_service.dart';
import '../../../domain/models/broker_profile.dart';

class ConnectScreen extends ConsumerStatefulWidget {
  const ConnectScreen({super.key});

  @override
  ConsumerState<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends ConsumerState<ConnectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController(text: 'broker.hivemq.com');
  final _portController = TextEditingController(text: '1883');
  final _clientIdController = TextEditingController();
  bool _useTls = false;
  bool _autoDetectProtocol = true;

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _clientIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectionState = ref.watch(connectionStateProvider);
    final protocolVersion = ref.watch(protocolVersionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MQTT Connection'),
        actions: [
          // Protocol version indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: protocolVersion == MqttProtocolVersion.v5
                  ? Colors.blue
                  : Colors.orange,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              protocolVersion == MqttProtocolVersion.v5 ? 'MQTT 5.0' : 'MQTT 3.1.1',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _hostController,
                decoration: const InputDecoration(
                  labelText: 'Host',
                  hintText: 'broker.hivemq.com',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a host';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _portController,
                decoration: const InputDecoration(
                  labelText: 'Port',
                  hintText: '1883',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a port';
                  }
                  final port = int.tryParse(value);
                  if (port == null || port < 1 || port > 65535) {
                    return 'Please enter a valid port (1-65535)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _clientIdController,
                decoration: const InputDecoration(
                  labelText: 'Client ID (optional)',
                  hintText: 'Auto-generated if empty',
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Use TLS'),
                value: _useTls,
                onChanged: (value) => setState(() => _useTls = value),
              ),
              SwitchListTile(
                title: const Text('Auto-detect Protocol'),
                subtitle: const Text('Try MQTT 5.0, fallback to 3.1.1'),
                value: _autoDetectProtocol,
                onChanged: (value) => setState(() => _autoDetectProtocol = value),
              ),
              const SizedBox(height: 32),
              connectionState.when(
                data: (state) => _buildConnectionButton(state),
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error: $error'),
              ),
              const SizedBox(height: 16),
              connectionState.when(
                data: (state) => Text(
                  'Status: ${state.name}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                loading: () => const Text('Connecting...'),
                error: (error, stack) => Text('Error: $error'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionButton(MqttConnectionState state) {
    final isConnected = state == MqttConnectionState.connected;
    final isConnecting = state == MqttConnectionState.connecting;

    return ElevatedButton(
      onPressed: isConnecting ? null : _handleConnectionToggle,
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

    if (!_formKey.currentState!.validate()) return;

    final profile = BrokerProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '${_hostController.text}:${_portController.text}',
      host: _hostController.text,
      port: int.parse(_portController.text),
      useTls: _useTls,
      clientId: _clientIdController.text.isNotEmpty
          ? _clientIdController.text
          : 'mqtt_scout_${DateTime.now().millisecondsSinceEpoch}',
      autoDetectProtocol: _autoDetectProtocol,
    );

    try {
      await connectionManager.connect(profile);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connection failed: $e')),
        );
      }
    }
  }
}