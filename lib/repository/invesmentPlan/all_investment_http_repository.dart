import 'package:digifarmer/repository/invesmentPlan/all_investment_plan_repository.dart';

import '../../config/apiUrls/api_urls.dart';
import '../../config/data/network/network_services_api.dart';
import '../../model/investmentPlan/all_investment_plan_model.dart';

class AllInvestmentHttpRepository implements AllInvestmentPlanRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<AllInvestmentPlanModel> fetchInvestmentPlans() async {
    final response = await _apiServices.getApi(ApiUrls.allPlansApi);
    return AllInvestmentPlanModel.fromJson(response);
  }
}
