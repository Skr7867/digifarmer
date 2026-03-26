part of 'update_profile_bloc.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState({
    this.imagePath = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });
  final String imagePath;
  final String message;
  final PostApiStatus postApiStatus;

  UpdateProfileState copyWith({
  
    String? imagePath,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return UpdateProfileState(
      
      imagePath: imagePath ?? this.imagePath,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object> get props => [
   
    imagePath,
    message,
    postApiStatus,
  ];
}