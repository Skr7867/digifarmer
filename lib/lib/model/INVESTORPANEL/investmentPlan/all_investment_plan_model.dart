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
    @Default(0) int durationMonths,
    @Default(0) int returnPercent,
    @Default('') String roiFrequency,
    @Default(0) int lockInPeriodMonths,
    @Default(false) bool prematureExitAllowed,
    @Default(0) int prematureExitPenalty,
    @Default('') String riskLevel,

    @Default(false) bool isActive,
    @Default(false) bool isPopular,

    @Default('') String createdAt,
    @Default('') String updatedAt,

    @Default(0) int totalReturnPercent,
    @Default(0) int totalReturnOnLakh,
    @Default(0.0) double periodicReturn,
    @Default('') String periodicLabel,

    @Default('') String minInvestmentFormatted,
    @Default('') String maxInvestmentFormatted,
    @Default('') String durationFormatted,
    @Default('') String returnFormatted,

    ExamplesModel? examples,

    @Default([]) List<String> features,

    SummaryModel? summary,
    InvestmentGuideModel? investmentGuide,
  }) = _InvestmentPlanModel;

  factory InvestmentPlanModel.fromJson(Map<String, dynamic> json) =>
      _$InvestmentPlanModelFromJson(json);
}

@freezed
abstract class ExamplesModel with _$ExamplesModel {
  const factory ExamplesModel({
    @JsonKey(name: 'on100000') ExampleDetailModel? on100000,
  }) = _ExamplesModel;

  factory ExamplesModel.fromJson(Map<String, dynamic> json) =>
      _$ExamplesModelFromJson(json);
}

@freezed
abstract class ExampleDetailModel with _$ExampleDetailModel {
  const factory ExampleDetailModel({
    @Default('') String invested,
    @Default('') String totalReturn,
    @Default('') String maturityAmount,
    @Default('') String periodicReturn,
  }) = _ExampleDetailModel;

  factory ExampleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ExampleDetailModelFromJson(json);
}

@freezed
abstract class SummaryModel with _$SummaryModel {
  const factory SummaryModel({
    @Default('') String investmentRange,
    @Default('') String duration,
    @Default('') String expectedReturn,
    @Default('') String totalReturn,
    @Default('') String lockInPeriod,
    @Default('') String riskLevel,
    @Default('') String roiFrequency,
  }) = _SummaryModel;

  factory SummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryModelFromJson(json);
}

@freezed
abstract class InvestmentGuideModel with _$InvestmentGuideModel {
  const factory InvestmentGuideModel({
    @Default(0) int minimumAmount,
    @Default(0) int recommendedDuration,
    @Default('') String expectedAnnualReturn,
    @Default(false) bool lockInRequired,
    @Default('') String exitPenalty,
    @Default('') String roiOption,
  }) = _InvestmentGuideModel;

  factory InvestmentGuideModel.fromJson(Map<String, dynamic> json) =>
      _$InvestmentGuideModelFromJson(json);
}
