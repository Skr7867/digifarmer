// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_investment_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AllInvestmentPlanModel _$AllInvestmentPlanModelFromJson(
  Map<String, dynamic> json,
) => _AllInvestmentPlanModel(
  success: json['success'] as bool? ?? false,
  plans:
      (json['plans'] as List<dynamic>?)
          ?.map((e) => InvestmentPlanModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AllInvestmentPlanModelToJson(
  _AllInvestmentPlanModel instance,
) => <String, dynamic>{'success': instance.success, 'plans': instance.plans};

_InvestmentPlanModel _$InvestmentPlanModelFromJson(
  Map<String, dynamic> json,
) => _InvestmentPlanModel(
  id: json['_id'] as String? ?? '',
  planId: json['planId'] as String? ?? '',
  planName: json['planName'] as String? ?? '',
  description: json['description'] as String? ?? '',
  minInvestment: (json['minInvestment'] as num?)?.toInt() ?? 0,
  maxInvestment: (json['maxInvestment'] as num?)?.toInt() ?? 0,
  durationMonths: (json['durationMonths'] as num?)?.toInt() ?? 0,
  returnPercent: (json['returnPercent'] as num?)?.toInt() ?? 0,
  roiFrequency: json['roiFrequency'] as String? ?? '',
  lockInPeriodMonths: (json['lockInPeriodMonths'] as num?)?.toInt() ?? 0,
  prematureExitAllowed: json['prematureExitAllowed'] as bool? ?? false,
  prematureExitPenalty: (json['prematureExitPenalty'] as num?)?.toInt() ?? 0,
  riskLevel: json['riskLevel'] as String? ?? '',
  isActive: json['isActive'] as bool? ?? false,
  isPopular: json['isPopular'] as bool? ?? false,
  createdAt: json['createdAt'] as String? ?? '',
  updatedAt: json['updatedAt'] as String? ?? '',
  totalReturnPercent: (json['totalReturnPercent'] as num?)?.toInt() ?? 0,
  totalReturnOnLakh: (json['totalReturnOnLakh'] as num?)?.toInt() ?? 0,
  periodicReturn: (json['periodicReturn'] as num?)?.toDouble() ?? 0.0,
  periodicLabel: json['periodicLabel'] as String? ?? '',
  minInvestmentFormatted: json['minInvestmentFormatted'] as String? ?? '',
  maxInvestmentFormatted: json['maxInvestmentFormatted'] as String? ?? '',
  durationFormatted: json['durationFormatted'] as String? ?? '',
  returnFormatted: json['returnFormatted'] as String? ?? '',
  examples: json['examples'] == null
      ? null
      : ExamplesModel.fromJson(json['examples'] as Map<String, dynamic>),
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  summary: json['summary'] == null
      ? null
      : SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
  investmentGuide: json['investmentGuide'] == null
      ? null
      : InvestmentGuideModel.fromJson(
          json['investmentGuide'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$InvestmentPlanModelToJson(
  _InvestmentPlanModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'planId': instance.planId,
  'planName': instance.planName,
  'description': instance.description,
  'minInvestment': instance.minInvestment,
  'maxInvestment': instance.maxInvestment,
  'durationMonths': instance.durationMonths,
  'returnPercent': instance.returnPercent,
  'roiFrequency': instance.roiFrequency,
  'lockInPeriodMonths': instance.lockInPeriodMonths,
  'prematureExitAllowed': instance.prematureExitAllowed,
  'prematureExitPenalty': instance.prematureExitPenalty,
  'riskLevel': instance.riskLevel,
  'isActive': instance.isActive,
  'isPopular': instance.isPopular,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'totalReturnPercent': instance.totalReturnPercent,
  'totalReturnOnLakh': instance.totalReturnOnLakh,
  'periodicReturn': instance.periodicReturn,
  'periodicLabel': instance.periodicLabel,
  'minInvestmentFormatted': instance.minInvestmentFormatted,
  'maxInvestmentFormatted': instance.maxInvestmentFormatted,
  'durationFormatted': instance.durationFormatted,
  'returnFormatted': instance.returnFormatted,
  'examples': instance.examples,
  'features': instance.features,
  'summary': instance.summary,
  'investmentGuide': instance.investmentGuide,
};

_ExamplesModel _$ExamplesModelFromJson(Map<String, dynamic> json) =>
    _ExamplesModel(
      on100000: json['on100000'] == null
          ? null
          : ExampleDetailModel.fromJson(
              json['on100000'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ExamplesModelToJson(_ExamplesModel instance) =>
    <String, dynamic>{'on100000': instance.on100000};

_ExampleDetailModel _$ExampleDetailModelFromJson(Map<String, dynamic> json) =>
    _ExampleDetailModel(
      invested: json['invested'] as String? ?? '',
      totalReturn: json['totalReturn'] as String? ?? '',
      maturityAmount: json['maturityAmount'] as String? ?? '',
      periodicReturn: json['periodicReturn'] as String? ?? '',
    );

Map<String, dynamic> _$ExampleDetailModelToJson(_ExampleDetailModel instance) =>
    <String, dynamic>{
      'invested': instance.invested,
      'totalReturn': instance.totalReturn,
      'maturityAmount': instance.maturityAmount,
      'periodicReturn': instance.periodicReturn,
    };

_SummaryModel _$SummaryModelFromJson(Map<String, dynamic> json) =>
    _SummaryModel(
      investmentRange: json['investmentRange'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      expectedReturn: json['expectedReturn'] as String? ?? '',
      totalReturn: json['totalReturn'] as String? ?? '',
      lockInPeriod: json['lockInPeriod'] as String? ?? '',
      riskLevel: json['riskLevel'] as String? ?? '',
      roiFrequency: json['roiFrequency'] as String? ?? '',
    );

Map<String, dynamic> _$SummaryModelToJson(_SummaryModel instance) =>
    <String, dynamic>{
      'investmentRange': instance.investmentRange,
      'duration': instance.duration,
      'expectedReturn': instance.expectedReturn,
      'totalReturn': instance.totalReturn,
      'lockInPeriod': instance.lockInPeriod,
      'riskLevel': instance.riskLevel,
      'roiFrequency': instance.roiFrequency,
    };

_InvestmentGuideModel _$InvestmentGuideModelFromJson(
  Map<String, dynamic> json,
) => _InvestmentGuideModel(
  minimumAmount: (json['minimumAmount'] as num?)?.toInt() ?? 0,
  recommendedDuration: (json['recommendedDuration'] as num?)?.toInt() ?? 0,
  expectedAnnualReturn: json['expectedAnnualReturn'] as String? ?? '',
  lockInRequired: json['lockInRequired'] as bool? ?? false,
  exitPenalty: json['exitPenalty'] as String? ?? '',
  roiOption: json['roiOption'] as String? ?? '',
);

Map<String, dynamic> _$InvestmentGuideModelToJson(
  _InvestmentGuideModel instance,
) => <String, dynamic>{
  'minimumAmount': instance.minimumAmount,
  'recommendedDuration': instance.recommendedDuration,
  'expectedAnnualReturn': instance.expectedAnnualReturn,
  'lockInRequired': instance.lockInRequired,
  'exitPenalty': instance.exitPenalty,
  'roiOption': instance.roiOption,
};
