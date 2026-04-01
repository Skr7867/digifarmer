import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../model/INVESTORPANEL/withdrawalAmount/withdrawal_amount_model.dart';
import '../../../repository/INVESTORPANEL/withdrawalAmount/withdrawal_amount_repository.dart';
import '../../../utils/enums.dart';
part  'withdrawal_amount_event.dart';
part 'withdrawal_amount_state.dart';

class WithdrawalAmountBloc extends Bloc<WithdrawalAmountEvent, WithdrawalAmountState> {
  final WithdrawalAmountRepository withdrawalAmountRepository;

  WithdrawalAmountBloc(this.withdrawalAmountRepository) : super(const WithdrawalAmountState()) {
    on<AmountChanged>(_onAmountChanged);
    on<SubmitWithdrawal>(_submitWithdrawal);
    on<ResetWithdrawalState>(_resetWithdrawalState);
  }

  void _onAmountChanged(AmountChanged event, Emitter<WithdrawalAmountState> emit) {
    emit(state.copyWith(amount: event.amount));
  }

  Future<void> _submitWithdrawal(SubmitWithdrawal event, Emitter<WithdrawalAmountState> emit) async {
    try {
      emit(state.copyWith(
        postApiStatus: PostApiStatus.loading,
        message: '',
      ));

      // Validate amount
      if (state.amount.isEmpty) {
        emit(state.copyWith(
          message: 'Please enter withdrawal amount',
          postApiStatus: PostApiStatus.error,
        ));
        return;
      }

      final double amountValue = double.tryParse(state.amount) ?? 0;
      if (amountValue <= 0) {
        emit(state.copyWith(
          message: 'Please enter a valid amount greater than 0',
          postApiStatus: PostApiStatus.error,
        ));
        return;
      }

      // Prepare request data
      final Map<String, dynamic> data = {
        "amount": amountValue,
        "paymentMethod": "BANK_TRANSFER", // Hardcoded as per requirement
        "notes": "Withdrawal request from user" // Hardcoded as per requirement
      };

      final WithdrawalAmountModel response = await withdrawalAmountRepository
          .withdrawalAmountApi(data);

      if (response.success == true) {
        emit(state.copyWith(
          message: response.message ?? 'Withdrawal request sent successfully',
          postApiStatus: PostApiStatus.success,
          withdrawalSuccess: true,
        ));
      } else {
        emit(state.copyWith(
          message: response.message ?? 'Withdrawal request failed',
          postApiStatus: PostApiStatus.error,
          withdrawalSuccess: false,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        message: error.toString(),
        postApiStatus: PostApiStatus.error,
        withdrawalSuccess: false,
      ));
    }
  }

  void _resetWithdrawalState(ResetWithdrawalState event, Emitter<WithdrawalAmountState> emit) {
    emit(const WithdrawalAmountState());
  }
}