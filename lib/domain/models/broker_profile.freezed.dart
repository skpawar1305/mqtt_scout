// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'broker_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BrokerProfile _$BrokerProfileFromJson(Map<String, dynamic> json) {
  return _BrokerProfile.fromJson(json);
}

/// @nodoc
mixin _$BrokerProfile {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get host => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  bool get useTls => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  int get keepAlive => throw _privateConstructorUsedError;
  bool get cleanSession =>
      throw _privateConstructorUsedError; // Protocol version
  MqttProtocolVersion get protocolVersion => throw _privateConstructorUsedError;
  bool get autoDetectProtocol =>
      throw _privateConstructorUsedError; // Try 5.0, fallback to 3.1.1
  // Last Will Testament (both versions)
  String? get lastWillTopic => throw _privateConstructorUsedError;
  String? get lastWillMessage => throw _privateConstructorUsedError;
  int get lastWillQos => throw _privateConstructorUsedError;
  bool get lastWillRetain =>
      throw _privateConstructorUsedError; // MQTT 5.0 specific
  int? get sessionExpiryInterval => throw _privateConstructorUsedError;
  int? get maxPacketSize => throw _privateConstructorUsedError;
  int? get topicAliasMaximum => throw _privateConstructorUsedError;
  Map<String, String>? get userProperties => throw _privateConstructorUsedError;
  DateTime? get lastConnected => throw _privateConstructorUsedError;
  bool get validateCertificates => throw _privateConstructorUsedError;

  /// Serializes this BrokerProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrokerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrokerProfileCopyWith<BrokerProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrokerProfileCopyWith<$Res> {
  factory $BrokerProfileCopyWith(
    BrokerProfile value,
    $Res Function(BrokerProfile) then,
  ) = _$BrokerProfileCopyWithImpl<$Res, BrokerProfile>;
  @useResult
  $Res call({
    String id,
    String name,
    String host,
    int port,
    bool useTls,
    String? username,
    String? password,
    String clientId,
    int keepAlive,
    bool cleanSession,
    MqttProtocolVersion protocolVersion,
    bool autoDetectProtocol,
    String? lastWillTopic,
    String? lastWillMessage,
    int lastWillQos,
    bool lastWillRetain,
    int? sessionExpiryInterval,
    int? maxPacketSize,
    int? topicAliasMaximum,
    Map<String, String>? userProperties,
    DateTime? lastConnected,
    bool validateCertificates,
  });
}

