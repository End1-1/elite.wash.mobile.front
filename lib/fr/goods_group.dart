import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods_group.freezed.dart';
part 'goods_group.g.dart';

@freezed
class GoodsGroup with _$GoodsGroup {
  const factory GoodsGroup({
    required int f_id,
    required String f_am,
  }) = _GoodsGroup;

  factory GoodsGroup.fromJson(Map<String, dynamic> json) => _$GoodsGroupFromJson(json);
}