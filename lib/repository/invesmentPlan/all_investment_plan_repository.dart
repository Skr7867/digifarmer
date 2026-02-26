import '../../model/investmentPlan/all_investment_plan_model.dart';

abstract class AllInvestmentPlanRepository {
  Future<AllInvestmentPlanModel> fetchInvestmentPlans();
}
