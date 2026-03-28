import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/INVESTORPANEL/bankDetails/bank_details_model.dart';
import 'package:digifarmer/repository/INVESTORPANEL/submitBankDetails/submit_bank_details_repository.dart';

class SubmitBankDetailsHttpRepository implements SubmitBankDetailsRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<BankDetailsModel> submitBankDetailsApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.submitBankDetailsApi);
    return BankDetailsModel.fromJson(response);
  }
}
