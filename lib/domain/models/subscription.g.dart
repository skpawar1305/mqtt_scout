// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionImpl _$$SubscriptionImplFromJson(Map<String, dynamic> json) =>
    _$SubscriptionImpl(
      id: json['id'] as String,
      topic: json['topic'] as String,
      qos: (json['qos'] as num?)?.toInt() ?? 0,
      noLocal: json['noLocal'] as bool? ?? false,
      retainAsPublished: json['retainAsPublished'] as bool? ?? false,
      retainHandling:
          $enumDecodeNullable(
            _$RetainHandlingEnumMap,
            json['retainHandling'],
          ) ??
          RetainHandling.sendAtSubscribe,
      userProperties: (json['userProperties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      subscribedAt: json['subscribedAt'] == null
          ? null
          : DateTime.parse(json['subscribedAt'] as String),
      subscriptionIdentifier: (json['subscriptionIdentifier'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SubscriptionImplToJson(_$SubscriptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'qos': instance.qos,
      'noLocal': instance.noLocal,
      'retainAsPublished': instance.retainAsPublished,
      'retainHandling': _$RetainHandlingEnumMap[instance.retainHandling]!,
      'userProperties': instance.userProperties,
      'subscribedAt': instance.subscribedAt?.toIso8601String(),
      'subscriptionIdentifier': instance.subscriptionIdentifier,
    };

const _$RetainHandlingEnumMap = {
  RetainHandling.sendAtSubscribe: 'sendAtSubscribe',
  RetainHandling.sendAtSubscribeIfNew: 'sendAtSubscribeIfNew',
  RetainHandling.doNotSend: 'doNotSend',
};
