part of 'create_payment_bloc.dart';

abstract class CreatePaymentEvent extends Equatable {
  const CreatePaymentEvent();

  @override
  List<Object?> get props => [];
}

class CreatePaymentButtonPressed extends CreatePaymentEvent {
  final String investmentId;

  const CreatePaymentButtonPressed({required this.investmentId});

  @override
  List<Object?> get props => [investmentId];
}
