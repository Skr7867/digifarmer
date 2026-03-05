// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_basic_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SaveBasicInfoModel _$SaveBasicInfoModelFromJson(Map<String, dynamic> json) =>
    _SaveBasicInfoModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: SaveBasicInfoData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaveBasicInfoModelToJson(_SaveBasicInfoModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_SaveBasicInfoData _$SaveBasicInfoDataFromJson(Map<String, dynamic> json) =>
    _SaveBasicInfoData(
      tempId: json['tempId'] as String,
      currentStep: (json['currentStep'] as num).toInt(),
      ownerId: json['ownerId'] as String,
      createdBy: json['createdBy'] as String,
      createdByRole: json['createdByRole'] as String,
      nextStep: json['nextStep'] as String,
      expiresAt: json['expiresAt'] as String,
    );

Map<String, dynamic> _$SaveBasicInfoDataToJson(_SaveBasicInfoData instance) =>
    <String, dynamic>{
      'tempId': instance.tempId,
      'currentStep': instance.currentStep,
      'ownerId': instance.ownerId,
      'createdBy': instance.createdBy,
      'createdByRole': instance.createdByRole,
      'nextStep': instance.nextStep,
      'expiresAt': instance.expiresAt,
    };
