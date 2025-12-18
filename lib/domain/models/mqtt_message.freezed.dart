// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mqtt_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MqttMessage _$MqttMessageFromJson(Map<String, dynamic> json) {
  return _MqttMessage.fromJson(json);
}

/// @nodoc
mixin _$MqttMessage {
  String get id => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String get payload => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int get qos => throw _privateConstructorUsedError;
  bool get retained => throw _privateConstructorUsedError;
  bool get duplicate => throw _privateConstructorUsedError;
  PayloadType? get detectedType =>
      throw _privateConstructorUsedError; // MQTT version
  MqttProtocolVersion get protocolVersion =>
      throw _privateConstructorUsedError; // MQTT 5.0 specific properties
  String? get contentType => throw _privateConstructorUsedError;
  String? get responseTopic => throw _privateConstructorUsedError;
  List<int>? get correlationData => throw _privateConstructorUsedError;
  int? get messageExpiryInterval => throw _privateConstructorUsedError;
  Map<String, String>? get userProperties => throw _privateConstructorUsedError;
  List<String>? get subscriptionIdentifiers =>
      throw _privateConstructorUsedError;

  /// Serializes this MqttMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MqttMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MqttMessageCopyWith<MqttMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MqttMessageCopyWith<$Res> {
  factory $MqttMessageCopyWith(
    MqttMessage value,
    $Res Function(MqttMessage) then,
  ) = _$MqttMessageCopyWithImpl<$Res, MqttMessage>;
  @useResult
  $Res call({
    String id,
    String topic,
    String payload,
    DateTime timestamp,
    int qos,
    bool retained,
    bool duplicate,
    PayloadType? detectedType,
    MqttProtocolVersion protocolVersion,
    String? contentType,
    String? responseTopic,
    List<int>? correlationData,
    int? messageExpiryInterval,
    Map<String, String>? userProperties,
    List<String>? subscriptionIdentifiers,
  });
}

/// @nodoc
class _$MqttMessageCopyWithImpl<$Res, $Val extends MqttMessage>
    implements $MqttMessageCopyWith<$Res> {
  _$MqttMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MqttMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? payload = null,
    Object? timestamp = null,
    Object? qos = null,
    Object? retained = null,
    Object? duplicate = null,
    Object? detectedType = freezed,
    Object? protocolVersion = null,
    Object? contentType = freezed,
    Object? responseTopic = freezed,
    Object? correlationData = freezed,
    Object? messageExpiryInterval = freezed,
    Object? userProperties = freezed,
    Object? subscriptionIdentifiers = freezed,
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
            payload: null == payload
                ? _value.payload
                : payload // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            qos: null == qos
                ? _value.qos
                : qos // ignore: cast_nullable_to_non_nullable
                      as int,
            retained: null == retained
                ? _value.retained
                : retained // ignore: cast_nullable_to_non_nullable
                      as bool,
            duplicate: null == duplicate
                ? _value.duplicate
                : duplicate // ignore: cast_nullable_to_non_nullable
                      as bool,
            detectedType: freezed == detectedType
                ? _value.detectedType
                : detectedType // ignore: cast_nullable_to_non_nullable
                      as PayloadType?,
            protocolVersion: null == protocolVersion
                ? _value.protocolVersion
                : protocolVersion // ignore: cast_nullable_to_non_nullable
                      as MqttProtocolVersion,
            contentType: freezed == contentType
                ? _value.contentType
                : contentType // ignore: cast_nullable_to_non_nullable
                      as String?,
            responseTopic: freezed == responseTopic
                ? _value.responseTopic
                : responseTopic // ignore: cast_nullable_to_non_nullable
                      as String?,
            correlationData: freezed == correlationData
                ? _value.correlationData
                : correlationData // ignore: cast_nullable_to_non_nullable
                      as List<int>?,
            messageExpiryInterval: freezed == messageExpiryInterval
                ? _value.messageExpiryInterval
                : messageExpiryInterval // ignore: cast_nullable_to_non_nullable
                      as int?,
            userProperties: freezed == userProperties
                ? _value.userProperties
                : userProperties // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            subscriptionIdentifiers: freezed == subscriptionIdentifiers
                ? _value.subscriptionIdentifiers
                : subscriptionIdentifiers // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MqttMessageImplCopyWith<$Res>
    implements $MqttMessageCopyWith<$Res> {
  factory _$$MqttMessageImplCopyWith(
    _$MqttMessageImpl value,
    $Res Function(_$MqttMessageImpl) then,
  ) = __$$MqttMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String topic,
    String payload,
    DateTime timestamp,
    int qos,
    bool retained,
    bool duplicate,
    PayloadType? detectedType,
    MqttProtocolVersion protocolVersion,
    String? contentType,
    String? responseTopic,
    List<int>? correlationData,
    int? messageExpiryInterval,
    Map<String, String>? userProperties,
    List<String>? subscriptionIdentifiers,
  });
}

