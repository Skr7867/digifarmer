part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  const WalletState({required this.wallet});

  final ApiResponse<WalletResponse> wallet;

  WalletState copyWith({ApiResponse<WalletResponse>? wallet}) {
    return WalletState(wallet: wallet ?? this.wallet);
  }

  @override
  List<Object?> get props => [wallet];
}
