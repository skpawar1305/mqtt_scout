// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'publish_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PublishTemplate _$PublishTemplateFromJson(Map<String, dynamic> json) {
  return _PublishTemplate.fromJson(json);
}

/// @nodoc
mixin _$PublishTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String get payload => throw _privateConstructorUsedError;
  int get qos => throw _privateConstructorUsedError;
  bool get retain => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Map<String, String>? get userProperties =>
      throw _privateConstructorUsedError; // MQTT 5.0
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastUsed => throw _privateConstructorUsedError;

  /// Serializes this PublishTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublishTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublishTemplateCopyWith<PublishTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublishTemplateCopyWith<$Res> {
  factory $PublishTemplateCopyWith(
    PublishTemplate value,
    $Res Function(PublishTemplate) then,
  ) = _$PublishTemplateCopyWithImpl<$Res, PublishTemplate>;
  @useResult
  $Res call({
    String id,
    String name,
    String topic,
    String payload,
    int qos,
    bool retain,
    String? description,
    Map<String, String>? userProperties,
    DateTime? createdAt,
    DateTime? lastUsed,
  });
}

/// @nodoc
class _$PublishTemplateCopyWithImpl<$Res, $Val extends PublishTemplate>
    implements $PublishTemplateCopyWith<$Res> {
  _$PublishTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublishTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? topic = null,
    Object? payload = null,
    Object? qos = null,
    Object? retain = null,
    Object? description = freezed,
    Object? userProperties = freezed,
    Object? createdAt = freezed,
    Object? lastUsed = freezed,
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
            topic: null == topic
                ? _value.topic
                : topic // ignore: cast_nullable_to_non_nullable
                      as String,
            payload: null == payload
                ? _value.payload
                : payload // ignore: cast_nullable_to_non_nullable
                      as String,
            qos: null == qos
                ? _value.qos
                : qos // ignore: cast_nullable_to_non_nullable
                      as int,
            retain: null == retain
                ? _value.retain
                : retain // ignore: cast_nullable_to_non_nullable
                      as bool,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            userProperties: freezed == userProperties
                ? _value.userProperties
                : userProperties // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastUsed: freezed == lastUsed
                ? _value.lastUsed
                : lastUsed // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PublishTemplateImplCopyWith<$Res>
    implements $PublishTemplateCopyWith<$Res> {
  factory _$$PublishTemplateImplCopyWith(
    _$PublishTemplateImpl value,
    $Res Function(_$PublishTemplateImpl) then,
  ) = __$$PublishTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String topic,
    String payload,
    int qos,
    bool retain,
    String? description,
    Map<String, String>? userProperties,
    DateTime? createdAt,
    DateTime? lastUsed,
  });
}

/// @nodoc
class __$$PublishTemplateImplCopyWithImpl<$Res>
    extends _$PublishTemplateCopyWithImpl<$Res, _$PublishTemplateImpl>
    implements _$$PublishTemplateImplCopyWith<$Res> {
  __$$PublishTemplateImplCopyWithImpl(
    _$PublishTemplateImpl _value,
    $Res Function(_$PublishTemplateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PublishTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? topic = null,
    Object? payload = null,
    Object? qos = null,
    Object? retain = null,
    Object? description = freezed,
    Object? userProperties = freezed,
    Object? createdAt = freezed,
    Object? lastUsed = freezed,
  }) {
    return _then(
      _$PublishTemplateImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        topic: null == topic
            ? _value.topic
            : topic // ignore: cast_nullable_to_non_nullable
                  as String,
        payload: null == payload
            ? _value.payload
            : payload // ignore: cast_nullable_to_non_nullable
                  as String,
        qos: null == qos
            ? _value.qos
            : qos // ignore: cast_nullable_to_non_nullable
                  as int,
        retain: null == retain
            ? _value.retain
            : retain // ignore: cast_nullable_to_non_nullable
                  as bool,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        userProperties: freezed == userProperties
            ? _value._userProperties
            : userProperties // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastUsed: freezed == lastUsed
            ? _value.lastUsed
            : lastUsed // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PublishTemplateImpl implements _PublishTemplate {
  const _$PublishTemplateImpl({
    required this.id,
    required this.name,
    required this.topic,
    required this.payload,
    this.qos = 0,
    this.retain = false,
    this.description,
    final Map<String, String>? userProperties,
    this.createdAt,
    this.lastUsed,
  }) : _userProperties = userProperties;

  factory _$PublishTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublishTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String topic;
  @override
  final String payload;
  @override
  @JsonKey()
  final int qos;
  @override
  @JsonKey()
  final bool retain;
  @override
  final String? description;
  final Map<String, String>? _userProperties;
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
  final DateTime? createdAt;
  @override
  final DateTime? lastUsed;

  @override
  String toString() {
    return 'PublishTemplate(id: $id, name: $name, topic: $topic, payload: $payload, qos: $qos, retain: $retain, description: $description, userProperties: $userProperties, createdAt: $createdAt, lastUsed: $lastUsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublishTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.qos, qos) || other.qos == qos) &&
            (identical(other.retain, retain) || other.retain == retain) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._userProperties,
              _userProperties,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    topic,
    payload,
    qos,
    retain,
    description,
    const DeepCollectionEquality().hash(_userProperties),
    createdAt,
    lastUsed,
  );

  /// Create a copy of PublishTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublishTemplateImplCopyWith<_$PublishTemplateImpl> get copyWith =>
      __$$PublishTemplateImplCopyWithImpl<_$PublishTemplateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PublishTemplateImplToJson(this);
  }
}

abstract class _PublishTemplate implements PublishTemplate {
  const factory _PublishTemplate({
    required final String id,
    required final String name,
    required final String topic,
    required final String payload,
    final int qos,
    final bool retain,
    final String? description,
    final Map<String, String>? userProperties,
    final DateTime? createdAt,
    final DateTime? lastUsed,
  }) = _$PublishTemplateImpl;

  factory _PublishTemplate.fromJson(Map<String, dynamic> json) =
      _$PublishTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get topic;
  @override
  String get payload;
  @override
  int get qos;
  @override
  bool get retain;
  @override
  String? get description;
  @override
  Map<String, String>? get userProperties; // MQTT 5.0
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastUsed;

  /// Create a copy of PublishTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublishTemplateImplCopyWith<_$PublishTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
