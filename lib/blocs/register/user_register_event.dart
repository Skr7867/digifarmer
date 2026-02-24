part of 'user_register_bloc.dart';

abstract class UserRegisterEvent extends Equatable {
  const UserRegisterEvent();

  @override
  List<Object> get props => [];
}

class MobileNumber extends UserRegisterEvent {
  const MobileNumber({required this.mobile});

  final String mobile;

  @override
  List<Object> get props => [mobile];
}

class MobileUnfocus extends UserRegisterEvent {}

class EmailChanged extends UserRegisterEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocus extends UserRegisterEvent {}

class SendOtp extends UserRegisterEvent {}
