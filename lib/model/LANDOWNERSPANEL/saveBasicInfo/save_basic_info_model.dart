import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_basic_info_model.freezed.dart';
part 'save_basic_info_model.g.dart';

@freezed
abstract class SaveBasicInfoModel with _$SaveBasicInfoModel {
  const factory SaveBasicInfoModel({
    required bool success,
    required String message,
    required SaveBasicInfoData data,
  }) = _SaveBasicInfoModel;

  factory SaveBasicInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SaveBasicInfoModelFromJson(json);
}

@freezed
abstract class SaveBasicInfoData with _$SaveBasicInfoData {
  const factory SaveBasicInfoData({
    required String tempId,
    required int currentStep,
    required String ownerId,
    required String createdBy,
    required String createdByRole,
    required String nextStep,
    required String expiresAt,
  }) = _SaveBasicInfoData;

  factory SaveBasicInfoData.fromJson(Map<String, dynamic> json) =>
      _$SaveBasicInfoDataFromJson(json);
}
