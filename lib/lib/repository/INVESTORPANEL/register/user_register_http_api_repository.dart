import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/INVESTORPANEL/register/create_account_send_otp_model.dart';
import 'user_register_repository.dart';

class UserRegisterHttpApiRepository implements UserRegisterRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<OtpResponseModel> userRegisterApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.userRegisterApi);
    return OtpResponseModel.fromJson(response);
  }
}