/// @nodoc
class __$$MqttMessageImplCopyWithImpl<$Res>
    extends _$MqttMessageCopyWithImpl<$Res, _$MqttMessageImpl>
    implements _$$MqttMessageImplCopyWith<$Res> {
  __$$MqttMessageImplCopyWithImpl(
    _$MqttMessageImpl _value,
    $Res Function(_$MqttMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MqttMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? payload = null,
    Object? timestamp = null,
    Object? qos = null,
    Object? retained = null,
    Object? duplicate = null,
    Object? detectedType = freezed,
    Object? protocolVersion = null,
    Object? contentType = freezed,
    Object? responseTopic = freezed,
    Object? correlationData = freezed,
    Object? messageExpiryInterval = freezed,
    Object? userProperties = freezed,
    Object? subscriptionIdentifiers = freezed,
  }) {
    return _then(
      _$MqttMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        topic: null == topic
            ? _value.topic
            : topic // ignore: cast_nullable_to_non_nullable
                  as String,
        payload: null == payload
            ? _value.payload
            : payload // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        qos: null == qos
            ? _value.qos
            : qos // ignore: cast_nullable_to_non_nullable
                  as int,
        retained: null == retained
            ? _value.retained
            : retained // ignore: cast_nullable_to_non_nullable
                  as bool,
        duplicate: null == duplicate
            ? _value.duplicate
            : duplicate // ignore: cast_nullable_to_non_nullable
                  as bool,
        detectedType: freezed == detectedType
            ? _value.detectedType
            : detectedType // ignore: cast_nullable_to_non_nullable
                  as PayloadType?,
        protocolVersion: null == protocolVersion
            ? _value.protocolVersion
            : protocolVersion // ignore: cast_nullable_to_non_nullable
                  as MqttProtocolVersion,
        contentType: freezed == contentType
            ? _value.contentType
            : contentType // ignore: cast_nullable_to_non_nullable
                  as String?,
        responseTopic: freezed == responseTopic
            ? _value.responseTopic
            : responseTopic // ignore: cast_nullable_to_non_nullable
                  as String?,
        correlationData: freezed == correlationData
            ? _value._correlationData
            : correlationData // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        messageExpiryInterval: freezed == messageExpiryInterval
            ? _value.messageExpiryInterval
            : messageExpiryInterval // ignore: cast_nullable_to_non_nullable
                  as int?,
        userProperties: freezed == userProperties
            ? _value._userProperties
            : userProperties // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        subscriptionIdentifiers: freezed == subscriptionIdentifiers
            ? _value._subscriptionIdentifiers
            : subscriptionIdentifiers // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MqttMessageImpl implements _MqttMessage {
  const _$MqttMessageImpl({
    required this.id,
    required this.topic,
    required this.payload,
    required this.timestamp,
    this.qos = 0,
    this.retained = false,
    this.duplicate = false,
    this.detectedType,
    required this.protocolVersion,
    this.contentType,
    this.responseTopic,
    final List<int>? correlationData,
    this.messageExpiryInterval,
    final Map<String, String>? userProperties,
    final List<String>? subscriptionIdentifiers,
  }) : _correlationData = correlationData,
       _userProperties = userProperties,
       _subscriptionIdentifiers = subscriptionIdentifiers;

  factory _$MqttMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MqttMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String topic;
  @override
  final String payload;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final int qos;
  @override
  @JsonKey()
  final bool retained;
  @override
  @JsonKey()
  final bool duplicate;
  @override
  final PayloadType? detectedType;
  // MQTT version
  @override
  final MqttProtocolVersion protocolVersion;
  // MQTT 5.0 specific properties
  @override
  final String? contentType;
  @override
  final String? responseTopic;
  final List<int>? _correlationData;
  @override
  List<int>? get correlationData {
    final value = _correlationData;
    if (value == null) return null;
    if (_correlationData is EqualUnmodifiableListView) return _correlationData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? messageExpiryInterval;
  final Map<String, String>? _userProperties;
  @override
  Map<String, String>? get userProperties {
    final value = _userProperties;
    if (value == null) return null;
    if (_userProperties is EqualUnmodifiableMapView) return _userProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _subscriptionIdentifiers;
  @override
  List<String>? get subscriptionIdentifiers {
    final value = _subscriptionIdentifiers;
    if (value == null) return null;
    if (_subscriptionIdentifiers is EqualUnmodifiableListView)
      return _subscriptionIdentifiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MqttMessage(id: $id, topic: $topic, payload: $payload, timestamp: $timestamp, qos: $qos, retained: $retained, duplicate: $duplicate, detectedType: $detectedType, protocolVersion: $protocolVersion, contentType: $contentType, responseTopic: $responseTopic, correlationData: $correlationData, messageExpiryInterval: $messageExpiryInterval, userProperties: $userProperties, subscriptionIdentifiers: $subscriptionIdentifiers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MqttMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.qos, qos) || other.qos == qos) &&
            (identical(other.retained, retained) ||
                other.retained == retained) &&
            (identical(other.duplicate, duplicate) ||
                other.duplicate == duplicate) &&
            (identical(other.detectedType, detectedType) ||
                other.detectedType == detectedType) &&
            (identical(other.protocolVersion, protocolVersion) ||
                other.protocolVersion == protocolVersion) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.responseTopic, responseTopic) ||
                other.responseTopic == responseTopic) &&
            const DeepCollectionEquality().equals(
              other._correlationData,
              _correlationData,
            ) &&
            (identical(other.messageExpiryInterval, messageExpiryInterval) ||
                other.messageExpiryInterval == messageExpiryInterval) &&
            const DeepCollectionEquality().equals(
              other._userProperties,
              _userProperties,
            ) &&
            const DeepCollectionEquality().equals(
              other._subscriptionIdentifiers,
              _subscriptionIdentifiers,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    topic,
    payload,
    timestamp,
    qos,
    retained,
    duplicate,
    detectedType,
    protocolVersion,
    contentType,
    responseTopic,
    const DeepCollectionEquality().hash(_correlationData),
    messageExpiryInterval,
    const DeepCollectionEquality().hash(_userProperties),
    const DeepCollectionEquality().hash(_subscriptionIdentifiers),
  );

  /// Create a copy of MqttMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MqttMessageImplCopyWith<_$MqttMessageImpl> get copyWith =>
      __$$MqttMessageImplCopyWithImpl<_$MqttMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MqttMessageImplToJson(this);
  }
}

abstract class _MqttMessage implements MqttMessage {
  const factory _MqttMessage({
    required final String id,
    required final String topic,
    required final String payload,
    required final DateTime timestamp,
    final int qos,
    final bool retained,
    final bool duplicate,
    final PayloadType? detectedType,
    required final MqttProtocolVersion protocolVersion,
    final String? contentType,
    final String? responseTopic,
    final List<int>? correlationData,
    final int? messageExpiryInterval,
    final Map<String, String>? userProperties,
    final List<String>? subscriptionIdentifiers,
  }) = _$MqttMessageImpl;

  factory _MqttMessage.fromJson(Map<String, dynamic> json) =
      _$MqttMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get topic;
  @override
  String get payload;
  @override
  DateTime get timestamp;
  @override
  int get qos;
  @override
  bool get retained;
  @override
  bool get duplicate;
  @override
  PayloadType? get detectedType; // MQTT version
  @override
  MqttProtocolVersion get protocolVersion; // MQTT 5.0 specific properties
  @override
  String? get contentType;
  @override
  String? get responseTopic;
  @override
  List<int>? get correlationData;
  @override
  int? get messageExpiryInterval;
  @override
  Map<String, String>? get userProperties;
  @override
  List<String>? get subscriptionIdentifiers;

  /// Create a copy of MqttMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MqttMessageImplCopyWith<_$MqttMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
