// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionUserModel _$SessionUserModelFromJson(Map<String, dynamic> json) =>
    _SessionUserModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      userId: json['userId'] as String,
      mobileNumber: json['mobileNumber'] as String,
      role: json['role'] as String?,
      isApproved: json['isApproved'] as bool,
    );

Map<String, dynamic> _$SessionUserModelToJson(_SessionUserModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'mobileNumber': instance.mobileNumber,
      'role': instance.role,
      'isApproved': instance.isApproved,
    };
