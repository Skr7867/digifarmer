part of 'user_register_bloc.dart';

class UserRegisterState extends Equatable {
  const UserRegisterState({
    this.mobile = '',
    this.email = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String mobile;
  final String email;
  final String message;
  final PostApiStatus postApiStatus;

  UserRegisterState copyWith({
    String? mobile,
    String? email,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return UserRegisterState(
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object> get props => [mobile, email, message, postApiStatus];
}
