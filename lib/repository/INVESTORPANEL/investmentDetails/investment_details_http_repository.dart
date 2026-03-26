import 'package:digifarmer/repository/INVESTORPANEL/investmentDetails/investment_details_repository.dart';
import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/INVESTORPANEL/investmentDetails/investment_details_model.dart';


class InvestmentDetailsHttpRepository implements InvestmentDetailsRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<InvestmentDetailsModel> fetchInvestmentDetails(String planId) async {
    final response = await _apiServices.getApi(ApiUrls.investmentDetailsApi(planId));
    return InvestmentDetailsModel.fromJson(response);
  }
}
