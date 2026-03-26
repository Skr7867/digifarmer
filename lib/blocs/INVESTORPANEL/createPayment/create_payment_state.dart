// create_payment_state.dart
part of 'create_payment_bloc.dart';

class CreatePaymentState {
  final PostApiStatus postApiStatus;
  final String message;
  final String? orderId;
  final int? amount;
  final String? currency;
  final String? keyId;
  final String? investmentId;
  final String? investmentNumber;
  final PlanDetails? planDetails;

  CreatePaymentState({
    this.postApiStatus = PostApiStatus.initial,
    this.message = '',
    this.orderId,
    this.amount,
    this.currency,
    this.keyId,
    this.investmentId,
    this.investmentNumber,
    this.planDetails,
  });

  CreatePaymentState copyWith({
    PostApiStatus? postApiStatus,
    String? message,
    String? orderId,
    int? amount,
    String? currency,
    String? keyId,
    String? investmentId,
    String? investmentNumber,
    PlanDetails? planDetails,
  }) {
    return CreatePaymentState(
      postApiStatus: postApiStatus ?? this.postApiStatus,
      message: message ?? this.message,
      orderId: orderId ?? this.orderId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      keyId: keyId ?? this.keyId,
      investmentId: investmentId ?? this.investmentId,
      investmentNumber: investmentNumber ?? this.investmentNumber,
      planDetails: planDetails ?? this.planDetails,
    );
  }
}
