import 'package:freezed_annotation/freezed_annotation.dart';

part 'land_location_model.freezed.dart';
part 'land_location_model.g.dart';

@freezed
abstract class LandLocationModel with _$LandLocationModel {
  const factory LandLocationModel({
    required bool success,
    required String message,
    required LandLocationData data,
  }) = _LandLocationModel;

  factory LandLocationModel.fromJson(Map<String, dynamic> json) =>
      _$LandLocationModelFromJson(json);
}

@freezed
abstract class LandLocationData with _$LandLocationData {
  const factory LandLocationData({
    required String tempId,
    required int currentStep,
    required String nextStep,
    required DateTime expiresAt,
  }) = _LandLocationData;

  factory LandLocationData.fromJson(Map<String, dynamic> json) =>
      _$LandLocationDataFromJson(json);
}
