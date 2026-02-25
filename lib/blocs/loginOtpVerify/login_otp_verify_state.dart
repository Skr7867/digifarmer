part of 'login_otp_verify_bloc.dart';

class LoginVerifyOtpState extends Equatable {
  const LoginVerifyOtpState({
    this.uniqueKey = '',
    this.otp = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
    this.accessToken = '',
    this.refreshToken = '',
  });

  final String uniqueKey;
  final String otp;
  final String message;
  final PostApiStatus postApiStatus;

  final String accessToken;
  final String refreshToken;

  LoginVerifyOtpState copyWith({
    String? uniqueKey,
    String? otp,
    String? message,
    PostApiStatus? postApiStatus,
    String? accessToken,
    String? refreshToken,
  }) {
    return LoginVerifyOtpState(
      uniqueKey: uniqueKey ?? this.uniqueKey,
      otp: otp ?? this.otp,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  List<Object?> get props => [
    uniqueKey,
    otp,
    message,
    postApiStatus,
    accessToken,
    refreshToken,
  ];
}
