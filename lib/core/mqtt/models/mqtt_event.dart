import '../../../domain/models/mqtt_message.dart';

abstract class MqttEvent {}

class MqttMessageReceived extends MqttEvent {
  final MqttMessage message;
  MqttMessageReceived(this.message);
}

class MqttConnected extends MqttEvent {
  final String clientId;
  MqttConnected(this.clientId);
}

class MqttDisconnected extends MqttEvent {
  final String? reason;
  MqttDisconnected([this.reason]);
}

class MqttError extends MqttEvent {
  final String error;
  final StackTrace? stackTrace;
  MqttError(this.error, [this.stackTrace]);
}

class MqttSubscribed extends MqttEvent {
  final String topic;
  final int qos;
  MqttSubscribed(this.topic, this.qos);
}

class MqttUnsubscribed extends MqttEvent {
  final String topic;
  MqttUnsubscribed(this.topic);
}