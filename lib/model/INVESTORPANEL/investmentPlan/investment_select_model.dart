import 'all_investment_plan_model.dart';

class InvestmentSelectionModel {
  final InvestmentPlanModel plan;
  final int amount;
  final double expectedReturn;
  final double maturityAmount;

  InvestmentSelectionModel({
    required this.plan,
    required this.amount,
    required this.expectedReturn,
    required this.maturityAmount,
  });
}
