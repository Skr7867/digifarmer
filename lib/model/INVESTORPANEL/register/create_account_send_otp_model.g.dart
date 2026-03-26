// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_send_otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OtpResponseModel _$OtpResponseModelFromJson(Map<String, dynamic> json) =>
    _OtpResponseModel(
      success: json['success'] as bool,
      uniqueKey: json['uniqueKey'] as String,
      message: json['message'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$OtpResponseModelToJson(_OtpResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'uniqueKey': instance.uniqueKey,
      'message': instance.message,
      'user': instance.user,
      'otp': instance.otp,
    };

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
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

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
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
