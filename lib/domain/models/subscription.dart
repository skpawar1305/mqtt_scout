import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

enum RetainHandling {
  sendAtSubscribe,
  sendAtSubscribeIfNew,
  doNotSend,
}

@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required String id,
    required String topic,
    @Default(0) int qos,
    @Default(false) bool noLocal, // MQTT 5.0
    @Default(false) bool retainAsPublished, // MQTT 5.0
    @Default(RetainHandling.sendAtSubscribe) RetainHandling retainHandling, // MQTT 5.0
    Map<String, String>? userProperties, // MQTT 5.0
    DateTime? subscribedAt,
    int? subscriptionIdentifier, // MQTT 5.0
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
}