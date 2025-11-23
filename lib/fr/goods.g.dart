// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoodsImpl _$$GoodsImplFromJson(Map<String, dynamic> json) => _$GoodsImpl(
      f_id: (json['f_id'] as num).toInt(),
      f_en: json['f_en'] as String,
      f_type: (json['f_type'] as num).toInt(),
      f_store: (json['f_store'] as num).toInt(),
      f_price: json['f_price'] as num,
    );

Map<String, dynamic> _$$GoodsImplToJson(_$GoodsImpl instance) =>
    <String, dynamic>{
      'f_id': instance.f_id,
      'f_en': instance.f_en,
      'f_type': instance.f_type,
      'f_store': instance.f_store,
      'f_price': instance.f_price,
    };
