import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/INVESTORPANEL/activeInvestment/active_investment_model.dart';
import 'active_investment_repository.dart';

class ActiveInvestmentHttpRepository implements ActiveInvestmentRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<ActiveInvestmentModel> fetchInvestmentApi() async {
    final response = await _apiServices.getApi(ApiUrls.activeInvestmentApi);
    return ActiveInvestmentModel.fromJson(response);
  }
}
