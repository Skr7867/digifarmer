// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choose_role_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChooseRoleModel _$ChooseRoleModelFromJson(Map<String, dynamic> json) =>
    _ChooseRoleModel(
      success: json['success'] as bool,
      uniqueKey: json['uniqueKey'] as String,
      message: json['message'] as String,
      user: ChooseRoleUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChooseRoleModelToJson(_ChooseRoleModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'uniqueKey': instance.uniqueKey,
      'message': instance.message,
      'user': instance.user,
    };

_ChooseRoleUser _$ChooseRoleUserFromJson(Map<String, dynamic> json) =>
    _ChooseRoleUser(
      id: json['id'] as String,
      mobileNumber: json['mobileNumber'] as String,
      role: json['role'] as String?,
      fullName: json['fullName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      panNumber: json['panNumber'] as String?,
      aadhaarNumber: json['aadhaarNumber'] as String?,
      address: json['address'] as String?,
      profileImage: json['profileImage'] as String?,
      status: json['status'] as String,
      isApproved: json['isApproved'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      requiresAdminApproval: json['requiresAdminApproval'] as bool?,
    );

Map<String, dynamic> _$ChooseRoleUserToJson(_ChooseRoleUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mobileNumber': instance.mobileNumber,
      'role': instance.role,
      'fullName': instance.fullName,
      'dateOfBirth': instance.dateOfBirth,
      'panNumber': instance.panNumber,
      'aadhaarNumber': instance.aadhaarNumber,
      'address': instance.address,
      'profileImage': instance.profileImage,
      'status': instance.status,
      'isApproved': instance.isApproved,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'requiresAdminApproval': instance.requiresAdminApproval,
    };
