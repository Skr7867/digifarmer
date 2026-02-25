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
