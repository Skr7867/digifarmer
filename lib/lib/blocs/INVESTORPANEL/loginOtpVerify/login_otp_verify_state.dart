part of 'login_otp_verify_bloc.dart';

class LoginVerifyOtpState extends Equatable {
  final String uniqueKey;
  final String otp;
  final String message;
  final PostApiStatus postApiStatus;
  final ResendPostApiStatus resendPostApiStatus;
  final String accessToken;
  final String refreshToken;
  final String role;

  // Timer related fields
  final int remainingSeconds;
  final bool isResendEnabled;

  const LoginVerifyOtpState({
    this.uniqueKey = '',
    this.otp = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
    this.resendPostApiStatus = ResendPostApiStatus.initial,
    this.accessToken = '',
    this.refreshToken = '',
    this.remainingSeconds = 60,
    this.isResendEnabled = false,
    this.role = '',
  });

  LoginVerifyOtpState copyWith({
    String? uniqueKey,
    String? otp,
    String? message,
    PostApiStatus? postApiStatus,
    ResendPostApiStatus? resendPostApiStatus,
    String? accessToken,
    String? refreshToken,
    int? remainingSeconds,
    bool? isResendEnabled,
    String? role,
  }) {
    return LoginVerifyOtpState(
      uniqueKey: uniqueKey ?? this.uniqueKey,
      otp: otp ?? this.otp,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      resendPostApiStatus: resendPostApiStatus ?? this.resendPostApiStatus,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isResendEnabled: isResendEnabled ?? this.isResendEnabled,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [
    uniqueKey,
    otp,
    message,
    postApiStatus,
    resendPostApiStatus,
    accessToken,
    refreshToken,
    remainingSeconds,
    isResendEnabled,
    role,
  ];
}
