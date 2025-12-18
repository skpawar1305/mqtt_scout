import 'dart:async';
import '../../domain/models/broker_profile.dart';
import '../../domain/models/mqtt_message.dart';

enum ConnectionState { disconnected, connecting, connected, error }

abstract class IMqttClient {
  Stream<MqttMessage> get messageStream;
  Stream<ConnectionState> get connectionStateStream;
  Stream<String> get errorStream;

  Future<void> connect(BrokerProfile profile);
  Future<void> disconnect();
  Future<void> subscribe(String topic, {int qos = 0});
  Future<void> unsubscribe(String topic);
  Future<void> publish(String topic, String payload, {
    int qos = 0,
    bool retain = false,
    Map<String, String>? userProperties, // MQTT 5 only
  });

  bool get isConnected;
  BrokerProfile? get currentProfile;
}