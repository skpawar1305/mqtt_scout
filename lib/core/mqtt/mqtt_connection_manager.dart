import 'dart:async';
import 'mqtt_service.dart';
import '../../domain/models/broker_profile.dart';

class MqttConnectionManager {
  final IMqttClient _client;
  Timer? _reconnectTimer;
  bool _shouldReconnect = true;

  MqttConnectionManager(this._client);

  Stream<ConnectionState> get connectionStateStream => _client.connectionStateStream;

  Future<void> connect(BrokerProfile profile) async {
    _shouldReconnect = true;
    await _client.connect(profile);
  }

  Future<void> disconnect() async {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    await _client.disconnect();
  }

  void _scheduleReconnect(BrokerProfile profile) {
    if (!_shouldReconnect || _client.isConnected) return;

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () async {
      try {
        await _client.connect(profile);
      } catch (e) {
        // Will retry again
        _scheduleReconnect(profile);
      }
    });
  }

  void dispose() {
    _reconnectTimer?.cancel();
    _shouldReconnect = false;
  }
}