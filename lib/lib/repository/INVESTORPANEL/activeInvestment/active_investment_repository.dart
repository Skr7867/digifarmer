import '../../../model/INVESTORPANEL/activeInvestment/active_investment_model.dart';

abstract class ActiveInvestmentRepository {
  Future<ActiveInvestmentModel> fetchInvestmentApi();
}
