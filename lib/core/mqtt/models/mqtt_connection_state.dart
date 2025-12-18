import 'package:freezed_annotation/freezed_annotation.dart';

part 'mqtt_connection_state.freezed.dart';

@freezed
class MqttConnectionState with _$MqttConnectionState {
  const factory MqttConnectionState.disconnected() = Disconnected;
  const factory MqttConnectionState.connecting() = Connecting;
  const factory MqttConnectionState.connected({
    required String brokerUrl,
    required String clientId,
    required DateTime connectedAt,
  }) = Connected;
  const factory MqttConnectionState.error({
    required String error,
    required DateTime errorAt,
  }) = ConnectionError;
}