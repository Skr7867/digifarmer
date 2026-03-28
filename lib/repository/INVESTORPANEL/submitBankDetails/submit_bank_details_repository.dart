import 'package:digifarmer/model/INVESTORPANEL/bankDetails/bank_details_model.dart';

abstract class SubmitBankDetailsRepository {
  Future<BankDetailsModel> submitBankDetailsApi(dynamic data);
}
