import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/INVESTORPANEL/withdrawalAmount/withdrawal_amount_model.dart';

import 'package:digifarmer/repository/INVESTORPANEL/withdrawalAmount/withdrawal_amount_repository.dart';

class WithdrawalAmountHttpRepository implements WithdrawalAmountRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<WithdrawalAmountModel> withdrawalAmountApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.withdrawalAmountApi);
    return WithdrawalAmountModel.fromJson(response);
  }
}
