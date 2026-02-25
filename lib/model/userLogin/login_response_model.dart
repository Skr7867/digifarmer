import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

@freezed
abstract class LoginResponseModel with _$LoginResponseModel {
  const factory LoginResponseModel({
    required bool success,
    required String uniqueKey,
    required String message,
    required LoginUserModel user,
    required String otp,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}

@freezed
abstract class LoginUserModel with _$LoginUserModel {
  const factory LoginUserModel({
    required String id,
    required String mobileNumber,
    String? role,
    String? fullName,
    String? dateOfBirth,
    String? panNumber,
    String? aadhaarNumber,
    LoginAddressModel? address,
    String? profileImage,
    required String status,
    required bool isApproved,
    required String createdAt,
    required String updatedAt,
    required bool requiresAdminApproval,
  }) = _LoginUserModel;

  factory LoginUserModel.fromJson(Map<String, dynamic> json) =>
      _$LoginUserModelFromJson(json);
}

@freezed
abstract class LoginAddressModel with _$LoginAddressModel {
  const factory LoginAddressModel({
    String? houseNumber,
    String? street,
    String? area,
    String? city,
    String? state,
    String? pinCode,
    @JsonKey(name: '_id') String? id,
  }) = _LoginAddressModel;

  factory LoginAddressModel.fromJson(Map<String, dynamic> json) =>
      _$LoginAddressModelFromJson(json);
}
