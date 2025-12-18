import 'dart:async';
import '../../domain/models/broker_profile.dart';
import '../../domain/models/mqtt_message.dart';

enum MqttConnectionState {
  disconnected,
  connecting,
  connected,
  disconnecting,
  reconnecting,
  error,
}

abstract class IMqttClient {
  Stream<MqttMessage> get messageStream;
  Stream<MqttConnectionState> get connectionStateStream;
  Stream<String> get errorStream;

  Future<void> connect(BrokerProfile profile);
  Future<void> disconnect();
  Future<void> subscribe(String topic, {int qos = 0});
  Future<void> unsubscribe(String topic);
  Future<void> publish(String topic, String payload, {
    int qos = 0,
    bool retain = false,
    String? contentType, // MQTT 5 only
    String? responseTopic, // MQTT 5 only
    int? messageExpiryInterval, // MQTT 5 only
    Map<String, String>? userProperties, // MQTT 5 only
  });
  Future<void> clearRetainedMessage(String topic);

  MqttConnectionState get currentState;
  bool get isConnected;
  MqttProtocolVersion get negotiatedVersion;
}