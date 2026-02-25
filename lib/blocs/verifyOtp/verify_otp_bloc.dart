import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/verifyOtp/verify_otp_repository.dart';
import '../../utils/enums.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final VerifyOtpRepository sendOtpResponseRepository;

  VerifyOtpBloc(this.sendOtpResponseRepository)
    : super(const VerifyOtpState()) {
    on<SetUniqueKey>(_setUniqueKey);

    on<OtpChanged>(_onOtpChanged);
    on<VerifyOtp>(_verifyOtp);
  }

  void _setUniqueKey(SetUniqueKey event, Emitter<VerifyOtpState> emit) {
    emit(state.copyWith(uniqueKey: event.uniqueKey));
  }

  void _onOtpChanged(OtpChanged event, Emitter<VerifyOtpState> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  Future<void> _verifyOtp(VerifyOtp event, Emitter<VerifyOtpState> emit) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      final Map<String, dynamic> data = {
        "uniqueKey": event.uniqueKey,
        "otp": state.otp,
      };

      final value = await sendOtpResponseRepository.verifyOtpApi(data);

      if (value.success == true) {
        emit(
          state.copyWith(
            message: value.message,
            postApiStatus: PostApiStatus.success,
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
