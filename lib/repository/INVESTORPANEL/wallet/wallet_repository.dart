import '../../../model/INVESTORPANEL/wallet/wallet_model.dart';

abstract class WalletRepository {
  Future<WalletResponse> fetchWalletBalance();
}
