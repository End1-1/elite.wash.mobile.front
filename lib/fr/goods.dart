import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods.freezed.dart';

part 'goods.g.dart';

@freezed
class Goods with _$Goods {
  const factory Goods({
    required int f_id,
    required String f_en,
    required int f_type,
    required int f_store,
    required num f_price
  }) = _Goods;

  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);
}
