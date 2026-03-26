import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../repository/INVESTORPANEL/verifyPayment/verify_payment_repository.dart';
import '../../../utils/enums.dart';

part 'verify_payment_event.dart';
part 'verify_payment_state.dart';

class VerifyPaymentBloc extends Bloc<VerifyPaymentEvent, VerifyPaymentState> {
  final VerifyPaymentRepository verifyPaymentRepository;

  VerifyPaymentBloc({required this.verifyPaymentRepository})
      : super(const VerifyPaymentState()) {
    on<VerifyPaymentButtonPressed>(_onVerifyPayment);
  }

  Future<void> _onVerifyPayment(
    VerifyPaymentButtonPressed event,
    Emitter<VerifyPaymentState> emit,
  ) async {
    try {
      emit(state.copyWith(
        postApiStatus: PostApiStatus.loading,
        message: '',
      ));

      final Map<String, dynamic> data = {
        "razorpay_order_id": event.razorpayOrderId,
        "razorpay_payment_id": event.razorpayPaymentId,
        "razorpay_signature": event.razorpaySignature,
      };

      final response = await verifyPaymentRepository.verifyPaymentApi(data);

      log("VERIFY PAYMENT RESPONSE: ${response.toString()}");

      if (response.success == true) {
        emit(state.copyWith(
          message: response.message ?? 'Payment verified successfully',
          postApiStatus: PostApiStatus.success,
        ));
      } else {
        emit(state.copyWith(
          message: response.message ?? 'Payment verification failed',
          postApiStatus: PostApiStatus.error,
        ));
      }
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());

      emit(state.copyWith(
        message: error.toString(),
        postApiStatus: PostApiStatus.error,
      ));
    }
  }
}