part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  const UserProfileState({required this.userProfile});

  final ApiResponse<UserProfileModel> userProfile;

  UserProfileState copyWith({ApiResponse<UserProfileModel>? userProfile}) {
    return UserProfileState(userProfile: userProfile ?? this.userProfile);
  }

  @override
  List<Object?> get props => [userProfile];
}
