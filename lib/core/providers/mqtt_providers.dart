import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../mqtt/mqtt_service.dart';
import '../mqtt/mqtt_service_impl.dart';
import '../mqtt/mqtt_connection_manager.dart';
import '../mqtt/mqtt_subscription_manager.dart';
import '../../domain/models/mqtt_message.dart';
import '../../domain/models/broker_profile.dart';

// Core MQTT Service Provider
final mqttServiceProvider = Provider<IMqttClient>((ref) {
  final service = MqttService();
  ref.onDispose(() => service.dispose());
  return service;
});

// Connection Manager Provider
final connectionManagerProvider = Provider<MqttConnectionManager>((ref) {
  final service = ref.watch(mqttServiceProvider);
  final manager = MqttConnectionManager(service);
  ref.onDispose(() => manager.dispose());
  return manager;
});

// Subscription Manager Provider
final subscriptionManagerProvider = Provider<MqttSubscriptionManager>((ref) {
  final service = ref.watch(mqttServiceProvider);
  final manager = MqttSubscriptionManager(service);

  // When the underlying MQTT service becomes connected, restore saved subscriptions
  service.connectionStateStream.listen((state) {
    if (state == MqttConnectionState.connected) {
      manager.restoreSubscriptions();
    }
  });

  return manager;
});

// Connection State Provider
final connectionStateProvider = StreamProvider<MqttConnectionState>((ref) {
  final service = ref.watch(mqttServiceProvider);
  // Debug: log initial state and subsequent stream events
  // ignore: avoid_print
  print('connectionStateProvider: initial=${service.currentState}');
  return Stream.fromIterable([service.currentState]).asyncExpand((_) => service.connectionStateStream.map((s) {
    // ignore: avoid_print
    print('connectionStateProvider: emit=$s');
    return s;
  }));
});

// MQTT Messages Provider
final mqttMessagesProvider = StreamProvider<MqttMessage>((ref) {
  final service = ref.watch(mqttServiceProvider);
  return service.messageStream;
});

// Protocol Version Provider
final protocolVersionProvider = Provider<MqttProtocolVersion>((ref) {
  final service = ref.watch(mqttServiceProvider);
  return service.negotiatedVersion;
});

// MQTT Error Stream Provider
final mqttErrorProvider = StreamProvider<String>((ref) {
  final service = ref.watch(mqttServiceProvider);
  return service.errorStream;
});