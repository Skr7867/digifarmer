// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_investment_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AllInvestmentPlanModel _$AllInvestmentPlanModelFromJson(
  Map<String, dynamic> json,
) => _AllInvestmentPlanModel(
  success: json['success'] as bool? ?? false,
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 0,
  limit: (json['limit'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
  plans:
      (json['plans'] as List<dynamic>?)
          ?.map((e) => InvestmentPlanModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AllInvestmentPlanModelToJson(
  _AllInvestmentPlanModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'total': instance.total,
  'page': instance.page,
  'limit': instance.limit,
  'totalPages': instance.totalPages,
  'plans': instance.plans,
};

_InvestmentPlanModel _$InvestmentPlanModelFromJson(
  Map<String, dynamic> json,
) => _InvestmentPlanModel(
  id: json['_id'] as String? ?? '',
  planId: json['planId'] as String? ?? '',
  planName: json['planName'] as String? ?? '',
  description: json['description'] as String? ?? '',
  minInvestment: (json['minInvestment'] as num?)?.toInt() ?? 0,
  maxInvestment: (json['maxInvestment'] as num?)?.toInt() ?? 0,
  defaultDurationMonths: (json['defaultDurationMonths'] as num?)?.toInt() ?? 0,
  availableDurations:
      (json['availableDurations'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  baseReturnPercent: (json['baseReturnPercent'] as num?)?.toInt() ?? 0,
  durationMultipliers:
      json['durationMultipliers'] as Map<String, dynamic>? ?? const {},
  availableRoiFrequencies:
      (json['availableRoiFrequencies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  defaultRoiFrequency: json['defaultRoiFrequency'] as String? ?? '',
  lockInPeriodMonths: (json['lockInPeriodMonths'] as num?)?.toInt() ?? 0,
  prematureExitAllowed: json['prematureExitAllowed'] as bool? ?? false,
  prematureExitPenalty: (json['prematureExitPenalty'] as num?)?.toInt() ?? 0,
  riskLevel: json['riskLevel'] as String? ?? '',
  isActive: json['isActive'] as bool? ?? false,
  isPopular: json['isPopular'] as bool? ?? false,
  createdBy: json['createdBy'] == null
      ? null
      : CreatedByModel.fromJson(json['createdBy'] as Map<String, dynamic>),
  createdAt: json['createdAt'] as String? ?? '',
  updatedAt: json['updatedAt'] as String? ?? '',
  version: (json['__v'] as num?)?.toInt() ?? 0,
  updatedBy: json['updatedBy'] == null
      ? null
      : CreatedByModel.fromJson(json['updatedBy'] as Map<String, dynamic>),
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
  'defaultDurationMonths': instance.defaultDurationMonths,
  'availableDurations': instance.availableDurations,
  'baseReturnPercent': instance.baseReturnPercent,
  'durationMultipliers': instance.durationMultipliers,
  'availableRoiFrequencies': instance.availableRoiFrequencies,
  'defaultRoiFrequency': instance.defaultRoiFrequency,
  'lockInPeriodMonths': instance.lockInPeriodMonths,
  'prematureExitAllowed': instance.prematureExitAllowed,
  'prematureExitPenalty': instance.prematureExitPenalty,
  'riskLevel': instance.riskLevel,
  'isActive': instance.isActive,
  'isPopular': instance.isPopular,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.version,
  'updatedBy': instance.updatedBy,
};

_CreatedByModel _$CreatedByModelFromJson(Map<String, dynamic> json) =>
    _CreatedByModel(
      id: json['_id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
    );

Map<String, dynamic> _$CreatedByModelToJson(_CreatedByModel instance) =>
    <String, dynamic>{'_id': instance.id, 'fullName': instance.fullName};
