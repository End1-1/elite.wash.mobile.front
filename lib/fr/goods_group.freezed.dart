// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GoodsGroup _$GoodsGroupFromJson(Map<String, dynamic> json) {
  return _GoodsGroup.fromJson(json);
}

/// @nodoc
mixin _$GoodsGroup {
  int get f_id => throw _privateConstructorUsedError;
  String get f_am => throw _privateConstructorUsedError;

  /// Serializes this GoodsGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoodsGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoodsGroupCopyWith<GoodsGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodsGroupCopyWith<$Res> {
  factory $GoodsGroupCopyWith(
          GoodsGroup value, $Res Function(GoodsGroup) then) =
      _$GoodsGroupCopyWithImpl<$Res, GoodsGroup>;
  @useResult
  $Res call({int f_id, String f_am});
}

/// @nodoc
class _$GoodsGroupCopyWithImpl<$Res, $Val extends GoodsGroup>
    implements $GoodsGroupCopyWith<$Res> {
  _$GoodsGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoodsGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? f_id = null,
    Object? f_am = null,
  }) {
    return _then(_value.copyWith(
      f_id: null == f_id
          ? _value.f_id
          : f_id // ignore: cast_nullable_to_non_nullable
              as int,
      f_am: null == f_am
          ? _value.f_am
          : f_am // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoodsGroupImplCopyWith<$Res>
    implements $GoodsGroupCopyWith<$Res> {
  factory _$$GoodsGroupImplCopyWith(
          _$GoodsGroupImpl value, $Res Function(_$GoodsGroupImpl) then) =
      __$$GoodsGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int f_id, String f_am});
}

/// @nodoc
class __$$GoodsGroupImplCopyWithImpl<$Res>
    extends _$GoodsGroupCopyWithImpl<$Res, _$GoodsGroupImpl>
    implements _$$GoodsGroupImplCopyWith<$Res> {
  __$$GoodsGroupImplCopyWithImpl(
      _$GoodsGroupImpl _value, $Res Function(_$GoodsGroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of GoodsGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? f_id = null,
    Object? f_am = null,
  }) {
    return _then(_$GoodsGroupImpl(
      f_id: null == f_id
          ? _value.f_id
          : f_id // ignore: cast_nullable_to_non_nullable
              as int,
      f_am: null == f_am
          ? _value.f_am
          : f_am // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoodsGroupImpl implements _GoodsGroup {
  const _$GoodsGroupImpl({required this.f_id, required this.f_am});

  factory _$GoodsGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoodsGroupImplFromJson(json);

  @override
  final int f_id;
  @override
  final String f_am;

  @override
  String toString() {
    return 'GoodsGroup(f_id: $f_id, f_am: $f_am)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsGroupImpl &&
            (identical(other.f_id, f_id) || other.f_id == f_id) &&
            (identical(other.f_am, f_am) || other.f_am == f_am));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, f_id, f_am);

  /// Create a copy of GoodsGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoodsGroupImplCopyWith<_$GoodsGroupImpl> get copyWith =>
      __$$GoodsGroupImplCopyWithImpl<_$GoodsGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoodsGroupImplToJson(
      this,
    );
  }
}

abstract class _GoodsGroup implements GoodsGroup {
  const factory _GoodsGroup(
      {required final int f_id, required final String f_am}) = _$GoodsGroupImpl;

  factory _GoodsGroup.fromJson(Map<String, dynamic> json) =
      _$GoodsGroupImpl.fromJson;

  @override
  int get f_id;
  @override
  String get f_am;

  /// Create a copy of GoodsGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoodsGroupImplCopyWith<_$GoodsGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
