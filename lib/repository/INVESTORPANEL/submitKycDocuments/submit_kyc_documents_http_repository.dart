import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/INVESTORPANEL/submitKycDocuments/submit_kyc_documents_model.dart';
import 'package:digifarmer/repository/INVESTORPANEL/submitKycDocuments/submit_kyc_documents_repository.dart';

class SubmitKycDocumentsHttpRepository implements SubmitKycDocumentsRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<SubmitKycDocumentsModel> submitKycDocumentsApi() async {
    final response = await _apiServices.postApi(
      {},
      ApiUrls.submitKycDocumentsApi,
    );
    return SubmitKycDocumentsModel.fromJson(response);
  }
}
