import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    on<SendOtp>(_sendOtp);
  }

  void _onMobileChanged(MobileNumber event, Emitter<UserRegisterState> emit) {
    emit(state.copyWith(mobile: event.mobile));
  }

  void _onEmailChanged(EmailChanged event, Emitter<UserRegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _sendOtp(SendOtp event, Emitter<UserRegisterState> emit) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      final Map<String, dynamic> data = {"mobileNumber": state.mobile};

      final value = await userRegisterRepository.userRegisterApi(data);

      log("API RESPONSE: ${value.toString()}");

      if (value.success == true) {
        emit(
          state.copyWith(
            message: value.message,
            uniqueKey: value.uniqueKey,
            otp: value.otp,
            postApiStatus: PostApiStatus.sucess,
          ),
        );
      } else {
        emit(
          state.copyWith(
            message: value.message,
            postApiStatus: PostApiStatus.error,
          ),
        );
      }
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());

      emit(
        state.copyWith(
          message: error.toString(),
          postApiStatus: PostApiStatus.error,
        ),
      );
    }
  }
}
