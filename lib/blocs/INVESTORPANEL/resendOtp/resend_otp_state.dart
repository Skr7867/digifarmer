part of 'resend_otp_bloc.dart';

class ResendOtpState extends Equatable {
  const ResendOtpState({
    this.mobileNumber = '',
    this.uniqueKey = '',
    this.message = '',
    this.otp = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String mobileNumber;
  final String uniqueKey;
  final String message;
  final String otp;
  final PostApiStatus postApiStatus;

  ResendOtpState copyWith({
    String? mobileNumber,
    String? uniqueKey,
    String? message,
    String? otp,
    PostApiStatus? postApiStatus,
  }) {
    return ResendOtpState(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      message: message ?? this.message,
      otp: otp ?? this.otp,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object?> get props => [
    mobileNumber,
    uniqueKey,
    message,
    otp,
    postApiStatus,
  ];
}