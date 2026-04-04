import 'package:digifarmer/model/INVESTORPANEL/wallet/wallet_model.dart';
import 'package:digifarmer/repository/INVESTORPANEL/wallet/wallet_repository.dart';
import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';

class WalletHttpRepository implements WalletRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<WalletResponse> fetchWalletBalance() async {
    final response = await _apiServices.getApi(ApiUrls.walletApi);
    return WalletResponse.fromJson(response);
  }
}
