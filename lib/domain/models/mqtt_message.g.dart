// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mqtt_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MqttMessageImpl _$$MqttMessageImplFromJson(
  Map<String, dynamic> json,
) => _$MqttMessageImpl(
  id: json['id'] as String,
  topic: json['topic'] as String,
  payload: json['payload'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  qos: (json['qos'] as num?)?.toInt() ?? 0,
  retained: json['retained'] as bool? ?? false,
  duplicate: json['duplicate'] as bool? ?? false,
  detectedType: $enumDecodeNullable(_$PayloadTypeEnumMap, json['detectedType']),
  protocolVersion: $enumDecode(
    _$MqttProtocolVersionEnumMap,
    json['protocolVersion'],
  ),
  contentType: json['contentType'] as String?,
  responseTopic: json['responseTopic'] as String?,
  correlationData: (json['correlationData'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  messageExpiryInterval: (json['messageExpiryInterval'] as num?)?.toInt(),
  userProperties: (json['userProperties'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  subscriptionIdentifiers: (json['subscriptionIdentifiers'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$MqttMessageImplToJson(
  _$MqttMessageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'topic': instance.topic,
  'payload': instance.payload,
  'timestamp': instance.timestamp.toIso8601String(),
  'qos': instance.qos,
  'retained': instance.retained,
  'duplicate': instance.duplicate,
  'detectedType': _$PayloadTypeEnumMap[instance.detectedType],
  'protocolVersion': _$MqttProtocolVersionEnumMap[instance.protocolVersion]!,
  'contentType': instance.contentType,
  'responseTopic': instance.responseTopic,
  'correlationData': instance.correlationData,
  'messageExpiryInterval': instance.messageExpiryInterval,
  'userProperties': instance.userProperties,
  'subscriptionIdentifiers': instance.subscriptionIdentifiers,
};

const _$PayloadTypeEnumMap = {
  PayloadType.json: 'json',
  PayloadType.xml: 'xml',
  PayloadType.text: 'text',
  PayloadType.number: 'number',
  PayloadType.boolean: 'boolean',
  PayloadType.binary: 'binary',
  PayloadType.empty: 'empty',
};

const _$MqttProtocolVersionEnumMap = {
  MqttProtocolVersion.v3_1_1: 'v3_1_1',
  MqttProtocolVersion.v5: 'v5',
};
