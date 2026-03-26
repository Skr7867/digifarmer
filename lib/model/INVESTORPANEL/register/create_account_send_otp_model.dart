import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_account_send_otp_model.freezed.dart';
part 'create_account_send_otp_model.g.dart';

@freezed
abstract class OtpResponseModel with _$OtpResponseModel {
  const factory OtpResponseModel({
    required bool success,
    required String uniqueKey,
    required String message,
    required UserModel user,
    required String otp,
  }) = _OtpResponseModel;

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseModelFromJson(json);
}

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String mobileNumber,
    String? role,
    String? fullName,
    String? dateOfBirth,
    String? panNumber,
    String? aadhaarNumber,
    String? address,
    String? profileImage,
    required String status,
    required bool isApproved,
    required String createdAt,
    required String updatedAt,
    bool? requiresAdminApproval,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
