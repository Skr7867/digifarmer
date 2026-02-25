import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/userLogin/user_login_repository.dart';
import '../../utils/enums.dart';
import '../../model/userLogin/login_response_model.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLoginRepository userLoginRepository;

  LoginBloc(this.userLoginRepository) : super(const LoginState()) {
    on<MobileNumberChanged>(_onMobileChanged);
    on<SubmitLogin>(_submitLogin);
  }

  void _onMobileChanged(MobileNumberChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(mobileNumber: event.mobileNumber));
  }

  Future<void> _submitLogin(SubmitLogin event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      final Map<String, dynamic> data = {"mobileNumber": state.mobileNumber};

      final LoginResponseModel response = await userLoginRepository
          .userLoginApi(data);

      if (response.success == true) {
        emit(
          state.copyWith(
            uniqueKey: response.uniqueKey,
            message: response.message,
            otp: response.otp ?? '',
            postApiStatus: PostApiStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            message: response.message,
            postApiStatus: PostApiStatus.error,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          message: error.toString(),
          postApiStatus: PostApiStatus.error,
        ),
      );
    }
  }
}
