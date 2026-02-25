part of 'login_otp_verify_bloc.dart';

abstract class LoginVerifyOtpEvent extends Equatable {
  const LoginVerifyOtpEvent();

  @override
  List<Object?> get props => [];
}

class SetUniqueKey extends LoginVerifyOtpEvent {
  final String uniqueKey;

  const SetUniqueKey(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}

class OtpChanged extends LoginVerifyOtpEvent {
  final String otp;

  const OtpChanged(this.otp);

  @override
  List<Object?> get props => [otp];
}

class SubmitLoginOtp extends LoginVerifyOtpEvent {}

/// New Event for Resending OTP
class ResendOtpEvent extends LoginVerifyOtpEvent {
  final String mobileNumber;

  const ResendOtpEvent(this.mobileNumber);

  @override
  List<Object?> get props => [mobileNumber];
}

/// Timer Events
class TimerTick extends LoginVerifyOtpEvent {
  final int remainingSeconds;

  const TimerTick(this.remainingSeconds);

  @override
  List<Object?> get props => [remainingSeconds];
}

class ResetTimerEvent extends LoginVerifyOtpEvent {}
