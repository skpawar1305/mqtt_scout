import 'dart:async';
import 'i_mqtt_client.dart';
import 'models/mqtt_connection_state.dart';
import '../../domain/models/broker_profile.dart';
import 'utils/reconnection_strategy.dart';

class MqttConnectionManager {
  final IMqttClient _client;
  final ReconnectionStrategy _reconnectionStrategy;
  Timer? _reconnectTimer;
  bool _shouldReconnect = true;
  int _reconnectAttempts = 0;
  BrokerProfile? _lastProfile;

  MqttConnectionManager(
    this._client, {
    ReconnectionStrategy? reconnectionStrategy,
  }) : _reconnectionStrategy = reconnectionStrategy ?? ReconnectionStrategy() {
    // Listen to connection state changes to trigger reconnection
    _client.connectionStateStream.listen((state) {
      if (state == MqttConnectionState.disconnected && _shouldReconnect && _lastProfile != null) {
        _scheduleReconnect();
      }
    });
  }

  Stream<MqttConnectionState> get connectionStateStream => _client.connectionStateStream;

  Future<void> connect(BrokerProfile profile) async {
    _lastProfile = profile;
    _shouldReconnect = true;
    _reconnectAttempts = 0;
    _cancelReconnectTimer();

    await _client.connect(profile);
  }

  Future<void> disconnect() async {
    _shouldReconnect = false;
    _cancelReconnectTimer();
    await _client.disconnect();
  }

  void _scheduleReconnect() {
    if (!_shouldReconnect || _client.isConnected || _lastProfile == null) return;

    final delay = _reconnectionStrategy.getDelay(_reconnectAttempts);
    if (delay == Duration.zero) return; // Stop retrying

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () async {
      if (!_shouldReconnect) return;

      _reconnectAttempts++;
      try {
        await _client.connect(_lastProfile!);
        _reconnectAttempts = 0; // Reset on success
      } catch (e) {
        // Will retry again
        _scheduleReconnect();
      }
    });
  }

  void _cancelReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  void dispose() {
    _cancelReconnectTimer();
    _shouldReconnect = false;
  }
}