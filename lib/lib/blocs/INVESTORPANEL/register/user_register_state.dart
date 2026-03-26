part of 'user_register_bloc.dart';

class UserRegisterState extends Equatable {
  const UserRegisterState({
    this.mobile = '',
    this.email = '',
    this.message = '',
    this.uniqueKey = '',
    this.otp = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String mobile;
  final String email;
  final String message;
  final String uniqueKey;
  final String otp;
  final PostApiStatus postApiStatus;

  UserRegisterState copyWith({
    String? mobile,
    String? email,
    String? message,
    String? uniqueKey,
    String? otp,
    PostApiStatus? postApiStatus,
  }) {
    return UserRegisterState(
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      message: message ?? this.message,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      otp: otp ?? this.otp,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object> get props => [
    mobile,
    email,
    message,
    uniqueKey,
    otp,
    postApiStatus,
  ];
}
