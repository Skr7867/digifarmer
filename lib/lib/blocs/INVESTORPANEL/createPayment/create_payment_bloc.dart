// create_payment_bloc.dart
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../model/INVESTORPANEL/createPayment/create_payment_model.dart';
import '../../../repository/INVESTORPANEL/createPayment/create_payment_repository.dart';
import '../../../utils/enums.dart';

part 'create_payment_event.dart';
part 'create_payment_state.dart';

class CreatePaymentBloc extends Bloc<CreatePaymentEvent, CreatePaymentState> {
  final CreatePaymentRepository createPaymentRepository;

  CreatePaymentBloc({required this.createPaymentRepository})
    : super(CreatePaymentState()) {
    on<CreatePaymentButtonPressed>(_onCreatePaymentButtonPressed);
  }

  Future<void> _onCreatePaymentButtonPressed(
    CreatePaymentButtonPressed event,
    Emitter<CreatePaymentState> emit,
  ) async {
    // First emit loading state
    emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ''));

    try {
      // Call the API
      final response = await createPaymentRepository.createPaymentApi(
        event.investmentId,
      );

      // Log the response for debugging
      print(
        'CreatePaymentBloc: Response received - OrderId: ${response.orderId}',
      );

      // Emit success state with the response data
      emit(
        CreatePaymentState(
          postApiStatus: PostApiStatus.success,
          orderId: response.orderId.toString(),
          amount: response.amount,
          currency: response.currency.toString(),
          keyId: response.keyId,
          investmentId: response.investmentId.toString(),
          investmentNumber: response.investmentNumber,
          planDetails: response.planDetails,
          message: 'Payment order created successfully',
        ),
      );
    } catch (error) {
      // Emit error state
      print('CreatePaymentBloc: Error - $error');
      emit(
        CreatePaymentState(
          postApiStatus: PostApiStatus.error,
          message: error.toString(),
        ),
      );
    }
  }
}
