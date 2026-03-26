// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_verify_otp_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginVerifyOtpResponse _$LoginVerifyOtpResponseFromJson(
  Map<String, dynamic> json,
) => _LoginVerifyOtpResponse(
  success: json['success'] as bool,
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  tokenType: json['tokenType'] as String,
  expiresIn: json['expiresIn'] as String,
  user: LoginVerifyUserModel.fromJson(json['user'] as Map<String, dynamic>),
  message: json['message'] as String,
);

Map<String, dynamic> _$LoginVerifyOtpResponseToJson(
  _LoginVerifyOtpResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'tokenType': instance.tokenType,
  'expiresIn': instance.expiresIn,
  'user': instance.user,
  'message': instance.message,
};

_LoginVerifyUserModel _$LoginVerifyUserModelFromJson(
  Map<String, dynamic> json,
) => _LoginVerifyUserModel(
  id: json['id'] as String,
  mobileNumber: json['mobileNumber'] as String,
  role: json['role'] as String?,
  fullName: json['fullName'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  panNumber: json['panNumber'] as String?,
  aadhaarNumber: json['aadhaarNumber'] as String?,
  address: json['address'] == null
      ? null
      : LoginVerifyAddressModel.fromJson(
          json['address'] as Map<String, dynamic>,
        ),
  profileImage: json['profileImage'] as String?,
  status: json['status'] as String,
  isApproved: json['isApproved'] as bool,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  requiresAdminApproval: json['requiresAdminApproval'] as bool,
);

Map<String, dynamic> _$LoginVerifyUserModelToJson(
  _LoginVerifyUserModel instance,
) => <String, dynamic>{
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

_LoginVerifyAddressModel _$LoginVerifyAddressModelFromJson(
  Map<String, dynamic> json,
) => _LoginVerifyAddressModel(
  houseNumber: json['houseNumber'] as String?,
  street: json['street'] as String?,
  area: json['area'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  pinCode: json['pinCode'] as String?,
  id: json['_id'] as String?,
);

Map<String, dynamic> _$LoginVerifyAddressModelToJson(
  _LoginVerifyAddressModel instance,
) => <String, dynamic>{
  'houseNumber': instance.houseNumber,
  'street': instance.street,
  'area': instance.area,
  'city': instance.city,
  'state': instance.state,
  'pinCode': instance.pinCode,
  '_id': instance.id,
};
