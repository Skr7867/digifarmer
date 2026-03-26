import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_details_response_model.freezed.dart';
part 'personal_details_response_model.g.dart';

@freezed
abstract class PersonalDetailsResponseModel
    with _$PersonalDetailsResponseModel {
  const factory PersonalDetailsResponseModel({
    required bool success,
    required String uniqueKey,
    required String message,
    required PersonalDetailsUserModel user,
  }) = _PersonalDetailsResponseModel;

  factory PersonalDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalDetailsResponseModelFromJson(json);
}

@freezed
abstract class PersonalDetailsUserModel with _$PersonalDetailsUserModel {
  const factory PersonalDetailsUserModel({
    required String id,
    required String mobileNumber,
    String? role,
    String? fullName,
    String? dateOfBirth,
    String? panNumber,
    String? aadhaarNumber,
    PersonalAddressModel? address,
    String? profileImage,
    required String status,
    required bool isApproved,
    required String createdAt,
    required String updatedAt,
    bool? requiresAdminApproval,
  }) = _PersonalDetailsUserModel;

  factory PersonalDetailsUserModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalDetailsUserModelFromJson(json);
}

@freezed
abstract class PersonalAddressModel with _$PersonalAddressModel {
  const factory PersonalAddressModel({
    String? houseNumber,
    String? street,
    String? area,
    String? city,
    String? state,
    String? pinCode,
    @JsonKey(name: '_id') String? id,
  }) = _PersonalAddressModel;

  factory PersonalAddressModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalAddressModelFromJson(json);
}
