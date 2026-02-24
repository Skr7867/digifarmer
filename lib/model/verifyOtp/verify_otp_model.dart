import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_model.freezed.dart';
part 'verify_otp_model.g.dart';

@freezed
abstract class VerifyOtpModel with _$VerifyOtpModel {
  const factory VerifyOtpModel({
    required bool success,
    required String uniqueKey,
    required String message,
    required VerifyOtpUserModel user,
  }) = _VerifyOtpModel;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpModelFromJson(json);
}

@freezed
abstract class VerifyOtpUserModel with _$VerifyOtpUserModel {
  const factory VerifyOtpUserModel({
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
  }) = _VerifyOtpUserModel;

  factory VerifyOtpUserModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpUserModelFromJson(json);
}
