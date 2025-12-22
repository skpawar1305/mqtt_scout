// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broker_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrokerProfileImpl _$$BrokerProfileImplFromJson(Map<String, dynamic> json) =>
    _$BrokerProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      host: json['host'] as String,
      port: (json['port'] as num?)?.toInt() ?? 1883,
      useTls: json['useTls'] as bool? ?? false,
      username: json['username'] as String?,
      password: json['password'] as String?,
      clientId: json['clientId'] as String,
      keepAlive: (json['keepAlive'] as num?)?.toInt() ?? 60,
      cleanSession: json['cleanSession'] as bool? ?? true,
      protocolVersion:
          $enumDecodeNullable(
            _$MqttProtocolVersionEnumMap,
            json['protocolVersion'],
          ) ??
          MqttProtocolVersion.v5,
      autoDetectProtocol: json['autoDetectProtocol'] as bool? ?? true,
      lastWillTopic: json['lastWillTopic'] as String?,
      lastWillMessage: json['lastWillMessage'] as String?,
      lastWillQos: (json['lastWillQos'] as num?)?.toInt() ?? 0,
      lastWillRetain: json['lastWillRetain'] as bool? ?? false,
      sessionExpiryInterval: (json['sessionExpiryInterval'] as num?)?.toInt(),
      maxPacketSize: (json['maxPacketSize'] as num?)?.toInt(),
      topicAliasMaximum: (json['topicAliasMaximum'] as num?)?.toInt(),
      userProperties: (json['userProperties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      lastConnected: json['lastConnected'] == null
          ? null
          : DateTime.parse(json['lastConnected'] as String),
      validateCertificates: json['validateCertificates'] as bool? ?? true,
    );

Map<String, dynamic> _$$BrokerProfileImplToJson(
  _$BrokerProfileImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'host': instance.host,
  'port': instance.port,
  'useTls': instance.useTls,
  'username': instance.username,
  'password': instance.password,
  'clientId': instance.clientId,
  'keepAlive': instance.keepAlive,
  'cleanSession': instance.cleanSession,
  'protocolVersion': _$MqttProtocolVersionEnumMap[instance.protocolVersion]!,
  'autoDetectProtocol': instance.autoDetectProtocol,
  'lastWillTopic': instance.lastWillTopic,
  'lastWillMessage': instance.lastWillMessage,
  'lastWillQos': instance.lastWillQos,
  'lastWillRetain': instance.lastWillRetain,
  'sessionExpiryInterval': instance.sessionExpiryInterval,
  'maxPacketSize': instance.maxPacketSize,
  'topicAliasMaximum': instance.topicAliasMaximum,
  'userProperties': instance.userProperties,
  'lastConnected': instance.lastConnected?.toIso8601String(),
  'validateCertificates': instance.validateCertificates,
};

const _$MqttProtocolVersionEnumMap = {
  MqttProtocolVersion.v3_1_1: 'v3_1_1',
  MqttProtocolVersion.v5: 'v5',
};
