import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../mqtt/i_mqtt_client.dart';
import '../mqtt/mqtt_service.dart';
import '../mqtt/mqtt_connection_manager.dart';
import '../mqtt/subscription_manager.dart';
import '../mqtt/models/mqtt_connection_state.dart';
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
final subscriptionManagerProvider = Provider<SubscriptionManager>((ref) {
  final service = ref.watch(mqttServiceProvider);
  final manager = SubscriptionManager(service);

  // When the underlying MQTT service becomes connected, restore saved subscriptions
  // Note: SubscriptionManager already listens to connection state internally, 
  // so we don't need to do it here again if the constructor handles it.
  // Checking SubscriptionManager implementation... yes, it does.
  
  ref.onDispose(() => manager.dispose());

  return manager;
});

// Connection State Provider
// Connection State Provider
final connectionStateProvider = StreamProvider<MqttConnectionState>((ref) async* {
  final service = ref.watch(mqttServiceProvider);
  // Yield initial state immediately
  yield service.currentState;
  // Yield subsequent state changes
  yield* service.connectionStateStream;
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