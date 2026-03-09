import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/INVESTORPANEL/planPurchase/plan_purchased_model.dart';
import 'package:digifarmer/repository/INVESTORPANEL/planPurchased/plan_purchased_repository.dart';

class PlanPurchasedHttpRepository implements PlanPurchasedRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<PlanPurchasedModel> planPurchasedApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.planPurchasedApi);
    return PlanPurchasedModel.fromJson(response);
  }
}
