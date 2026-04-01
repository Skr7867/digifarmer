part of 'withdrawal_amount_bloc.dart';

abstract class WithdrawalAmountEvent extends Equatable {
  const WithdrawalAmountEvent();

  @override
  List<Object?> get props => [];
}

class AmountChanged extends WithdrawalAmountEvent {
  final String amount;

  const AmountChanged(this.amount);

  @override
  List<Object?> get props => [amount];
}

class SubmitWithdrawal extends WithdrawalAmountEvent {
  const SubmitWithdrawal();
}

class ResetWithdrawalState extends WithdrawalAmountEvent {
  const ResetWithdrawalState();
}