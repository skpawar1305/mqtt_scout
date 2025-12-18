import 'package:freezed_annotation/freezed_annotation.dart';
import 'broker_profile.dart';

part 'mqtt_message.freezed.dart';
part 'mqtt_message.g.dart';

@freezed
class MqttMessage with _$MqttMessage {
  const factory MqttMessage({
    required String id,
    required String topic,
    required String payload,
    required DateTime timestamp,
    @Default(0) int qos,
    @Default(false) bool retained,
    @Default(false) bool duplicate,
    PayloadType? detectedType,

    // MQTT version
    required MqttProtocolVersion protocolVersion,

    // MQTT 5.0 specific properties
    String? contentType,
    String? responseTopic,
    List<int>? correlationData,
    int? messageExpiryInterval,
    Map<String, String>? userProperties,
    List<String>? subscriptionIdentifiers,
  }) = _MqttMessage;

  factory MqttMessage.fromJson(Map<String, dynamic> json) =>
      _$MqttMessageFromJson(json);
}

enum PayloadType { json, xml, text, number, boolean, binary, empty }