/// @nodoc
class _$BrokerProfileCopyWithImpl<$Res, $Val extends BrokerProfile>
    implements $BrokerProfileCopyWith<$Res> {
  _$BrokerProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrokerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? host = null,
    Object? port = null,
    Object? useTls = null,
    Object? username = freezed,
    Object? password = freezed,
    Object? clientId = null,
    Object? keepAlive = null,
    Object? cleanSession = null,
    Object? protocolVersion = null,
    Object? autoDetectProtocol = null,
    Object? lastWillTopic = freezed,
    Object? lastWillMessage = freezed,
    Object? lastWillQos = null,
    Object? lastWillRetain = null,
    Object? sessionExpiryInterval = freezed,
    Object? maxPacketSize = freezed,
    Object? topicAliasMaximum = freezed,
    Object? userProperties = freezed,
    Object? lastConnected = freezed,
    Object? validateCertificates = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            host: null == host
                ? _value.host
                : host // ignore: cast_nullable_to_non_nullable
                      as String,
            port: null == port
                ? _value.port
                : port // ignore: cast_nullable_to_non_nullable
                      as int,
            useTls: null == useTls
                ? _value.useTls
                : useTls // ignore: cast_nullable_to_non_nullable
                      as bool,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            password: freezed == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String,
            keepAlive: null == keepAlive
                ? _value.keepAlive
                : keepAlive // ignore: cast_nullable_to_non_nullable
                      as int,
            cleanSession: null == cleanSession
                ? _value.cleanSession
                : cleanSession // ignore: cast_nullable_to_non_nullable
                      as bool,
            protocolVersion: null == protocolVersion
                ? _value.protocolVersion
                : protocolVersion // ignore: cast_nullable_to_non_nullable
                      as MqttProtocolVersion,
            autoDetectProtocol: null == autoDetectProtocol
                ? _value.autoDetectProtocol
                : autoDetectProtocol // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastWillTopic: freezed == lastWillTopic
                ? _value.lastWillTopic
                : lastWillTopic // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastWillMessage: freezed == lastWillMessage
                ? _value.lastWillMessage
                : lastWillMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastWillQos: null == lastWillQos
                ? _value.lastWillQos
                : lastWillQos // ignore: cast_nullable_to_non_nullable
                      as int,
            lastWillRetain: null == lastWillRetain
                ? _value.lastWillRetain
                : lastWillRetain // ignore: cast_nullable_to_non_nullable
                      as bool,
            sessionExpiryInterval: freezed == sessionExpiryInterval
                ? _value.sessionExpiryInterval
                : sessionExpiryInterval // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxPacketSize: freezed == maxPacketSize
                ? _value.maxPacketSize
                : maxPacketSize // ignore: cast_nullable_to_non_nullable
                      as int?,
            topicAliasMaximum: freezed == topicAliasMaximum
                ? _value.topicAliasMaximum
                : topicAliasMaximum // ignore: cast_nullable_to_non_nullable
                      as int?,
            userProperties: freezed == userProperties
                ? _value.userProperties
                : userProperties // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            lastConnected: freezed == lastConnected
                ? _value.lastConnected
                : lastConnected // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            validateCertificates: null == validateCertificates
                ? _value.validateCertificates
                : validateCertificates // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BrokerProfileImplCopyWith<$Res>
    implements $BrokerProfileCopyWith<$Res> {
  factory _$$BrokerProfileImplCopyWith(
    _$BrokerProfileImpl value,
    $Res Function(_$BrokerProfileImpl) then,
  ) = __$$BrokerProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String host,
    int port,
    bool useTls,
    String? username,
    String? password,
    String clientId,
    int keepAlive,
    bool cleanSession,
    MqttProtocolVersion protocolVersion,
    bool autoDetectProtocol,
    String? lastWillTopic,
    String? lastWillMessage,
    int lastWillQos,
    bool lastWillRetain,
    int? sessionExpiryInterval,
    int? maxPacketSize,
    int? topicAliasMaximum,
    Map<String, String>? userProperties,
    DateTime? lastConnected,
    bool validateCertificates,
  });
}

