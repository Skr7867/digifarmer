import 'package:digifarmer/model/INVESTORPANEL/kycStatus/kyc_status_model.dart';
import 'package:digifarmer/repository/INVESTORPANEL/kycStatus/kyc_status_repository.dart';

import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';

class KycStatusHttpRepository implements KycStatusRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<KycStatusModel> fetchKycStatus() async {
    final response = await _apiServices.getApi(ApiUrls.kycStatusApi);
    return KycStatusModel.fromJson(response);
  }
}
