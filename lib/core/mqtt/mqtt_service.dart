import 'dart:async';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt3;
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt3_server;
import 'package:mqtt5_client/mqtt5_client.dart' as mqtt5;
import 'package:mqtt5_client/mqtt5_server_client.dart' as mqtt5_server;

import '../../domain/models/broker_profile.dart';
import '../../domain/models/mqtt_message.dart';
import '../../domain/models/subscription.dart';
import 'i_mqtt_client.dart';
import 'models/mqtt_connection_state.dart';

class MqttService implements IMqttClient {
  final Logger _log = Logger('MqttService');
  
  mqtt3_server.MqttServerClient? _clientV3;
  mqtt5_server.MqttServerClient? _clientV5;
  
  MqttProtocolVersion? _activeVersion;
  
  final _messageController = StreamController<MqttMessage>.broadcast();
  final _connectionStateController = StreamController<MqttConnectionState>.broadcast();
  final _errorController = StreamController<String>.broadcast();
  
  MqttConnectionState _currentState = MqttConnectionState.disconnected;

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
  MqttProtocolVersion get negotiatedVersion => 
      _activeVersion ?? MqttProtocolVersion.v3_1_1;

  void _updateState(MqttConnectionState state) {
    _currentState = state;
    _connectionStateController.add(state);
  }

  @override
  Future<void> connect(BrokerProfile profile) async {
    _updateState(MqttConnectionState.connecting);
    
    try {
      if (profile.autoDetectProtocol) {
        await _connectWithFallback(profile);
      } else {
        await _connectWithVersion(profile, profile.protocolVersion);
      }
    } catch (e) {
      _updateState(MqttConnectionState.error);
      _errorController.add(e.toString());
      rethrow;
    }
  }

  Future<void> _connectWithFallback(BrokerProfile profile) async {
    try {
      await _connectWithVersion(profile, MqttProtocolVersion.v5);
      _activeVersion = MqttProtocolVersion.v5;
    } catch (e) {
      _log.warning('MQTT 5.0 failed, falling back to 3.1.1: $e');
      try {
        await _connectWithVersion(profile, MqttProtocolVersion.v3_1_1);
        _activeVersion = MqttProtocolVersion.v3_1_1;
      } catch (e) {
        throw Exception('Failed to connect with both protocols: $e');
      }
    }
  }

  Future<void> _connectWithVersion(
    BrokerProfile profile, 
    MqttProtocolVersion version,
  ) async {
    switch (version) {
      case MqttProtocolVersion.v5:
        await _connectV5(profile);
        break;
      case MqttProtocolVersion.v3_1_1:
        await _connectV3(profile);
        break;
    }
  }

