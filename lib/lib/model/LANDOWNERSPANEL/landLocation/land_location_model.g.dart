// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LandLocationModel _$LandLocationModelFromJson(Map<String, dynamic> json) =>
    _LandLocationModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: LandLocationData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LandLocationModelToJson(_LandLocationModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_LandLocationData _$LandLocationDataFromJson(Map<String, dynamic> json) =>
    _LandLocationData(
      tempId: json['tempId'] as String,
      currentStep: (json['currentStep'] as num).toInt(),
      nextStep: json['nextStep'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$LandLocationDataToJson(_LandLocationData instance) =>
    <String, dynamic>{
      'tempId': instance.tempId,
      'currentStep': instance.currentStep,
      'nextStep': instance.nextStep,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };
