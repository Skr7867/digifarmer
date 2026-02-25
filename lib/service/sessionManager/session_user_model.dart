import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_user_model.freezed.dart';
part 'session_user_model.g.dart';

@freezed
abstract class SessionUserModel with _$SessionUserModel {
  const factory SessionUserModel({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String mobileNumber,
    String? role,
    required bool isApproved,
  }) = _SessionUserModel;

  factory SessionUserModel.fromJson(Map<String, dynamic> json) =>
      _$SessionUserModelFromJson(json);
}
