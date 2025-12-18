import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;
import 'package:uuid/uuid.dart';
import '../../domain/models/broker_profile.dart';
import '../../domain/models/mqtt_message.dart';
import 'mqtt_service.dart';

class MqttService implements IMqttClient {
  mqtt_client.MqttClient? _client;
  MqttProtocolVersion _activeVersion = MqttProtocolVersion.v3_1_1;
  MqttConnectionState _currentState = MqttConnectionState.disconnected;

  final _messageController = StreamController<MqttMessage>.broadcast();
  final _connectionStateController = StreamController<MqttConnectionState>.broadcast();
  final _errorController = StreamController<String>.broadcast();

  final _uuid = const Uuid();

  @override
  Stream<MqttMessage> get messageStream => _messageController.stream;

  @override
  Stream<MqttConnectionState> get connectionStateStream => _connectionStateController.stream;

  @override
  Stream<String> get errorStream => _errorController.stream;

  @override
  MqttConnectionState get currentState => _currentState;

  @override
  bool get isConnected => _currentState == MqttConnectionState.connected;

  @override
  MqttProtocolVersion get negotiatedVersion => _activeVersion;

  @override
  Future<void> connect(BrokerProfile profile) async {
    _updateState(MqttConnectionState.connecting);

    try {
      _client = mqtt_client.MqttClient(profile.host, profile.clientId);
      _client!.port = profile.port;
      _client!.keepAlivePeriod = profile.keepAlive;

      _setupStreams();

      await _client!.connect(profile.username, profile.password);
      _activeVersion = MqttProtocolVersion.v3_1_1; // For now, only support 3.1.1
      _updateState(MqttConnectionState.connected);
    } catch (e) {
      _updateState(MqttConnectionState.error);
      _errorController.add('Connection failed: $e');
      rethrow;
    }
  }

  void _setupStreams() {
    if (_client == null) return;

    _client!.updates?.listen((messages) {
      for (final message in messages) {
        final mqttMessage = _convertMessage(message);
        _messageController.add(mqttMessage);
      }
    });

    _client!.onConnected = () {
      _updateState(MqttConnectionState.connected);
    };

    _client!.onDisconnected = () {
      _updateState(MqttConnectionState.disconnected);
    };

    _client!.onAutoReconnect = () {
      _updateState(MqttConnectionState.reconnecting);
    };
  }

  MqttMessage _convertMessage(mqtt_client.MqttReceivedMessage message) {
    final payload = message.payload as mqtt_client.MqttPublishPayload;

    return MqttMessage(
      id: _uuid.v4(),
      topic: message.topic,
      payload: mqtt_client.MqttPublishPayload.bytesToStringAsString(payload.message),
      timestamp: DateTime.now(),
      qos: 0,
      retained: false,
      duplicate: false,
      protocolVersion: _activeVersion,
    );
  }

  @override
  Future<void> disconnect() async {
    _updateState(MqttConnectionState.disconnecting);

    if (_client != null) {
      _client!.disconnect();
      _client = null;
    }

    _updateState(MqttConnectionState.disconnected);
  }

  @override
  Future<void> subscribe(String topic, {int qos = 0}) async {
    if (_client != null) {
      _client!.subscribe(topic, mqtt_client.MqttQos.values[qos]);
    }
  }

  @override
  Future<void> unsubscribe(String topic) async {
    if (_client != null) {
      _client!.unsubscribe(topic);
    }
  }

  @override
  Future<void> publish(
    String topic,
    String payload, {
    int qos = 0,
    bool retain = false,
    Map<String, String>? userProperties,
  }) async {
    if (_client != null) {
      final builder = mqtt_client.MqttClientPayloadBuilder();
      builder.addString(payload);
      _client!.publishMessage(
        topic,
        mqtt_client.MqttQos.values[qos],
        builder.payload!,
        retain: retain,
      );
    }
  }

  void _updateState(MqttConnectionState state) {
    _currentState = state;
    _connectionStateController.add(state);
  }

  void dispose() {
    _messageController.close();
    _connectionStateController.close();
    _errorController.close();
    disconnect();
  }
}