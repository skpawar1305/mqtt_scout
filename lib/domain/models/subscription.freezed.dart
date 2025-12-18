// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) {
  return _Subscription.fromJson(json);
}

/// @nodoc
mixin _$Subscription {
  String get id => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  int get qos => throw _privateConstructorUsedError;
  bool get noLocal => throw _privateConstructorUsedError; // MQTT 5.0
  bool get retainAsPublished => throw _privateConstructorUsedError; // MQTT 5.0
  int get retainHandling => throw _privateConstructorUsedError; // MQTT 5.0
  Map<String, String>? get userProperties =>
      throw _privateConstructorUsedError; // MQTT 5.0
  DateTime? get subscribedAt => throw _privateConstructorUsedError;
  int? get subscriptionIdentifier => throw _privateConstructorUsedError;

  /// Serializes this Subscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionCopyWith<Subscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionCopyWith<$Res> {
  factory $SubscriptionCopyWith(
    Subscription value,
    $Res Function(Subscription) then,
  ) = _$SubscriptionCopyWithImpl<$Res, Subscription>;
  @useResult
  $Res call({
    String id,
    String topic,
    int qos,
    bool noLocal,
    bool retainAsPublished,
    int retainHandling,
    Map<String, String>? userProperties,
    DateTime? subscribedAt,
    int? subscriptionIdentifier,
  });
}

/// @nodoc
class _$SubscriptionCopyWithImpl<$Res, $Val extends Subscription>
    implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? qos = null,
    Object? noLocal = null,
    Object? retainAsPublished = null,
    Object? retainHandling = null,
    Object? userProperties = freezed,
    Object? subscribedAt = freezed,
    Object? subscriptionIdentifier = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            topic: null == topic
                ? _value.topic
                : topic // ignore: cast_nullable_to_non_nullable
                      as String,
            qos: null == qos
                ? _value.qos
                : qos // ignore: cast_nullable_to_non_nullable
                      as int,
            noLocal: null == noLocal
                ? _value.noLocal
                : noLocal // ignore: cast_nullable_to_non_nullable
                      as bool,
            retainAsPublished: null == retainAsPublished
                ? _value.retainAsPublished
                : retainAsPublished // ignore: cast_nullable_to_non_nullable
                      as bool,
            retainHandling: null == retainHandling
                ? _value.retainHandling
                : retainHandling // ignore: cast_nullable_to_non_nullable
                      as int,
            userProperties: freezed == userProperties
                ? _value.userProperties
                : userProperties // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            subscribedAt: freezed == subscribedAt
                ? _value.subscribedAt
                : subscribedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            subscriptionIdentifier: freezed == subscriptionIdentifier
                ? _value.subscriptionIdentifier
                : subscriptionIdentifier // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionImplCopyWith<$Res>
    implements $SubscriptionCopyWith<$Res> {
  factory _$$SubscriptionImplCopyWith(
    _$SubscriptionImpl value,
    $Res Function(_$SubscriptionImpl) then,
  ) = __$$SubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String topic,
    int qos,
    bool noLocal,
    bool retainAsPublished,
    int retainHandling,
    Map<String, String>? userProperties,
    DateTime? subscribedAt,
    int? subscriptionIdentifier,
  });
}

