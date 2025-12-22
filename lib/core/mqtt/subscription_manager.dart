import 'dart:async';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/subscription.dart';
import 'i_mqtt_client.dart';
import 'models/mqtt_connection_state.dart';

class SubscriptionManager {
  final IMqttClient _mqttClient;
  final Logger _log = Logger('SubscriptionManager');
  final Set<Subscription> _activeSubscriptions = {};
  StreamSubscription? _connectionSubscription;

  SubscriptionManager(this._mqttClient) {
    _connectionSubscription = _mqttClient.connectionStateStream.listen(_handleConnectionState);
  }

  Set<Subscription> get activeSubscriptions => Set.unmodifiable(_activeSubscriptions);

  Future<void> subscribe(Subscription subscription) async {
    _activeSubscriptions.add(subscription);
    
    if (_mqttClient.isConnected) {
      try {
        await _mqttClient.subscribe(subscription);
        _log.info('Subscribed to ${subscription.topic}');
      } catch (e) {
        _log.severe('Failed to subscribe to ${subscription.topic}: $e');
        // We keep it in activeSubscriptions to retry on reconnect
        rethrow;
      }
    }
  }

  Future<void> unsubscribe(String topic) async {
    _activeSubscriptions.removeWhere((s) => s.topic == topic);
    
    if (_mqttClient.isConnected) {
      try {
        await _mqttClient.unsubscribe(topic);
        _log.info('Unsubscribed from $topic');
      } catch (e) {
        _log.severe('Failed to unsubscribe from $topic: $e');
        rethrow;
      }
    }
  }

  Future<void> enableDiscoveryMode() async {
    const discoveryTopic = '#';
    
    // Check if already subscribed
    if (_activeSubscriptions.any((s) => s.topic == discoveryTopic)) {
      return;
    }

    final subscription = Subscription(
      id: const Uuid().v4(),
      topic: discoveryTopic,
      qos: 0,
      subscribedAt: DateTime.now(),
    );

    await subscribe(subscription);
  }

  void _handleConnectionState(MqttConnectionState state) {
    if (state == MqttConnectionState.connected) {
      _restoreSubscriptions();
    }
  }

  Future<void> _restoreSubscriptions() async {
    if (_activeSubscriptions.isEmpty) return;

    _log.info('Restoring ${_activeSubscriptions.length} subscriptions...');
    
    for (final sub in _activeSubscriptions) {
      try {
        await _mqttClient.subscribe(sub);
      } catch (e) {
        _log.warning('Failed to restore subscription to ${sub.topic}: $e');
      }
    }
  }

  void dispose() {
    _connectionSubscription?.cancel();
  }
}
