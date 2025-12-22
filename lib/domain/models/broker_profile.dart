import 'package:freezed_annotation/freezed_annotation.dart';

part 'broker_profile.freezed.dart';
part 'broker_profile.g.dart';

@freezed
class BrokerProfile with _$BrokerProfile {
  const factory BrokerProfile({
    required String id,
    required String name,
    required String host,
    @Default(1883) int port,
    @Default(false) bool useTls,
    String? username,
    String? password,
    required String clientId,
    @Default(60) int keepAlive,
    @Default(true) bool cleanSession,

    // Protocol version
    @Default(MqttProtocolVersion.v5) MqttProtocolVersion protocolVersion,
    @Default(true) bool autoDetectProtocol, // Try 5.0, fallback to 3.1.1

    // Last Will Testament (both versions)
    String? lastWillTopic,
    String? lastWillMessage,
    @Default(0) int lastWillQos,
    @Default(false) bool lastWillRetain,

    // MQTT 5.0 specific
    int? sessionExpiryInterval,
    int? maxPacketSize,
    int? topicAliasMaximum,
    Map<String, String>? userProperties,

    DateTime? lastConnected,
    @Default(true) bool validateCertificates,
    @Default(MqttScheme.tcp) MqttScheme scheme,
  }) = _BrokerProfile;

  factory BrokerProfile.fromJson(Map<String, dynamic> json) =>
      _$BrokerProfileFromJson(json);
}

enum MqttProtocolVersion { v3_1_1, v5 }

enum MqttScheme { tcp, ws }