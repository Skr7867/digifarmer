// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_purchased_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanPurchasedModel _$PlanPurchasedModelFromJson(Map<String, dynamic> json) =>
    _PlanPurchasedModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      investment: json['investment'] == null
          ? null
          : PlanPurchasedInvestmentModel.fromJson(
              json['investment'] as Map<String, dynamic>,
            ),
      paymentRequired: json['paymentRequired'] as bool? ?? false,
    );

Map<String, dynamic> _$PlanPurchasedModelToJson(_PlanPurchasedModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'investment': instance.investment,
      'paymentRequired': instance.paymentRequired,
    };

_PlanPurchasedInvestmentModel _$PlanPurchasedInvestmentModelFromJson(
  Map<String, dynamic> json,
) => _PlanPurchasedInvestmentModel(
  id: json['id'] as String? ?? '',
  investmentId: json['investmentId'] as String? ?? '',
  investmentType: json['investmentType'] as String? ?? '',
  investmentAmount: (json['investmentAmount'] as num?)?.toInt() ?? 0,
  durationMonths: (json['durationMonths'] as num?)?.toInt() ?? 0,
  expectedReturnPercent:
      (json['expectedReturnPercent'] as num?)?.toDouble() ?? 0.0,
  applicationStatus: json['applicationStatus'] as String? ?? '',
  paymentStatus: json['paymentStatus'] as String? ?? '',
  selectedDuration: (json['selectedDuration'] as num?)?.toInt() ?? 0,
  roiFrequency: json['roiFrequency'] as String? ?? '',
  roiAmount: (json['roiAmount'] as num?)?.toDouble() ?? 0.0,
  totalRoiExpected: (json['totalRoiExpected'] as num?)?.toDouble() ?? 0.0,
  totalROIPaid: (json['totalROIPaid'] as num?)?.toDouble() ?? 0.0,
  pendingROI: (json['pendingROI'] as num?)?.toDouble() ?? 0.0,
  startDate: json['startDate'] as String? ?? '',
  endDate: json['endDate'] as String? ?? '',
  maturityDate: json['maturityDate'] as String? ?? '',
  lockInPeriodMonths: (json['lockInPeriodMonths'] as num?)?.toInt() ?? 0,
  prematureExitAllowed: json['prematureExitAllowed'] as bool? ?? false,
  riskLevel: json['riskLevel'] as String? ?? '',
  documents: json['documents'] as List<dynamic>? ?? const [],
  statusTimeline:
      (json['statusTimeline'] as List<dynamic>?)
          ?.map(
            (e) => PlanPurchasedStatusTimelineModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const [],
  adminNotes: json['adminNotes'] as List<dynamic>? ?? const [],
  createdAt: json['createdAt'] as String? ?? '',
  updatedAt: json['updatedAt'] as String? ?? '',
  allocations: json['allocations'] == null
      ? null
      : PlanPurchasedAllocationsModel.fromJson(
          json['allocations'] as Map<String, dynamic>,
        ),
  poolInfo: json['poolInfo'] == null
      ? null
      : PlanPurchasedPoolInfoModel.fromJson(
          json['poolInfo'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PlanPurchasedInvestmentModelToJson(
  _PlanPurchasedInvestmentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'investmentId': instance.investmentId,
  'investmentType': instance.investmentType,
  'investmentAmount': instance.investmentAmount,
  'durationMonths': instance.durationMonths,
  'expectedReturnPercent': instance.expectedReturnPercent,
  'applicationStatus': instance.applicationStatus,
  'paymentStatus': instance.paymentStatus,
  'selectedDuration': instance.selectedDuration,
  'roiFrequency': instance.roiFrequency,
  'roiAmount': instance.roiAmount,
  'totalRoiExpected': instance.totalRoiExpected,
  'totalROIPaid': instance.totalROIPaid,
  'pendingROI': instance.pendingROI,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'maturityDate': instance.maturityDate,
  'lockInPeriodMonths': instance.lockInPeriodMonths,
  'prematureExitAllowed': instance.prematureExitAllowed,
  'riskLevel': instance.riskLevel,
  'documents': instance.documents,
  'statusTimeline': instance.statusTimeline,
  'adminNotes': instance.adminNotes,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'allocations': instance.allocations,
  'poolInfo': instance.poolInfo,
};

_PlanPurchasedStatusTimelineModel _$PlanPurchasedStatusTimelineModelFromJson(
  Map<String, dynamic> json,
) => _PlanPurchasedStatusTimelineModel(
  status: json['status'] as String? ?? '',
  note: json['note'] as String? ?? '',
  updatedAt: json['updatedAt'] as String? ?? '',
);

Map<String, dynamic> _$PlanPurchasedStatusTimelineModelToJson(
  _PlanPurchasedStatusTimelineModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'note': instance.note,
  'updatedAt': instance.updatedAt,
};

_PlanPurchasedAllocationsModel _$PlanPurchasedAllocationsModelFromJson(
  Map<String, dynamic> json,
) => _PlanPurchasedAllocationsModel(
  lands: json['lands'] as List<dynamic>? ?? const [],
  crops: json['crops'] as List<dynamic>? ?? const [],
);

Map<String, dynamic> _$PlanPurchasedAllocationsModelToJson(
  _PlanPurchasedAllocationsModel instance,
) => <String, dynamic>{'lands': instance.lands, 'crops': instance.crops};

_PlanPurchasedPoolInfoModel _$PlanPurchasedPoolInfoModelFromJson(
  Map<String, dynamic> json,
) => _PlanPurchasedPoolInfoModel(
  poolName: json['poolName'] as String? ?? '',
  totalPoolSize: (json['totalPoolSize'] as num?)?.toInt() ?? 0,
  remainingAmount: (json['remainingAmount'] as num?)?.toInt() ?? 0,
  allocatedLands: json['allocatedLands'] as List<dynamic>? ?? const [],
);

Map<String, dynamic> _$PlanPurchasedPoolInfoModelToJson(
  _PlanPurchasedPoolInfoModel instance,
) => <String, dynamic>{
  'poolName': instance.poolName,
  'totalPoolSize': instance.totalPoolSize,
  'remainingAmount': instance.remainingAmount,
  'allocatedLands': instance.allocatedLands,
};
