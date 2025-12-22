import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/mqtt_providers.dart';
import '../../../core/mqtt/mqtt_service.dart';
import '../../../domain/models/broker_profile.dart';
import '../../../domain/models/subscription.dart';

class ConnectScreen extends ConsumerStatefulWidget {
  const ConnectScreen({super.key});

  @override
  ConsumerState<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends ConsumerState<ConnectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController(text: 'test.mosquitto.org');
  final _portController = TextEditingController(text: '1883');
  final _clientIdController = TextEditingController();
  bool _useTls = false;
  bool _validateCertificates = true;
  bool _autoDetectProtocol = true;
  bool _autoSubscribeAll = false;

  @override
  void initState() {
    super.initState();

    // Listen for MQTT errors and show friendly SnackBar messages
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listen<AsyncValue<String>>(mqttErrorProvider, (prev, next) {
        next.whenData((error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('MQTT error: $error')),
            );
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _clientIdController.dispose();
    super.dispose();
  }

  Widget _buildConnectionButton(MqttConnectionState state) {
    final isConnected = state == MqttConnectionState.connected;
    // Allow user interaction in all non-connected states so they can cancel/force retry if needed

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

    // Prevent connection attempts if already connecting or reconnecting
    if (currentState == MqttConnectionState.connecting ||
        currentState == MqttConnectionState.reconnecting) {
      return;
    }

    // Allow connection attempts from disconnected, error, or disconnecting states
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

      // If requested, auto-subscribe to all topics (#) after successful connection
      if (_autoSubscribeAll) {
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
              protocolVersion == MqttProtocolVersion.v5
                  ? 'MQTT 5.0'
                  : 'MQTT 3.1.1',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _hostController,
                  decoration: const InputDecoration(
                    labelText: 'Host',
                    hintText: 'test.mosquitto.org',
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
                if (_useTls)
                  SwitchListTile(
                    title: const Text('Validate server certificate'),
                    subtitle: const Text('Reject invalid server certificates'),
                    value: _validateCertificates,
                    onChanged: (value) => setState(() => _validateCertificates = value),
                  ),
                SwitchListTile(
                  title: const Text('Auto-detect Protocol'),
                  subtitle: const Text('Try MQTT 5.0, fallback to 3.1.1'),
                  value: _autoDetectProtocol,
                  onChanged: (value) =>
                      setState(() => _autoDetectProtocol = value),
                ),
                SwitchListTile(
                  title: const Text('Subscribe to all topics (#) on connect'),
                  subtitle: const Text('Automatically subscribe to "#" after a successful connection'),
                  value: _autoSubscribeAll,
                  onChanged: (value) => setState(() => _autoSubscribeAll = value),
                ),
                const SizedBox(height: 32),
                connectionState.when(
                data: (state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildConnectionButton(state),
                    const SizedBox(height: 8),
                    if (state == MqttConnectionState.connected)
                      ElevatedButton(
                        onPressed: () => context.go('/topics'),
                        child: const Text('View Topic Tree'),
                      ),
                  ],
                ),
                  // While the provider is initializing, show a usable Connect button
                  loading: () => _buildConnectionButton(MqttConnectionState.disconnected),
                  error: (error, stack) => Text('Error: $error'),
                ),
                const SizedBox(height: 16),
                connectionState.when(
                  data: (state) => Text(
                    'Status: ${state.name}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  loading: () => const Text('Initializing...'),
                  error: (error, stack) => Text('Error: $error'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
