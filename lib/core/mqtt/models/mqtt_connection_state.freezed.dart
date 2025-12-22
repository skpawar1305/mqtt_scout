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
mixin _$MqttConnectionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(int attempt) reconnecting,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(int attempt)? reconnecting,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(int attempt)? reconnecting,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Error value) error,
    required TResult Function(Reconnecting value) reconnecting,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Error value)? error,
    TResult? Function(Reconnecting value)? reconnecting,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Error value)? error,
    TResult Function(Reconnecting value)? reconnecting,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MqttConnectionEventCopyWith<$Res> {
  factory $MqttConnectionEventCopyWith(
    MqttConnectionEvent value,
    $Res Function(MqttConnectionEvent) then,
  ) = _$MqttConnectionEventCopyWithImpl<$Res, MqttConnectionEvent>;
}

/// @nodoc
class _$MqttConnectionEventCopyWithImpl<$Res, $Val extends MqttConnectionEvent>
    implements $MqttConnectionEventCopyWith<$Res> {
  _$MqttConnectionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MqttConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConnectedImplCopyWith<$Res> {
  factory _$$ConnectedImplCopyWith(
    _$ConnectedImpl value,
    $Res Function(_$ConnectedImpl) then,
  ) = __$$ConnectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectedImplCopyWithImpl<$Res>
    extends _$MqttConnectionEventCopyWithImpl<$Res, _$ConnectedImpl>
    implements _$$ConnectedImplCopyWith<$Res> {
  __$$ConnectedImplCopyWithImpl(
    _$ConnectedImpl _value,
    $Res Function(_$ConnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MqttConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectedImpl implements Connected {
  const _$ConnectedImpl();

  @override
  String toString() {
    return 'MqttConnectionEvent.connected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(int attempt) reconnecting,
  }) {
    return connected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(int attempt)? reconnecting,
  }) {
    return connected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(int attempt)? reconnecting,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Error value) error,
    required TResult Function(Reconnecting value) reconnecting,
  }) {
    return connected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Error value)? error,
    TResult? Function(Reconnecting value)? reconnecting,
  }) {
    return connected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Error value)? error,
    TResult Function(Reconnecting value)? reconnecting,
    required TResult orElse(),
  }) {
    if (connected != null) {
      return connected(this);
    }
    return orElse();
  }
}

abstract class Connected implements MqttConnectionEvent {
  const factory Connected() = _$ConnectedImpl;
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
    extends _$MqttConnectionEventCopyWithImpl<$Res, _$DisconnectedImpl>
    implements _$$DisconnectedImplCopyWith<$Res> {
  __$$DisconnectedImplCopyWithImpl(
    _$DisconnectedImpl _value,
    $Res Function(_$DisconnectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MqttConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DisconnectedImpl implements Disconnected {
  const _$DisconnectedImpl();

  @override
  String toString() {
    return 'MqttConnectionEvent.disconnected()';
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
    required TResult Function() connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(int attempt) reconnecting,
  }) {
    return disconnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(int attempt)? reconnecting,
  }) {
    return disconnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(int attempt)? reconnecting,
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
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Error value) error,
    required TResult Function(Reconnecting value) reconnecting,
  }) {
    return disconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Error value)? error,
    TResult? Function(Reconnecting value)? reconnecting,
  }) {
    return disconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Error value)? error,
    TResult Function(Reconnecting value)? reconnecting,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(this);
    }
    return orElse();
  }
}

abstract class Disconnected implements MqttConnectionEvent {
  const factory Disconnected() = _$DisconnectedImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$MqttConnectionEventCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MqttConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'MqttConnectionEvent.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MqttConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(int attempt) reconnecting,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(int attempt)? reconnecting,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(int attempt)? reconnecting,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Error value) error,
    required TResult Function(Reconnecting value) reconnecting,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Error value)? error,
    TResult? Function(Reconnecting value)? reconnecting,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Error value)? error,
    TResult Function(Reconnecting value)? reconnecting,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements MqttConnectionEvent {
  const factory Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of MqttConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReconnectingImplCopyWith<$Res> {
  factory _$$ReconnectingImplCopyWith(
    _$ReconnectingImpl value,
    $Res Function(_$ReconnectingImpl) then,
  ) = __$$ReconnectingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int attempt});
}

/// @nodoc
class __$$ReconnectingImplCopyWithImpl<$Res>
    extends _$MqttConnectionEventCopyWithImpl<$Res, _$ReconnectingImpl>
    implements _$$ReconnectingImplCopyWith<$Res> {
  __$$ReconnectingImplCopyWithImpl(
    _$ReconnectingImpl _value,
    $Res Function(_$ReconnectingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MqttConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? attempt = null}) {
    return _then(
      _$ReconnectingImpl(
        null == attempt
            ? _value.attempt
            : attempt // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ReconnectingImpl implements Reconnecting {
  const _$ReconnectingImpl(this.attempt);

  @override
  final int attempt;

  @override
  String toString() {
    return 'MqttConnectionEvent.reconnecting(attempt: $attempt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconnectingImpl &&
            (identical(other.attempt, attempt) || other.attempt == attempt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, attempt);

  /// Create a copy of MqttConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconnectingImplCopyWith<_$ReconnectingImpl> get copyWith =>
      __$$ReconnectingImplCopyWithImpl<_$ReconnectingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connected,
    required TResult Function() disconnected,
    required TResult Function(String message) error,
    required TResult Function(int attempt) reconnecting,
  }) {
    return reconnecting(attempt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connected,
    TResult? Function()? disconnected,
    TResult? Function(String message)? error,
    TResult? Function(int attempt)? reconnecting,
  }) {
    return reconnecting?.call(attempt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connected,
    TResult Function()? disconnected,
    TResult Function(String message)? error,
    TResult Function(int attempt)? reconnecting,
    required TResult orElse(),
  }) {
    if (reconnecting != null) {
      return reconnecting(attempt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Connected value) connected,
    required TResult Function(Disconnected value) disconnected,
    required TResult Function(Error value) error,
    required TResult Function(Reconnecting value) reconnecting,
  }) {
    return reconnecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Connected value)? connected,
    TResult? Function(Disconnected value)? disconnected,
    TResult? Function(Error value)? error,
    TResult? Function(Reconnecting value)? reconnecting,
  }) {
    return reconnecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Connected value)? connected,
    TResult Function(Disconnected value)? disconnected,
    TResult Function(Error value)? error,
    TResult Function(Reconnecting value)? reconnecting,
    required TResult orElse(),
  }) {
    if (reconnecting != null) {
      return reconnecting(this);
    }
    return orElse();
  }
}

abstract class Reconnecting implements MqttConnectionEvent {
  const factory Reconnecting(final int attempt) = _$ReconnectingImpl;

  int get attempt;

  /// Create a copy of MqttConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconnectingImplCopyWith<_$ReconnectingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
