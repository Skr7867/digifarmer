part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileStarted extends UpdateProfileEvent {
  const UpdateProfileStarted();
}

class ProfileImagePicked extends UpdateProfileEvent {
  const ProfileImagePicked({required this.imagePath});

  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}

class SubmitUpdateProfile extends UpdateProfileEvent {
  const SubmitUpdateProfile();
}
