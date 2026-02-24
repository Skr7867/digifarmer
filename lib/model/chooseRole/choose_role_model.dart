import 'package:freezed_annotation/freezed_annotation.dart';

part 'choose_role_model.freezed.dart';
part 'choose_role_model.g.dart';

@freezed
abstract class ChooseRoleModel with _$ChooseRoleModel {
  const factory ChooseRoleModel({
    required bool success,
    required String uniqueKey,
    required String message,
    required ChooseRoleUser user,
  }) = _ChooseRoleModel;

  factory ChooseRoleModel.fromJson(Map<String, dynamic> json) =>
      _$ChooseRoleModelFromJson(json);
}

@freezed
abstract class ChooseRoleUser with _$ChooseRoleUser {
  const factory ChooseRoleUser({
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
  }) = _ChooseRoleUser;

  factory ChooseRoleUser.fromJson(Map<String, dynamic> json) =>
      _$ChooseRoleUserFromJson(json);
}
