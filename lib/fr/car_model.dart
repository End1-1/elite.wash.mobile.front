import 'package:freezed_annotation/freezed_annotation.dart';

part 'car_model.freezed.dart';

part 'car_model.g.dart';

@freezed
class CarModel with _$CarModel {

  const CarModel._();

  const factory CarModel({
    required int f_id,
    required String f_model
}) = _CarModel;
  factory CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);

  @override
  String toString() => f_model;
}