/// @nodoc
class __$$BrokerProfileImplCopyWithImpl<$Res>
    extends _$BrokerProfileCopyWithImpl<$Res, _$BrokerProfileImpl>
    implements _$$BrokerProfileImplCopyWith<$Res> {
  __$$BrokerProfileImplCopyWithImpl(
    _$BrokerProfileImpl _value,
    $Res Function(_$BrokerProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrokerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? host = null,
    Object? port = null,
    Object? useTls = null,
    Object? username = freezed,
    Object? password = freezed,
    Object? clientId = null,
    Object? keepAlive = null,
    Object? cleanSession = null,
    Object? protocolVersion = null,
    Object? autoDetectProtocol = null,
    Object? lastWillTopic = freezed,
    Object? lastWillMessage = freezed,
    Object? lastWillQos = null,
    Object? lastWillRetain = null,
    Object? sessionExpiryInterval = freezed,
    Object? maxPacketSize = freezed,
    Object? topicAliasMaximum = freezed,
    Object? userProperties = freezed,
    Object? lastConnected = freezed,
    Object? validateCertificates = null,
  }) {
    return _then(
      _$BrokerProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        host: null == host
            ? _value.host
            : host // ignore: cast_nullable_to_non_nullable
                  as String,
        port: null == port
            ? _value.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int,
        useTls: null == useTls
            ? _value.useTls
            : useTls // ignore: cast_nullable_to_non_nullable
                  as bool,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        password: freezed == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        keepAlive: null == keepAlive
            ? _value.keepAlive
            : keepAlive // ignore: cast_nullable_to_non_nullable
                  as int,
        cleanSession: null == cleanSession
            ? _value.cleanSession
            : cleanSession // ignore: cast_nullable_to_non_nullable
                  as bool,
        protocolVersion: null == protocolVersion
            ? _value.protocolVersion
            : protocolVersion // ignore: cast_nullable_to_non_nullable
                  as MqttProtocolVersion,
        autoDetectProtocol: null == autoDetectProtocol
            ? _value.autoDetectProtocol
            : autoDetectProtocol // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastWillTopic: freezed == lastWillTopic
            ? _value.lastWillTopic
            : lastWillTopic // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastWillMessage: freezed == lastWillMessage
            ? _value.lastWillMessage
            : lastWillMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastWillQos: null == lastWillQos
            ? _value.lastWillQos
            : lastWillQos // ignore: cast_nullable_to_non_nullable
                  as int,
        lastWillRetain: null == lastWillRetain
            ? _value.lastWillRetain
            : lastWillRetain // ignore: cast_nullable_to_non_nullable
                  as bool,
        sessionExpiryInterval: freezed == sessionExpiryInterval
            ? _value.sessionExpiryInterval
            : sessionExpiryInterval // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxPacketSize: freezed == maxPacketSize
            ? _value.maxPacketSize
            : maxPacketSize // ignore: cast_nullable_to_non_nullable
                  as int?,
        topicAliasMaximum: freezed == topicAliasMaximum
            ? _value.topicAliasMaximum
            : topicAliasMaximum // ignore: cast_nullable_to_non_nullable
                  as int?,
        userProperties: freezed == userProperties
            ? _value._userProperties
            : userProperties // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        lastConnected: freezed == lastConnected
            ? _value.lastConnected
            : lastConnected // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        validateCertificates: null == validateCertificates
            ? _value.validateCertificates
            : validateCertificates // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BrokerProfileImpl implements _BrokerProfile {
  const _$BrokerProfileImpl({
    required this.id,
    required this.name,
    required this.host,
    this.port = 1883,
    this.useTls = false,
    this.username,
    this.password,
    required this.clientId,
    this.keepAlive = 60,
    this.cleanSession = true,
    this.protocolVersion = MqttProtocolVersion.v5,
    this.autoDetectProtocol = true,
    this.lastWillTopic,
    this.lastWillMessage,
    this.lastWillQos = 0,
    this.lastWillRetain = false,
    this.sessionExpiryInterval,
    this.maxPacketSize,
    this.topicAliasMaximum,
    final Map<String, String>? userProperties,
    this.lastConnected,
    this.validateCertificates = true,
  }) : _userProperties = userProperties;

  factory _$BrokerProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrokerProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String host;
  @override
  @JsonKey()
  final int port;
  @override
  @JsonKey()
  final bool useTls;
  @override
  final String? username;
  @override
  final String? password;
  @override
  final String clientId;
  @override
  @JsonKey()
  final int keepAlive;
  @override
  @JsonKey()
  final bool cleanSession;
  // Protocol version
  @override
  @JsonKey()
  final MqttProtocolVersion protocolVersion;
  @override
  @JsonKey()
  final bool autoDetectProtocol;
  // Try 5.0, fallback to 3.1.1
  // Last Will Testament (both versions)
  @override
  final String? lastWillTopic;
  @override
  final String? lastWillMessage;
  @override
  @JsonKey()
  final int lastWillQos;
  @override
  @JsonKey()
  final bool lastWillRetain;
  // MQTT 5.0 specific
  @override
  final int? sessionExpiryInterval;
  @override
  final int? maxPacketSize;
  @override
  final int? topicAliasMaximum;
  final Map<String, String>? _userProperties;
  @override
  Map<String, String>? get userProperties {
    final value = _userProperties;
    if (value == null) return null;
    if (_userProperties is EqualUnmodifiableMapView) return _userProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? lastConnected;
  @override
  @JsonKey()
  final bool validateCertificates;

  @override
  String toString() {
    return 'BrokerProfile(id: $id, name: $name, host: $host, port: $port, useTls: $useTls, username: $username, password: $password, clientId: $clientId, keepAlive: $keepAlive, cleanSession: $cleanSession, protocolVersion: $protocolVersion, autoDetectProtocol: $autoDetectProtocol, lastWillTopic: $lastWillTopic, lastWillMessage: $lastWillMessage, lastWillQos: $lastWillQos, lastWillRetain: $lastWillRetain, sessionExpiryInterval: $sessionExpiryInterval, maxPacketSize: $maxPacketSize, topicAliasMaximum: $topicAliasMaximum, userProperties: $userProperties, lastConnected: $lastConnected, validateCertificates: $validateCertificates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrokerProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.useTls, useTls) || other.useTls == useTls) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.keepAlive, keepAlive) ||
                other.keepAlive == keepAlive) &&
            (identical(other.cleanSession, cleanSession) ||
                other.cleanSession == cleanSession) &&
            (identical(other.protocolVersion, protocolVersion) ||
                other.protocolVersion == protocolVersion) &&
            (identical(other.autoDetectProtocol, autoDetectProtocol) ||
                other.autoDetectProtocol == autoDetectProtocol) &&
            (identical(other.lastWillTopic, lastWillTopic) ||
                other.lastWillTopic == lastWillTopic) &&
            (identical(other.lastWillMessage, lastWillMessage) ||
                other.lastWillMessage == lastWillMessage) &&
            (identical(other.lastWillQos, lastWillQos) ||
                other.lastWillQos == lastWillQos) &&
            (identical(other.lastWillRetain, lastWillRetain) ||
                other.lastWillRetain == lastWillRetain) &&
            (identical(other.sessionExpiryInterval, sessionExpiryInterval) ||
                other.sessionExpiryInterval == sessionExpiryInterval) &&
            (identical(other.maxPacketSize, maxPacketSize) ||
                other.maxPacketSize == maxPacketSize) &&
            (identical(other.topicAliasMaximum, topicAliasMaximum) ||
                other.topicAliasMaximum == topicAliasMaximum) &&
            const DeepCollectionEquality().equals(
              other._userProperties,
              _userProperties,
            ) &&
            (identical(other.lastConnected, lastConnected) ||
                other.lastConnected == lastConnected) &&
            (identical(other.validateCertificates, validateCertificates) ||
                other.validateCertificates == validateCertificates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    host,
    port,
    useTls,
    username,
    password,
    clientId,
    keepAlive,
    cleanSession,
    protocolVersion,
    autoDetectProtocol,
    lastWillTopic,
    lastWillMessage,
    lastWillQos,
    lastWillRetain,
    sessionExpiryInterval,
    maxPacketSize,
    topicAliasMaximum,
    const DeepCollectionEquality().hash(_userProperties),
    lastConnected,
    validateCertificates,
  ]);

  /// Create a copy of BrokerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrokerProfileImplCopyWith<_$BrokerProfileImpl> get copyWith =>
      __$$BrokerProfileImplCopyWithImpl<_$BrokerProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrokerProfileImplToJson(this);
  }
}

abstract class _BrokerProfile implements BrokerProfile {
  const factory _BrokerProfile({
    required final String id,
    required final String name,
    required final String host,
    final int port,
    final bool useTls,
    final String? username,
    final String? password,
    required final String clientId,
    final int keepAlive,
    final bool cleanSession,
    final MqttProtocolVersion protocolVersion,
    final bool autoDetectProtocol,
    final String? lastWillTopic,
    final String? lastWillMessage,
    final int lastWillQos,
    final bool lastWillRetain,
    final int? sessionExpiryInterval,
    final int? maxPacketSize,
    final int? topicAliasMaximum,
    final Map<String, String>? userProperties,
    final DateTime? lastConnected,
    final bool validateCertificates,
  }) = _$BrokerProfileImpl;

  factory _BrokerProfile.fromJson(Map<String, dynamic> json) =
      _$BrokerProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get host;
  @override
  int get port;
  @override
  bool get useTls;
  @override
  String? get username;
  @override
  String? get password;
  @override
  String get clientId;
  @override
  int get keepAlive;
  @override
  bool get cleanSession; // Protocol version
  @override
  MqttProtocolVersion get protocolVersion;
  @override
  bool get autoDetectProtocol; // Try 5.0, fallback to 3.1.1
  // Last Will Testament (both versions)
  @override
  String? get lastWillTopic;
  @override
  String? get lastWillMessage;
  @override
  int get lastWillQos;
  @override
  bool get lastWillRetain; // MQTT 5.0 specific
  @override
  int? get sessionExpiryInterval;
  @override
  int? get maxPacketSize;
  @override
  int? get topicAliasMaximum;
  @override
  Map<String, String>? get userProperties;
  @override
  DateTime? get lastConnected;
  @override
  bool get validateCertificates;

  /// Create a copy of BrokerProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrokerProfileImplCopyWith<_$BrokerProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
