import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/register/user_register_repository.dart';
import '../../utils/enums.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  final UserRegisterRepository userRegisterRepository;

  UserRegisterBloc(this.userRegisterRepository)
    : super(const UserRegisterState()) {
    on<MobileNumber>(_onMobileChanged);
    on<EmailChanged>(_onEmailChanged);
    // on<SendOtp>(_sendOtp);
  }

  void _onMobileChanged(MobileNumber event, Emitter<UserRegisterState> emit) {
    emit(state.copyWith(mobile: event.mobile));
  }

  void _onEmailChanged(EmailChanged event, Emitter<UserRegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }
}
