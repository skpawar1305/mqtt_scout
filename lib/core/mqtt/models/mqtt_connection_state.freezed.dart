// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mqtt_connection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MqttConnectionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() connecting,
    required TResult Function(
      String brokerUrl,
      String clientId,
      DateTime connectedAt,
    )
    connected,
    required TResult Function(String error, DateTime errorAt) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? connecting,
    TResult? Function(String brokerUrl, String clientId, DateTime connectedAt)?
    connected,
    TResult? Function(String error, DateTime errorAt)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? connecting,
    TResult Function(String brokerUrl, String clientId, DateTime connectedAt)?
    connected,
    TResult Function(String error, DateTime errorAt)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MqttConnectionStateCopyWith<$Res> {
  factory $MqttConnectionStateCopyWith(
    MqttConnectionState value,
    $Res Function(MqttConnectionState) then,
  ) = _$MqttConnectionStateCopyWithImpl<$Res, MqttConnectionState>;
}

/// @nodoc
class _$MqttConnectionStateCopyWithImpl<$Res, $Val extends MqttConnectionState>
    implements $MqttConnectionStateCopyWith<$Res> {
  _$MqttConnectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MqttConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DisconnectedImplCopyWith<$Res> {
  factory _$$DisconnectedImplCopyWith(
    _$DisconnectedImpl value,
    $Res Function(_$DisconnectedImpl) then,
  ) = __$$DisconnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisconnectedImplCopyWithImpl<$Res>
    extends _$MqttConnectionStateCopyWithImpl<$Res, _$DisconnectedImpl>
    implements _$$DisconnectedImplCopyWith<$Res> {
  __$$DisconnectedImplCopyWithImpl(
    _$DisconnectedImpl _value,
    $Res Function(_$DisconnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MqttConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DisconnectedImpl implements Disconnected {
  const _$DisconnectedImpl();

  @override
  String toString() {
    return 'MqttConnectionState.disconnected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DisconnectedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() connecting,
    required TResult Function(
      String brokerUrl,
      String clientId,
      DateTime connectedAt,
    )
    connected,
    required TResult Function(String error, DateTime errorAt) error,
  }) {
    return disconnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? connecting,
    TResult? Function(String brokerUrl, String clientId, DateTime connectedAt)?
    connected,
    TResult? Function(String error, DateTime errorAt)? error,
  }) {
    return disconnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? connecting,
    TResult Function(String brokerUrl, String clientId, DateTime connectedAt)?
    connected,
    TResult Function(String error, DateTime errorAt)? error,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) {
    return disconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) {
    return disconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(this);
    }
    return orElse();
  }
}

abstract class Disconnected implements MqttConnectionState {
  const factory Disconnected() = _$DisconnectedImpl;
}

/// @nodoc
abstract class _$$ConnectingImplCopyWith<$Res> {
  factory _$$ConnectingImplCopyWith(
    _$ConnectingImpl value,
    $Res Function(_$ConnectingImpl) then,
  ) = __$$ConnectingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectingImplCopyWithImpl<$Res>
    extends _$MqttConnectionStateCopyWithImpl<$Res, _$ConnectingImpl>
    implements _$$ConnectingImplCopyWith<$Res> {
  __$$ConnectingImplCopyWithImpl(
    _$ConnectingImpl _value,
    $Res Function(_$ConnectingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MqttConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectingImpl implements Connecting {
  const _$ConnectingImpl();

  @override
  String toString() {
    return 'MqttConnectionState.connecting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() connecting,
    required TResult Function(
      String brokerUrl,
      String clientId,
      DateTime connectedAt,
    )
    connected,
    required TResult Function(String error, DateTime errorAt) error,
  }) {
    return connecting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? connecting,
    TResult? Function(String brokerUrl, String clientId, DateTime connectedAt)?
    connected,
    TResult? Function(String error, DateTime errorAt)? error,
  }) {
    return connecting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? connecting,
    TResult Function(String brokerUrl, String clientId, DateTime connectedAt)?
    connected,
    TResult Function(String error, DateTime errorAt)? error,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) {
    return connecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) {
    return connecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting(this);
    }
    return orElse();
  }
}

abstract class Connecting implements MqttConnectionState {
  const factory Connecting() = _$ConnectingImpl;
}

/// @nodoc
abstract class _$$ConnectedImplCopyWith<$Res> {
  factory _$$ConnectedImplCopyWith(
    _$ConnectedImpl value,
    $Res Function(_$ConnectedImpl) then,
  ) = __$$ConnectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String brokerUrl, String clientId, DateTime connectedAt});
}

/// @nodoc
class __$$ConnectedImplCopyWithImpl<$Res>
    extends _$MqttConnectionStateCopyWithImpl<$Res, _$ConnectedImpl>
    implements _$$ConnectedImplCopyWith<$Res> {
  __$$ConnectedImplCopyWithImpl(
    _$ConnectedImpl _value,
    $Res Function(_$ConnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MqttConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brokerUrl = null,
    Object? clientId = null,
    Object? connectedAt = null,
  }) {
    return _then(
      _$ConnectedImpl(
        brokerUrl: null == brokerUrl
            ? _value.brokerUrl
            : brokerUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        connectedAt: null == connectedAt
            ? _value.connectedAt
            : connectedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$ConnectedImpl implements Connected {
  const _$ConnectedImpl({
    required this.brokerUrl,
    required this.clientId,
    required this.connectedAt,
  });

  @override
  final String brokerUrl;
  @override
  final String clientId;
  @override
  final DateTime connectedAt;

  @override
  String toString() {
    return 'MqttConnectionState.connected(brokerUrl: $brokerUrl, clientId: $clientId, connectedAt: $connectedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectedImpl &&
            (identical(other.brokerUrl, brokerUrl) ||
                other.brokerUrl == brokerUrl) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.connectedAt, connectedAt) ||
                other.connectedAt == connectedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, brokerUrl, clientId, connectedAt);

  /// Create a copy of MqttConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectedImplCopyWith<_$ConnectedImpl> get copyWith =>
      __$$ConnectedImplCopyWithImpl<_$ConnectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() connecting,
    required TResult Function(
      String brokerUrl,
      String clientId,
      DateTime connectedAt,
    )
    connected,
    required TResult Function(String error, DateTime errorAt) error,
  }) {
    return connected(brokerUrl, clientId, connectedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? connecting,
    TResult? Function(String brokerUrl, String clientId, DateTime connectedAt)?
    connected,
    TResult? Function(String error, DateTime errorAt)? error,
  }) {
    return connected?.call(brokerUrl, clientId, connectedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? connecting,
    TResult Function(String brokerUrl, String clientId, DateTime connectedAt)?
    connected,
    TResult Function(String error, DateTime errorAt)? error,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(brokerUrl, clientId, connectedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }
}

abstract class Connected implements MqttConnectionState {
  const factory Connected({
    required final String brokerUrl,
    required final String clientId,
    required final DateTime connectedAt,
  }) = _$ConnectedImpl;

  String get brokerUrl;
  String get clientId;
  DateTime get connectedAt;

  /// Create a copy of MqttConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectedImplCopyWith<_$ConnectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionErrorImplCopyWith<$Res> {
  factory _$$ConnectionErrorImplCopyWith(
    _$ConnectionErrorImpl value,
    $Res Function(_$ConnectionErrorImpl) then,
  ) = __$$ConnectionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error, DateTime errorAt});
}

/// @nodoc
class __$$ConnectionErrorImplCopyWithImpl<$Res>
    extends _$MqttConnectionStateCopyWithImpl<$Res, _$ConnectionErrorImpl>
    implements _$$ConnectionErrorImplCopyWith<$Res> {
  __$$ConnectionErrorImplCopyWithImpl(
    _$ConnectionErrorImpl _value,
    $Res Function(_$ConnectionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MqttConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null, Object? errorAt = null}) {
    return _then(
      _$ConnectionErrorImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
        errorAt: null == errorAt
            ? _value.errorAt
            : errorAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$ConnectionErrorImpl implements ConnectionError {
  const _$ConnectionErrorImpl({required this.error, required this.errorAt});

  @override
  final String error;
  @override
  final DateTime errorAt;

  @override
  String toString() {
    return 'MqttConnectionState.error(error: $error, errorAt: $errorAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionErrorImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.errorAt, errorAt) || other.errorAt == errorAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, errorAt);

  /// Create a copy of MqttConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionErrorImplCopyWith<_$ConnectionErrorImpl> get copyWith =>
      __$$ConnectionErrorImplCopyWithImpl<_$ConnectionErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() disconnected,
    required TResult Function() connecting,
    required TResult Function(
      String brokerUrl,
      String clientId,
      DateTime connectedAt,
    )
    connected,
    required TResult Function(String error, DateTime errorAt) error,
  }) {
    return error(this.error, errorAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? disconnected,
    TResult? Function()? connecting,
    TResult? Function(String brokerUrl, String clientId, DateTime connectedAt)?
    connected,
    TResult? Function(String error, DateTime errorAt)? error,
  }) {
    return error?.call(this.error, errorAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? disconnected,
    TResult Function()? connecting,
    TResult Function(String brokerUrl, String clientId, DateTime connectedAt)?
    connected,
    TResult Function(String error, DateTime errorAt)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, errorAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Connecting value) connecting,
    required TResult Function(Connected value) connected,
    required TResult Function(ConnectionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Connecting value)? connecting,
    TResult? Function(Connected value)? connected,
    TResult? Function(ConnectionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Connecting value)? connecting,
    TResult Function(Connected value)? connected,
    TResult Function(ConnectionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ConnectionError implements MqttConnectionState {
  const factory ConnectionError({
    required final String error,
    required final DateTime errorAt,
  }) = _$ConnectionErrorImpl;

  String get error;
  DateTime get errorAt;

  /// Create a copy of MqttConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionErrorImplCopyWith<_$ConnectionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
