part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  const WalletState({required this.wallet});

  final ApiResponse<WalletModel> wallet;

  WalletState copyWith({
    ApiResponse<WalletModel>? wallet,
  }) {
    return WalletState(
      wallet: wallet ?? this.wallet,
    );
  }

  @override
  List<Object?> get props => [wallet];
}