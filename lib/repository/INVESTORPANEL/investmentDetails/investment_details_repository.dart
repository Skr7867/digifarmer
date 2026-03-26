
import '../../../model/INVESTORPANEL/investmentDetails/investment_details_model.dart';
abstract class InvestmentDetailsRepository {
  Future<InvestmentDetailsModel> fetchInvestmentDetails(String planId);
}
