part of 'user_login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.mobileNumber = '',
    this.uniqueKey = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String mobileNumber;
  final String uniqueKey;
  final String message;
  final PostApiStatus postApiStatus;

  LoginState copyWith({
    String? mobileNumber,
    String? uniqueKey,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return LoginState(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object?> get props => [mobileNumber, uniqueKey, message, postApiStatus];
}
