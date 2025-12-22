import 'package:freezed_annotation/freezed_annotation.dart';

part 'mqtt_connection_state.freezed.dart';

enum MqttConnectionState {
  disconnected,
  connecting,
  connected,
  disconnecting,
  reconnecting,
  error,
}

@freezed
class MqttConnectionEvent with _$MqttConnectionEvent {
  const factory MqttConnectionEvent.connected() = Connected;
  const factory MqttConnectionEvent.disconnected() = Disconnected;
  const factory MqttConnectionEvent.error(String message) = Error;
  const factory MqttConnectionEvent.reconnecting(int attempt) = Reconnecting;
}