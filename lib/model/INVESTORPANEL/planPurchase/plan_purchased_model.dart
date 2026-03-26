import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_purchased_model.freezed.dart';
part 'plan_purchased_model.g.dart';

@freezed
abstract class PlanPurchasedModel with _$PlanPurchasedModel {
  const factory PlanPurchasedModel({
    @Default(false) bool success,
    @Default('') String message,
    PlanPurchasedInvestmentModel? investment,
    @Default(false) bool paymentRequired,
  }) = _PlanPurchasedModel;

  factory PlanPurchasedModel.fromJson(Map<String, dynamic> json) =>
      _$PlanPurchasedModelFromJson(json);
}

@freezed
abstract class PlanPurchasedInvestmentModel
    with _$PlanPurchasedInvestmentModel {
  const factory PlanPurchasedInvestmentModel({
    @Default('') String id,
    @Default('') String investmentId,
    @Default('') String investmentType,
    @Default(0) int investmentAmount,
    @Default(0) int durationMonths,
    @Default(0.0) double expectedReturnPercent,
    @Default('') String applicationStatus,
    @Default('') String paymentStatus,
    @Default(0) int selectedDuration,
    @Default('') String roiFrequency,
    @Default(0.0) double roiAmount,
    @Default(0.0) double totalRoiExpected,
    @Default(0.0) double totalROIPaid,
    @Default(0.0) double pendingROI,
    @Default('') String startDate,
    @Default('') String endDate,
    @Default('') String maturityDate,
    @Default(0) int lockInPeriodMonths,
    @Default(false) bool prematureExitAllowed,
    @Default('') String riskLevel,
    @Default([]) List<dynamic> documents,
    @Default([]) List<PlanPurchasedStatusTimelineModel> statusTimeline,
    @Default([]) List<dynamic> adminNotes,
    @Default('') String createdAt,
    @Default('') String updatedAt,
    PlanPurchasedAllocationsModel? allocations,
    PlanPurchasedPoolInfoModel? poolInfo,
  }) = _PlanPurchasedInvestmentModel;

  factory PlanPurchasedInvestmentModel.fromJson(Map<String, dynamic> json) =>
      _$PlanPurchasedInvestmentModelFromJson(json);
}

@freezed
abstract class PlanPurchasedStatusTimelineModel
    with _$PlanPurchasedStatusTimelineModel {
  const factory PlanPurchasedStatusTimelineModel({
    @Default('') String status,
    @Default('') String note,
    @Default('') String updatedAt,
  }) = _PlanPurchasedStatusTimelineModel;

  factory PlanPurchasedStatusTimelineModel.fromJson(
    Map<String, dynamic> json,
  ) => _$PlanPurchasedStatusTimelineModelFromJson(json);
}

@freezed
abstract class PlanPurchasedAllocationsModel
    with _$PlanPurchasedAllocationsModel {
  const factory PlanPurchasedAllocationsModel({
    @Default([]) List<dynamic> lands,
    @Default([]) List<dynamic> crops,
  }) = _PlanPurchasedAllocationsModel;

  factory PlanPurchasedAllocationsModel.fromJson(Map<String, dynamic> json) =>
      _$PlanPurchasedAllocationsModelFromJson(json);
}

@freezed
abstract class PlanPurchasedPoolInfoModel with _$PlanPurchasedPoolInfoModel {
  const factory PlanPurchasedPoolInfoModel({
    @Default('') String poolName,
    @Default(0) int totalPoolSize,
    @Default(0) int remainingAmount,
    @Default([]) List<dynamic> allocatedLands,
  }) = _PlanPurchasedPoolInfoModel;

  factory PlanPurchasedPoolInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PlanPurchasedPoolInfoModelFromJson(json);
}
