import 'package:digifarmer/model/INVESTORPANEL/planPurchase/plan_purchased_model.dart';
import 'package:digifarmer/repository/INVESTORPANEL/planPurchased/plan_purchased_repository.dart';

class PlanPurchasedMockRepository implements PlanPurchasedRepository {
  @override
  Future<PlanPurchasedModel> planPurchasedApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));

    final response = {
      'success': "true",
      'uniqueKey': 'UK_1771664872141_4e5af13c',
    };
    return PlanPurchasedModel.fromJson(response);
  }
}
