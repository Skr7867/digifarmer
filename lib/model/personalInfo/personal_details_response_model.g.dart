// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonalDetailsResponseModel _$PersonalDetailsResponseModelFromJson(
  Map<String, dynamic> json,
) => _PersonalDetailsResponseModel(
  success: json['success'] as bool,
  uniqueKey: json['uniqueKey'] as String,
  message: json['message'] as String,
  user: PersonalDetailsUserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PersonalDetailsResponseModelToJson(
  _PersonalDetailsResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'uniqueKey': instance.uniqueKey,
  'message': instance.message,
  'user': instance.user,
};

_PersonalDetailsUserModel _$PersonalDetailsUserModelFromJson(
  Map<String, dynamic> json,
) => _PersonalDetailsUserModel(
  id: json['id'] as String,
  mobileNumber: json['mobileNumber'] as String,
  role: json['role'] as String?,
  fullName: json['fullName'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  panNumber: json['panNumber'] as String?,
  aadhaarNumber: json['aadhaarNumber'] as String?,
  address: json['address'] == null
      ? null
      : PersonalAddressModel.fromJson(json['address'] as Map<String, dynamic>),
  profileImage: json['profileImage'] as String?,
  status: json['status'] as String,
  isApproved: json['isApproved'] as bool,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  requiresAdminApproval: json['requiresAdminApproval'] as bool?,
);

Map<String, dynamic> _$PersonalDetailsUserModelToJson(
  _PersonalDetailsUserModel instance,
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

_PersonalAddressModel _$PersonalAddressModelFromJson(
  Map<String, dynamic> json,
) => _PersonalAddressModel(
  houseNumber: json['houseNumber'] as String?,
  street: json['street'] as String?,
  area: json['area'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  pinCode: json['pinCode'] as String?,
  id: json['_id'] as String?,
);

Map<String, dynamic> _$PersonalAddressModelToJson(
  _PersonalAddressModel instance,
) => <String, dynamic>{
  'houseNumber': instance.houseNumber,
  'street': instance.street,
  'area': instance.area,
  'city': instance.city,
  'state': instance.state,
  'pinCode': instance.pinCode,
  '_id': instance.id,
};
