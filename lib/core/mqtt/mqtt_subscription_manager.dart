import 'dart:collection';
import 'mqtt_service.dart';
import '../../domain/models/subscription.dart';

class MqttSubscriptionManager {
  final IMqttClient _client;
  final Set<Subscription> _subscriptions = {};

  MqttSubscriptionManager(this._client);

  Future<void> subscribe(Subscription subscription) async {
    _subscriptions.add(subscription);
    await _client.subscribe(subscription.topic, qos: subscription.qos);
  }

  Future<void> unsubscribe(String topic) async {
    _subscriptions.removeWhere((sub) => sub.topic == topic);
    await _client.unsubscribe(topic);
  }

  Future<void> updateSubscriptions(List<Subscription> subscriptions) async {
    final currentTopics = Set<String>.from(_subscriptions.map((s) => s.topic));
    final desiredTopics = subscriptions.map((s) => s.topic).toSet();

    // Unsubscribe from topics no longer needed
    for (final topic in currentTopics.difference(desiredTopics)) {
      await unsubscribe(topic);
    }

    // Subscribe to new topics
    for (final subscription in subscriptions) {
      if (!currentTopics.contains(subscription.topic)) {
        await subscribe(subscription);
      }
    }
  }

  Future<void> restoreSubscriptions() async {
    for (final sub in _subscriptions) {
      await subscribe(sub);
    }
  }

  Set<Subscription> get subscriptions => UnmodifiableSetView(_subscriptions);

  void clear() {
    _subscriptions.clear();
  }
}