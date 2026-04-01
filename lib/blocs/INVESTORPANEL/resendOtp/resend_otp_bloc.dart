import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/INVESTORPANEL/resendOtp/resend_otp_model.dart';
import '../../../repository/INVESTORPANEL/resendOtp/resend_otp_repository.dart';
import '../../../utils/enums.dart';

part 'resend_otp_event.dart';
part 'resend_otp_state.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  final ResendOtpRepository resendOtpRepository;

  ResendOtpBloc(this.resendOtpRepository) : super(const ResendOtpState()) {
    on<ResendOtpSubmit>(_onResendOtp);
  }

  Future<void> _onResendOtp(
    ResendOtpSubmit event,
    Emitter<ResendOtpState> emit,
  ) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      final Map<String, dynamic> data = {
        "mobileNumber": event.mobileNumber,
      };

      final ResendOtpModel response =
          await resendOtpRepository.resendOtpApi(data);

      if (response.success == true) {
        emit(
          state.copyWith(
            mobileNumber: event.mobileNumber,
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