part of 'verify_payment_bloc.dart';

abstract class VerifyPaymentEvent extends Equatable {
  const VerifyPaymentEvent();

  @override
  List<Object> get props => [];
}

class VerifyPaymentButtonPressed extends VerifyPaymentEvent {
  final String razorpayOrderId;
  final String razorpayPaymentId;
  final String razorpaySignature;

  const VerifyPaymentButtonPressed({
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.razorpaySignature,
  });

  @override
  List<Object> get props => [
    razorpayOrderId,
    razorpayPaymentId,
    razorpaySignature,
  ];
}