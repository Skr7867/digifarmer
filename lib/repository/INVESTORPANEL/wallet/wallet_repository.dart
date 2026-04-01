
import 'package:digifarmer/model/INVESTORPANEL/wallet/wallet_model.dart';

abstract class WalletRepository {
  Future<WalletModel> fetchWalletBalance();
}
