part of 'resend_otp_bloc.dart';

abstract class ResendOtpEvent extends Equatable {
  const ResendOtpEvent();

  @override
  List<Object?> get props => [];
}

class ResendOtpSubmit extends ResendOtpEvent {
  final String mobileNumber;

  const ResendOtpSubmit(this.mobileNumber);

  @override
  List<Object?> get props => [mobileNumber];
}