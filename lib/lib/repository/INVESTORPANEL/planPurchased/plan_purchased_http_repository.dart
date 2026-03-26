import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/INVESTORPANEL/planPurchase/plan_purchased_model.dart';
import 'plan_purchased_repository.dart';

class PlanPurchasedHttpRepository implements PlanPurchasedRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<PlanPurchasedModel> planPurchasedApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.planPurchasedApi);
    return PlanPurchasedModel.fromJson(response);
  }
}
