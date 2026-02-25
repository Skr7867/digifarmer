import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/loginOtpVerify/login_otp_verify_repository.dart';
import '../../model/loginOtpVerify/login_verify_otp_response_model.dart';
import '../../service/sessionManager/session_controller.dart';
import '../../service/sessionManager/session_user_model.dart';
import '../../utils/enums.dart';

part 'login_otp_verify_event.dart';
part 'login_otp_verify_state.dart';

class LoginVerifyOtpBloc
    extends Bloc<LoginVerifyOtpEvent, LoginVerifyOtpState> {
  final LoginOtpVerifyRepository repository;

  LoginVerifyOtpBloc(this.repository) : super(const LoginVerifyOtpState()) {
    on<SetUniqueKey>(_setUniqueKey);
    on<OtpChanged>(_onOtpChanged);
    on<SubmitLoginOtp>(_submitOtp);
  }

  void _setUniqueKey(SetUniqueKey event, Emitter<LoginVerifyOtpState> emit) {
    emit(state.copyWith(uniqueKey: event.uniqueKey));
  }

  void _onOtpChanged(OtpChanged event, Emitter<LoginVerifyOtpState> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  Future<void> _submitOtp(
    SubmitLoginOtp event,
    Emitter<LoginVerifyOtpState> emit,
  ) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      final Map<String, dynamic> data = {
        "uniqueKey": state.uniqueKey,
        "otp": state.otp,
      };

      final LoginVerifyOtpResponse response = await repository
          .verifyLoginOtpApi(data);

      if (response.success) {
        final sessionUser = SessionUserModel(
          accessToken: response.accessToken,
          refreshToken: response.refreshToken,
          userId: response.user.id,
          mobileNumber: response.user.mobileNumber,
          role: response.user.role,
          isApproved: response.user.isApproved,
        );
        await SessionController().saveUserInPreference(sessionUser);
        emit(
          state.copyWith(
            message: response.message,
            accessToken: response.accessToken,
            refreshToken: response.refreshToken,
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
