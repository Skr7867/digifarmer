part of 'withdrawal_amount_bloc.dart';

class WithdrawalAmountState extends Equatable {
  const WithdrawalAmountState({
    this.amount = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
    this.withdrawalSuccess = false,
  });

  final String amount;
  final String message;
  final PostApiStatus postApiStatus;
  final bool withdrawalSuccess;

  WithdrawalAmountState copyWith({
    String? amount,
    String? message,
    PostApiStatus? postApiStatus,
    bool? withdrawalSuccess,
  }) {
    return WithdrawalAmountState(
      amount: amount ?? this.amount,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      withdrawalSuccess: withdrawalSuccess ?? this.withdrawalSuccess,
    );
  }

  @override
  List<Object?> get props => [
    amount,
    message,
    postApiStatus,
    withdrawalSuccess,
  ];
}