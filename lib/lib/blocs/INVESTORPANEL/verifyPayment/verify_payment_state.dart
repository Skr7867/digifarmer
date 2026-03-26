part of 'verify_payment_bloc.dart';

class VerifyPaymentState extends Equatable {
  const VerifyPaymentState({
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String message;
  final PostApiStatus postApiStatus;

  VerifyPaymentState copyWith({
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return VerifyPaymentState(
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object> get props => [message, postApiStatus];
}