import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_investment_plan_model.freezed.dart';
part 'all_investment_plan_model.g.dart';

@freezed
abstract class AllInvestmentPlanModel with _$AllInvestmentPlanModel {
  const factory AllInvestmentPlanModel({
    @Default(false) bool success,
    @Default(0) int total,
    @Default(0) int page,
    @Default(0) int limit,
    @Default(0) int totalPages,
    @Default([]) List<InvestmentPlanModel> plans,
  }) = _AllInvestmentPlanModel;

  factory AllInvestmentPlanModel.fromJson(Map<String, dynamic> json) =>
      _$AllInvestmentPlanModelFromJson(json);
}

@freezed
abstract class InvestmentPlanModel with _$InvestmentPlanModel {
  const factory InvestmentPlanModel({
    @JsonKey(name: '_id') @Default('') String id,
    @Default('') String planId,
    @Default('') String planName,
    @Default('') String description,
    @Default(0) int minInvestment,
    @Default(0) int maxInvestment,
    @Default(0) int defaultDurationMonths,
    @Default([]) List<int> availableDurations,
    @Default(0) int baseReturnPercent,

    /// Safe Map
    @Default({}) Map<String, dynamic> durationMultipliers,

    @Default([]) List<String> availableRoiFrequencies,
    @Default('') String defaultRoiFrequency,
    @Default(0) int lockInPeriodMonths,
    @Default(false) bool prematureExitAllowed,
    @Default(0) int prematureExitPenalty,
    @Default('') String riskLevel,
    @Default(false) bool isActive,
    @Default(false) bool isPopular,

    CreatedByModel? createdBy,

    @Default('') String createdAt,
    @Default('') String updatedAt,

    @JsonKey(name: '__v') @Default(0) int version,

    CreatedByModel? updatedBy,
  }) = _InvestmentPlanModel;

  factory InvestmentPlanModel.fromJson(Map<String, dynamic> json) =>
      _$InvestmentPlanModelFromJson(json);
}

@freezed
abstract class CreatedByModel with _$CreatedByModel {
  const factory CreatedByModel({
    @JsonKey(name: '_id') @Default('') String id,
    @Default('') String fullName,
  }) = _CreatedByModel;

  factory CreatedByModel.fromJson(Map<String, dynamic> json) =>
      _$CreatedByModelFromJson(json);
}
