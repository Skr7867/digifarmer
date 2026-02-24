part of 'verify_otp_bloc.dart';

abstract class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object> get props => [];
}

class OtpChanged extends VerifyOtpEvent {
  const OtpChanged({required this.otp});
  final String otp;

  @override
  List<Object> get props => [otp];
}

class OtpUnfocus extends VerifyOtpEvent {}

class SetUniqueKey extends VerifyOtpEvent {
  final String uniqueKey;
  const SetUniqueKey(this.uniqueKey);

  @override
  List<Object> get props => [uniqueKey];
}

// ✅ uniqueKey add kiya
class VerifyOtp extends VerifyOtpEvent {
  final String uniqueKey;
  const VerifyOtp({required this.uniqueKey});

  @override
  List<Object> get props => [uniqueKey];
}
