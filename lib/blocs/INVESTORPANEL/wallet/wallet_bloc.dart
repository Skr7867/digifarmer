import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/INVESTORPANEL/wallet/wallet_model.dart';
import '../../../repository/INVESTORPANEL/wallet/wallet_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;
  WalletBloc({required this.walletRepository})
      : super(WalletState(wallet: ApiResponse.loading())) {
    on<WalletFetched>(_fetchWalletBalance);
  }

  Future<void> _fetchWalletBalance(
    WalletFetched event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(wallet: ApiResponse.loading()));

    try {
      final response = await walletRepository.fetchWalletBalance();
      emit(state.copyWith(wallet: ApiResponse.completed(response)));
    } catch (error) {
      emit(
        state.copyWith(wallet: ApiResponse.error(error.toString())),
      );
    }
  }
}