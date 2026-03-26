import '../../../model/INVESTORPANEL/planPurchase/plan_purchased_model.dart';

abstract class PlanPurchasedRepository {
  Future<PlanPurchasedModel> planPurchasedApi(dynamic data);
}
