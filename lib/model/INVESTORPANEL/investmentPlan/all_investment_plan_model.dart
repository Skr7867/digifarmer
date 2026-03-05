import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_investment_plan_model.freezed.dart';
part 'all_investment_plan_model.g.dart';

@freezed
abstract class AllInvestmentPlanModel with _$AllInvestmentPlanModel {
  const factory AllInvestmentPlanModel({
    @Default(false) bool success,
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

    /// Map<String, num> is better because multiplier may be double (1.2)
    @Default({}) Map<String, num> durationMultipliers,

    @Default([]) List<String> availableRoiFrequencies,
    @Default('') String defaultRoiFrequency,
    @Default(0) int lockInPeriodMonths,
    @Default(false) bool prematureExitAllowed,
    @Default(0) int prematureExitPenalty,
    @Default('') String riskLevel,
    @Default(false) bool isActive,
    @Default(false) bool isPopular,

    @Default('') String createdAt,
    @Default('') String updatedAt,

    @JsonKey(name: '__v') @Default(0) int version,
  }) = _InvestmentPlanModel;

  factory InvestmentPlanModel.fromJson(Map<String, dynamic> json) =>
      _$InvestmentPlanModelFromJson(json);
}