/// @nodoc
class __$$SubscriptionImplCopyWithImpl<$Res>
    extends _$SubscriptionCopyWithImpl<$Res, _$SubscriptionImpl>
    implements _$$SubscriptionImplCopyWith<$Res> {
  __$$SubscriptionImplCopyWithImpl(
    _$SubscriptionImpl _value,
    $Res Function(_$SubscriptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? qos = null,
    Object? noLocal = null,
    Object? retainAsPublished = null,
    Object? retainHandling = null,
    Object? userProperties = freezed,
    Object? subscribedAt = freezed,
    Object? subscriptionIdentifier = freezed,
  }) {
    return _then(
      _$SubscriptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        topic: null == topic
            ? _value.topic
            : topic // ignore: cast_nullable_to_non_nullable
                  as String,
        qos: null == qos
            ? _value.qos
            : qos // ignore: cast_nullable_to_non_nullable
                  as int,
        noLocal: null == noLocal
            ? _value.noLocal
            : noLocal // ignore: cast_nullable_to_non_nullable
                  as bool,
        retainAsPublished: null == retainAsPublished
            ? _value.retainAsPublished
            : retainAsPublished // ignore: cast_nullable_to_non_nullable
                  as bool,
        retainHandling: null == retainHandling
            ? _value.retainHandling
            : retainHandling // ignore: cast_nullable_to_non_nullable
                  as int,
        userProperties: freezed == userProperties
            ? _value._userProperties
            : userProperties // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        subscribedAt: freezed == subscribedAt
            ? _value.subscribedAt
            : subscribedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        subscriptionIdentifier: freezed == subscriptionIdentifier
            ? _value.subscriptionIdentifier
            : subscriptionIdentifier // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionImpl implements _Subscription {
  const _$SubscriptionImpl({
    required this.id,
    required this.topic,
    this.qos = 0,
    this.noLocal = false,
    this.retainAsPublished = false,
    this.retainHandling = 0,
    final Map<String, String>? userProperties,
    this.subscribedAt,
    this.subscriptionIdentifier,
  }) : _userProperties = userProperties;

  factory _$SubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionImplFromJson(json);

  @override
  final String id;
  @override
  final String topic;
  @override
  @JsonKey()
  final int qos;
  @override
  @JsonKey()
  final bool noLocal;
  // MQTT 5.0
  @override
  @JsonKey()
  final bool retainAsPublished;
  // MQTT 5.0
  @override
  @JsonKey()
  final int retainHandling;
  // MQTT 5.0
  final Map<String, String>? _userProperties;
  // MQTT 5.0
  @override
  Map<String, String>? get userProperties {
    final value = _userProperties;
    if (value == null) return null;
    if (_userProperties is EqualUnmodifiableMapView) return _userProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // MQTT 5.0
  @override
  final DateTime? subscribedAt;
  @override
  final int? subscriptionIdentifier;

  @override
  String toString() {
    return 'Subscription(id: $id, topic: $topic, qos: $qos, noLocal: $noLocal, retainAsPublished: $retainAsPublished, retainHandling: $retainHandling, userProperties: $userProperties, subscribedAt: $subscribedAt, subscriptionIdentifier: $subscriptionIdentifier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.qos, qos) || other.qos == qos) &&
            (identical(other.noLocal, noLocal) || other.noLocal == noLocal) &&
            (identical(other.retainAsPublished, retainAsPublished) ||
                other.retainAsPublished == retainAsPublished) &&
            (identical(other.retainHandling, retainHandling) ||
                other.retainHandling == retainHandling) &&
            const DeepCollectionEquality().equals(
              other._userProperties,
              _userProperties,
            ) &&
            (identical(other.subscribedAt, subscribedAt) ||
                other.subscribedAt == subscribedAt) &&
            (identical(other.subscriptionIdentifier, subscriptionIdentifier) ||
                other.subscriptionIdentifier == subscriptionIdentifier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    topic,
    qos,
    noLocal,
    retainAsPublished,
    retainHandling,
    const DeepCollectionEquality().hash(_userProperties),
    subscribedAt,
    subscriptionIdentifier,
  );

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionImplCopyWith<_$SubscriptionImpl> get copyWith =>
      __$$SubscriptionImplCopyWithImpl<_$SubscriptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionImplToJson(this);
  }
}

abstract class _Subscription implements Subscription {
  const factory _Subscription({
    required final String id,
    required final String topic,
    final int qos,
    final bool noLocal,
    final bool retainAsPublished,
    final int retainHandling,
    final Map<String, String>? userProperties,
    final DateTime? subscribedAt,
    final int? subscriptionIdentifier,
  }) = _$SubscriptionImpl;

  factory _Subscription.fromJson(Map<String, dynamic> json) =
      _$SubscriptionImpl.fromJson;

  @override
  String get id;
  @override
  String get topic;
  @override
  int get qos;
  @override
  bool get noLocal; // MQTT 5.0
  @override
  bool get retainAsPublished; // MQTT 5.0
  @override
  int get retainHandling; // MQTT 5.0
  @override
  Map<String, String>? get userProperties; // MQTT 5.0
  @override
  DateTime? get subscribedAt;
  @override
  int? get subscriptionIdentifier;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionImplCopyWith<_$SubscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
