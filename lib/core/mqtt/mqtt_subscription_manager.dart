import 'dart:collection';
import 'mqtt_service.dart';
import '../../domain/models/subscription.dart';

class MqttSubscriptionManager {
  final IMqttClient _client;
  final Set<String> _subscribedTopics = {};

  MqttSubscriptionManager(this._client);

  Future<void> subscribe(String topic, {int qos = 0}) async {
    if (_subscribedTopics.contains(topic)) return;

    await _client.subscribe(topic, qos: qos);
    _subscribedTopics.add(topic);
  }

  Future<void> unsubscribe(String topic) async {
    if (!_subscribedTopics.contains(topic)) return;

    await _client.unsubscribe(topic);
    _subscribedTopics.remove(topic);
  }

  Future<void> updateSubscriptions(List<Subscription> subscriptions) async {
    final currentTopics = Set<String>.from(_subscribedTopics);
    final desiredTopics = subscriptions.map((s) => s.topic).toSet();

    // Unsubscribe from topics no longer needed
    for (final topic in currentTopics.difference(desiredTopics)) {
      await unsubscribe(topic);
    }

    // Subscribe to new topics
    for (final subscription in subscriptions) {
      if (!currentTopics.contains(subscription.topic)) {
        await subscribe(subscription.topic, qos: subscription.qos);
      }
    }
  }

  Set<String> get subscribedTopics => UnmodifiableSetView(_subscribedTopics);

  void clear() {
    _subscribedTopics.clear();
  }
}