  Future<void> _connectV5(BrokerProfile profile) async {
    if (profile.scheme == MqttScheme.ws) {
      _clientV5 = mqtt5_server.MqttServerClient.withPort(
        profile.host,
        profile.clientId,
        profile.port,
      );
      _clientV5!.useWebSocket = true;
    } else {
      _clientV5 = mqtt5_server.MqttServerClient(profile.host, profile.clientId);
      _clientV5!.port = profile.port;
    }
    
    _clientV5!.secure = profile.useTls;
    _clientV5!.keepAlivePeriod = profile.keepAlive;
    
    // Setup callbacks
    _clientV5!.onConnected = () => _updateState(MqttConnectionState.connected);
    _clientV5!.onDisconnected = () => _updateState(MqttConnectionState.disconnected);
    
    try {
      await _clientV5!.connect(
        profile.username,
        profile.password,
      );
      
      _clientV5!.updates.listen((List<mqtt5.MqttReceivedMessage<mqtt5.MqttMessage>> c) {
        final recMess = c[0].payload as mqtt5.MqttPublishMessage;
        String pt;
        try {
          pt = mqtt5.MqttUtilities.bytesToStringAsString(recMess.payload.message!);
        } catch (e) {
          pt = '[Binary Data: ${recMess.payload.message!.length} bytes]';
        }
        
        final message = MqttMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
          topic: c[0].topic ?? 'unknown',
          payload: pt,
          timestamp: DateTime.now(),
          qos: recMess.header!.qos.index,
          retained: recMess.header!.retain,
          protocolVersion: MqttProtocolVersion.v5,
          userProperties: {}, // Extract user properties if needed
        );
        _messageController.add(message);
      });
      
    } catch (e) {
      _clientV5?.disconnect();
      _clientV5 = null;
      rethrow;
    }
  }

  Future<void> _connectV3(BrokerProfile profile) async {
    if (profile.scheme == MqttScheme.ws) {
      _clientV3 = mqtt3_server.MqttServerClient.withPort(
        profile.host,
        profile.clientId,
        profile.port,
      );
      _clientV3!.useWebSocket = true;
    } else {
      _clientV3 = mqtt3_server.MqttServerClient(profile.host, profile.clientId);
      _clientV3!.port = profile.port;
    }

    _clientV3!.secure = profile.useTls;
    _clientV3!.keepAlivePeriod = profile.keepAlive;
    
    _clientV3!.onConnected = () => _updateState(MqttConnectionState.connected);
    _clientV3!.onDisconnected = () => _updateState(MqttConnectionState.disconnected);

    try {
      await _clientV3!.connect(profile.username, profile.password);
      
      _clientV3!.updates!.listen((List<mqtt3.MqttReceivedMessage<mqtt3.MqttMessage>> c) {
        final recMess = c[0].payload as mqtt3.MqttPublishMessage;
        String pt;
        try {
          pt = mqtt3.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        } catch (e) {
          pt = '[Binary Data: ${recMess.payload.message.length} bytes]';
        }
        
        final message = MqttMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          topic: c[0].topic,
          payload: pt,
          timestamp: DateTime.now(),
          qos: recMess.header!.qos.index,
          retained: recMess.header!.retain,
          protocolVersion: MqttProtocolVersion.v3_1_1,
        );
        _messageController.add(message);
      });
    } catch (e) {
      _clientV3?.disconnect();
      _clientV3 = null;
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    _updateState(MqttConnectionState.disconnecting);
    if (_clientV5 != null) {
      _clientV5!.disconnect();
      _clientV5 = null;
    }
    if (_clientV3 != null) {
      _clientV3!.disconnect();
      _clientV3 = null;
    }
    _updateState(MqttConnectionState.disconnected);
  }

  @override
  Future<void> subscribe(Subscription subscription) async {
    if (_activeVersion == MqttProtocolVersion.v5 && _clientV5 != null) {
      // TODO: Fix MQTT 5 properties implementation
      /*
      final options = mqtt5.SubscriptionOptions();
      options.noLocal = subscription.noLocal;
      options.retainAsPublished = subscription.retainAsPublished;
      options.retainHandling = mqtt5.RetainHandling.values[subscription.retainHandling.index];
      if (subscription.subscriptionIdentifier != null) {
        options.subscriptionIdentifier = subscription.subscriptionIdentifier;
      }
      */
      
      _clientV5!.subscribe(
        subscription.topic, 
        mqtt5.MqttQos.values[subscription.qos],
        // subscriptionOptions: options,
      );
    } else if (_activeVersion == MqttProtocolVersion.v3_1_1 && _clientV3 != null) {
      _clientV3!.subscribe(
        subscription.topic, 
        mqtt3.MqttQos.values[subscription.qos],
      );
    }
  }

  @override
  Future<void> unsubscribe(String topic) async {
    if (_activeVersion == MqttProtocolVersion.v5 && _clientV5 != null) {
      _clientV5!.unsubscribeStringTopic(topic);
    } else if (_activeVersion == MqttProtocolVersion.v3_1_1 && _clientV3 != null) {
      _clientV3!.unsubscribe(topic);
    }
  }

  @override
  Future<void> publish(
    String topic, 
    String payload, {
    int qos = 0,
    bool retain = false,
    String? contentType,
    String? responseTopic,
    int? messageExpiryInterval,
    Map<String, String>? userProperties,
  }) async {
    if (_activeVersion == MqttProtocolVersion.v5 && _clientV5 != null) {
      final builder = mqtt5.MqttPayloadBuilder();
      builder.addString(payload);
      
      // TODO: Fix MQTT 5 properties implementation
      /*
      final properties = mqtt5.MqttPublishProperties();
      if (userProperties != null) {
        userProperties.forEach((key, value) {
          final prop = mqtt5.MqttUserProperty();
          prop.pairName = key;
          prop.pairValue = value;
          properties.userProperty.add(prop);
        });
      }
      if (contentType != null) properties.contentType = contentType;
      if (responseTopic != null) properties.responseTopic = responseTopic;
      if (messageExpiryInterval != null) properties.messageExpiryInterval = messageExpiryInterval;
      */
      
      _clientV5!.publishMessage(
        topic,
        mqtt5.MqttQos.values[qos],
        builder.payload!,
        retain: retain,
        // properties: properties,
      );
    } else if (_activeVersion == MqttProtocolVersion.v3_1_1 && _clientV3 != null) {
      final builder = mqtt3.MqttClientPayloadBuilder();
      builder.addString(payload);
      
      _clientV3!.publishMessage(
        topic,
        mqtt3.MqttQos.values[qos],
        builder.payload!,
        retain: retain,
      );
    }
  }
  
  @override
  Future<void> clearRetainedMessage(String topic) async {
     // Sending a retained message with empty payload clears it
     await publish(topic, "", retain: true, qos: 1);
  }
  
  void dispose() {
    _messageController.close();
    _connectionStateController.close();
    _errorController.close();
  }
}
