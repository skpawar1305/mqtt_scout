// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topic_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TopicFilter {
  String get query => throw _privateConstructorUsedError;
  bool get isRegex => throw _privateConstructorUsedError;
  bool get showRetainedOnly => throw _privateConstructorUsedError;
  bool get showActiveOnly => throw _privateConstructorUsedError;

  /// Create a copy of TopicFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicFilterCopyWith<TopicFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicFilterCopyWith<$Res> {
  factory $TopicFilterCopyWith(
    TopicFilter value,
    $Res Function(TopicFilter) then,
  ) = _$TopicFilterCopyWithImpl<$Res, TopicFilter>;
  @useResult
  $Res call({
    String query,
    bool isRegex,
    bool showRetainedOnly,
    bool showActiveOnly,
  });
}

/// @nodoc
class _$TopicFilterCopyWithImpl<$Res, $Val extends TopicFilter>
    implements $TopicFilterCopyWith<$Res> {
  _$TopicFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? isRegex = null,
    Object? showRetainedOnly = null,
    Object? showActiveOnly = null,
  }) {
    return _then(
      _value.copyWith(
            query: null == query
                ? _value.query
                : query // ignore: cast_nullable_to_non_nullable
                      as String,
            isRegex: null == isRegex
                ? _value.isRegex
                : isRegex // ignore: cast_nullable_to_non_nullable
                      as bool,
            showRetainedOnly: null == showRetainedOnly
                ? _value.showRetainedOnly
                : showRetainedOnly // ignore: cast_nullable_to_non_nullable
                      as bool,
            showActiveOnly: null == showActiveOnly
                ? _value.showActiveOnly
                : showActiveOnly // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TopicFilterImplCopyWith<$Res>
    implements $TopicFilterCopyWith<$Res> {
  factory _$$TopicFilterImplCopyWith(
    _$TopicFilterImpl value,
    $Res Function(_$TopicFilterImpl) then,
  ) = __$$TopicFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String query,
    bool isRegex,
    bool showRetainedOnly,
    bool showActiveOnly,
  });
}

/// @nodoc
class __$$TopicFilterImplCopyWithImpl<$Res>
    extends _$TopicFilterCopyWithImpl<$Res, _$TopicFilterImpl>
    implements _$$TopicFilterImplCopyWith<$Res> {
  __$$TopicFilterImplCopyWithImpl(
    _$TopicFilterImpl _value,
    $Res Function(_$TopicFilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TopicFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? isRegex = null,
    Object? showRetainedOnly = null,
    Object? showActiveOnly = null,
  }) {
    return _then(
      _$TopicFilterImpl(
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
        isRegex: null == isRegex
            ? _value.isRegex
            : isRegex // ignore: cast_nullable_to_non_nullable
                  as bool,
        showRetainedOnly: null == showRetainedOnly
            ? _value.showRetainedOnly
            : showRetainedOnly // ignore: cast_nullable_to_non_nullable
                  as bool,
        showActiveOnly: null == showActiveOnly
            ? _value.showActiveOnly
            : showActiveOnly // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$TopicFilterImpl extends _TopicFilter {
  const _$TopicFilterImpl({
    this.query = '',
    this.isRegex = false,
    this.showRetainedOnly = false,
    this.showActiveOnly = false,
  }) : super._();

  @override
  @JsonKey()
  final String query;
  @override
  @JsonKey()
  final bool isRegex;
  @override
  @JsonKey()
  final bool showRetainedOnly;
  @override
  @JsonKey()
  final bool showActiveOnly;

  @override
  String toString() {
    return 'TopicFilter(query: $query, isRegex: $isRegex, showRetainedOnly: $showRetainedOnly, showActiveOnly: $showActiveOnly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicFilterImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.isRegex, isRegex) || other.isRegex == isRegex) &&
            (identical(other.showRetainedOnly, showRetainedOnly) ||
                other.showRetainedOnly == showRetainedOnly) &&
            (identical(other.showActiveOnly, showActiveOnly) ||
                other.showActiveOnly == showActiveOnly));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    query,
    isRegex,
    showRetainedOnly,
    showActiveOnly,
  );

  /// Create a copy of TopicFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicFilterImplCopyWith<_$TopicFilterImpl> get copyWith =>
      __$$TopicFilterImplCopyWithImpl<_$TopicFilterImpl>(this, _$identity);
}

abstract class _TopicFilter extends TopicFilter {
  const factory _TopicFilter({
    final String query,
    final bool isRegex,
    final bool showRetainedOnly,
    final bool showActiveOnly,
  }) = _$TopicFilterImpl;
  const _TopicFilter._() : super._();

  @override
  String get query;
  @override
  bool get isRegex;
  @override
  bool get showRetainedOnly;
  @override
  bool get showActiveOnly;

  /// Create a copy of TopicFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicFilterImplCopyWith<_$TopicFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
