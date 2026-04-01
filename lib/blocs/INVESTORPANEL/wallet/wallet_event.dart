part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WalletFetched extends WalletEvent {}