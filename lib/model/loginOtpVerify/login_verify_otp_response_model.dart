import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_verify_otp_response_model.freezed.dart';
part 'login_verify_otp_response_model.g.dart';

@freezed
abstract class LoginVerifyOtpResponse with _$LoginVerifyOtpResponse {
  const factory LoginVerifyOtpResponse({
    required bool success,
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required String expiresIn,
    required LoginVerifyUserModel user,
    required String message,
  }) = _LoginVerifyOtpResponse;

  factory LoginVerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginVerifyOtpResponseFromJson(json);
}

@freezed
abstract class LoginVerifyUserModel with _$LoginVerifyUserModel {
  const factory LoginVerifyUserModel({
    required String id,
    required String mobileNumber,
    String? role,
    String? fullName,
    String? dateOfBirth,
    String? panNumber,
    String? aadhaarNumber,
    LoginVerifyAddressModel? address,
    String? profileImage,
    required String status,
    required bool isApproved,
    required String createdAt,
    required String updatedAt,
    required bool requiresAdminApproval,
  }) = _LoginVerifyUserModel;

  factory LoginVerifyUserModel.fromJson(Map<String, dynamic> json) =>
      _$LoginVerifyUserModelFromJson(json);
}

@freezed
abstract class LoginVerifyAddressModel with _$LoginVerifyAddressModel {
  const factory LoginVerifyAddressModel({
    String? houseNumber,
    String? street,
    String? area,
    String? city,
    String? state,
    String? pinCode,
    @JsonKey(name: '_id') String? id,
  }) = _LoginVerifyAddressModel;

  factory LoginVerifyAddressModel.fromJson(Map<String, dynamic> json) =>
      _$LoginVerifyAddressModelFromJson(json);
}
