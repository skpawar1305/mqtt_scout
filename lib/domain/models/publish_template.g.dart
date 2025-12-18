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
  description: json['description'] as String?,
  userProperties: (json['userProperties'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  lastUsed: json['lastUsed'] == null
      ? null
      : DateTime.parse(json['lastUsed'] as String),
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
  'description': instance.description,
  'userProperties': instance.userProperties,
  'createdAt': instance.createdAt?.toIso8601String(),
  'lastUsed': instance.lastUsed?.toIso8601String(),
};
