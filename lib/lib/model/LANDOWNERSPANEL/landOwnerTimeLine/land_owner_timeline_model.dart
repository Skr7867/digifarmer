import 'package:freezed_annotation/freezed_annotation.dart';

part 'land_owner_timeline_model.freezed.dart';
part 'land_owner_timeline_model.g.dart';

@freezed
abstract class LandOwnerTimelineModel with _$LandOwnerTimelineModel {
  const factory LandOwnerTimelineModel({
    required bool success,
    required LandOwnerTimelineData data,
  }) = _LandOwnerTimelineModel;

  factory LandOwnerTimelineModel.fromJson(Map<String, dynamic> json) =>
      _$LandOwnerTimelineModelFromJson(json);
}

@freezed
abstract class LandOwnerTimelineData with _$LandOwnerTimelineData {
  const factory LandOwnerTimelineData({
    required int count,
    required List<LandOwnerTimelineLand> lands,
  }) = _LandOwnerTimelineData;

  factory LandOwnerTimelineData.fromJson(Map<String, dynamic> json) =>
      _$LandOwnerTimelineDataFromJson(json);
}

@freezed
abstract class LandOwnerTimelineLand with _$LandOwnerTimelineLand {
  const factory LandOwnerTimelineLand({
    required String id,
    required String title,
    required String area,
    required String location,
    required String status,
    required bool isLive,
    required int currentStep,
    required String stepStatus,
    required String landId,
    required DateTime submittedAt,
    required DateTime updatedAt,
  }) = _LandOwnerTimelineLand;

  factory LandOwnerTimelineLand.fromJson(Map<String, dynamic> json) =>
      _$LandOwnerTimelineLandFromJson(json);
}
