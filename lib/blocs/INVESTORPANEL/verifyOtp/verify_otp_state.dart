part of 'verify_otp_bloc.dart';

class VerifyOtpState extends Equatable {
  const VerifyOtpState({
    this.otp = '',
    this.uniqueKey = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String otp;
  final String uniqueKey;
  final String message;
  final PostApiStatus postApiStatus;

  VerifyOtpState copyWith({
    String? otp,
    String? uniqueKey,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return VerifyOtpState(
      otp: otp ?? this.otp,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object> get props => [otp, uniqueKey, message, postApiStatus];
}
