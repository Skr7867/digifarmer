import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

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
  Timer? _timer;

  LoginVerifyOtpBloc(this.repository) : super(const LoginVerifyOtpState()) {
    on<SetUniqueKey>(_setUniqueKey);
    on<OtpChanged>(_onOtpChanged);
    on<SubmitLoginOtp>(_submitOtp);
    on<ResendOtpEvent>(_onResendOtp);
    on<TimerTick>(_onTimerTick);
    on<ResetTimerEvent>(_onResetTimer);
  }

  void _setUniqueKey(SetUniqueKey event, Emitter<LoginVerifyOtpState> emit) {
    emit(state.copyWith(uniqueKey: event.uniqueKey));
    _startTimer();
  }

  void _onOtpChanged(OtpChanged event, Emitter<LoginVerifyOtpState> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  void _onTimerTick(TimerTick event, Emitter<LoginVerifyOtpState> emit) {
    if (event.remainingSeconds <= 0) {
      _timer?.cancel();
      emit(state.copyWith(remainingSeconds: 0, isResendEnabled: true));
    } else {
      emit(
        state.copyWith(
          remainingSeconds: event.remainingSeconds,
          isResendEnabled: false,
        ),
      );
    }
  }

  void _onResetTimer(ResetTimerEvent event, Emitter<LoginVerifyOtpState> emit) {
    _timer?.cancel();
    emit(state.copyWith(remainingSeconds: 60, isResendEnabled: false));
    _startTimer();
  }

  Future<void> _onResendOtp(
    ResendOtpEvent event,
    Emitter<LoginVerifyOtpState> emit,
  ) async {
    try {
      emit(state.copyWith(resendPostApiStatus: ResendPostApiStatus.loading));

      final Map<String, dynamic> data = {"mobileNumber": event.mobileNumber};

      final LoginVerifyOtpResponse response = await repository
          .verifyLoginOtpApi(data);

      if (response.success) {
        add(ResetTimerEvent());

        emit(
          state.copyWith(
            message: response.message,
            resendPostApiStatus: ResendPostApiStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            message: response.message,
            resendPostApiStatus: ResendPostApiStatus.error,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          message: error.toString(),
          resendPostApiStatus: ResendPostApiStatus.error,
        ),
      );
    }
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
          role: response.user.role ?? '',
          isApproved: response.user.isApproved,
        );
        await SessionController().saveUserInPreference(sessionUser);

        // Cancel timer on successful verification
        _timer?.cancel();

        emit(
          state.copyWith(
            message: response.message,
            accessToken: response.accessToken,
            refreshToken: response.refreshToken,
            role: response.user.role ?? '',
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

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.remainingSeconds - 1;
      if (remaining >= 0) {
        add(TimerTick(remaining));
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
