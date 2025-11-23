// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Goods _$GoodsFromJson(Map<String, dynamic> json) {
  return _Goods.fromJson(json);
}

/// @nodoc
mixin _$Goods {
  int get f_id => throw _privateConstructorUsedError;
  String get f_en => throw _privateConstructorUsedError;
  int get f_type => throw _privateConstructorUsedError;
  int get f_store => throw _privateConstructorUsedError;
  num get f_price => throw _privateConstructorUsedError;

  /// Serializes this Goods to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoodsCopyWith<Goods> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodsCopyWith<$Res> {
  factory $GoodsCopyWith(Goods value, $Res Function(Goods) then) =
      _$GoodsCopyWithImpl<$Res, Goods>;
  @useResult
  $Res call({int f_id, String f_en, int f_type, int f_store, num f_price});
}

/// @nodoc
class _$GoodsCopyWithImpl<$Res, $Val extends Goods>
    implements $GoodsCopyWith<$Res> {
  _$GoodsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? f_id = null,
    Object? f_en = null,
    Object? f_type = null,
    Object? f_store = null,
    Object? f_price = null,
  }) {
    return _then(_value.copyWith(
      f_id: null == f_id
          ? _value.f_id
          : f_id // ignore: cast_nullable_to_non_nullable
              as int,
      f_en: null == f_en
          ? _value.f_en
          : f_en // ignore: cast_nullable_to_non_nullable
              as String,
      f_type: null == f_type
          ? _value.f_type
          : f_type // ignore: cast_nullable_to_non_nullable
              as int,
      f_store: null == f_store
          ? _value.f_store
          : f_store // ignore: cast_nullable_to_non_nullable
              as int,
      f_price: null == f_price
          ? _value.f_price
          : f_price // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoodsImplCopyWith<$Res> implements $GoodsCopyWith<$Res> {
  factory _$$GoodsImplCopyWith(
          _$GoodsImpl value, $Res Function(_$GoodsImpl) then) =
      __$$GoodsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int f_id, String f_en, int f_type, int f_store, num f_price});
}

/// @nodoc
class __$$GoodsImplCopyWithImpl<$Res>
    extends _$GoodsCopyWithImpl<$Res, _$GoodsImpl>
    implements _$$GoodsImplCopyWith<$Res> {
  __$$GoodsImplCopyWithImpl(
      _$GoodsImpl _value, $Res Function(_$GoodsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? f_id = null,
    Object? f_en = null,
    Object? f_type = null,
    Object? f_store = null,
    Object? f_price = null,
  }) {
    return _then(_$GoodsImpl(
      f_id: null == f_id
          ? _value.f_id
          : f_id // ignore: cast_nullable_to_non_nullable
              as int,
      f_en: null == f_en
          ? _value.f_en
          : f_en // ignore: cast_nullable_to_non_nullable
              as String,
      f_type: null == f_type
          ? _value.f_type
          : f_type // ignore: cast_nullable_to_non_nullable
              as int,
      f_store: null == f_store
          ? _value.f_store
          : f_store // ignore: cast_nullable_to_non_nullable
              as int,
      f_price: null == f_price
          ? _value.f_price
          : f_price // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoodsImpl implements _Goods {
  const _$GoodsImpl(
      {required this.f_id,
      required this.f_en,
      required this.f_type,
      required this.f_store,
      required this.f_price});

  factory _$GoodsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoodsImplFromJson(json);

  @override
  final int f_id;
  @override
  final String f_en;
  @override
  final int f_type;
  @override
  final int f_store;
  @override
  final num f_price;

  @override
  String toString() {
    return 'Goods(f_id: $f_id, f_en: $f_en, f_type: $f_type, f_store: $f_store, f_price: $f_price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsImpl &&
            (identical(other.f_id, f_id) || other.f_id == f_id) &&
            (identical(other.f_en, f_en) || other.f_en == f_en) &&
            (identical(other.f_type, f_type) || other.f_type == f_type) &&
            (identical(other.f_store, f_store) || other.f_store == f_store) &&
            (identical(other.f_price, f_price) || other.f_price == f_price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, f_id, f_en, f_type, f_store, f_price);

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoodsImplCopyWith<_$GoodsImpl> get copyWith =>
      __$$GoodsImplCopyWithImpl<_$GoodsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoodsImplToJson(
      this,
    );
  }
}

abstract class _Goods implements Goods {
  const factory _Goods(
      {required final int f_id,
      required final String f_en,
      required final int f_type,
      required final int f_store,
      required final num f_price}) = _$GoodsImpl;

  factory _Goods.fromJson(Map<String, dynamic> json) = _$GoodsImpl.fromJson;

  @override
  int get f_id;
  @override
  String get f_en;
  @override
  int get f_type;
  @override
  int get f_store;
  @override
  num get f_price;

  /// Create a copy of Goods
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoodsImplCopyWith<_$GoodsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
