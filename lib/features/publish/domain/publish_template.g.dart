// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublishTemplateImpl _$$PublishTemplateImplFromJson(
  Map<String, dynamic> json,
) => _$PublishTemplateImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  topic: json['topic'] as String,
  payload: json['payload'] as String,
  qos: (json['qos'] as num?)?.toInt() ?? 0,
  retain: json['retain'] as bool? ?? false,
  contentType: json['contentType'] as String?,
  responseTopic: json['responseTopic'] as String?,
  messageExpiryInterval: (json['messageExpiryInterval'] as num?)?.toInt(),
  userProperties: (json['userProperties'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$PublishTemplateImplToJson(
  _$PublishTemplateImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'topic': instance.topic,
  'payload': instance.payload,
  'qos': instance.qos,
  'retain': instance.retain,
  'contentType': instance.contentType,
  'responseTopic': instance.responseTopic,
  'messageExpiryInterval': instance.messageExpiryInterval,
  'userProperties': instance.userProperties,
  'createdAt': instance.createdAt?.toIso8601String(),
};
