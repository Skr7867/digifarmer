import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/INVESTORPANEL/loginOtpVerify/login_verify_otp_response_model.dart';
import 'login_otp_verify_repository.dart';

class LoginOtpVerifyHttpRepository implements LoginOtpVerifyRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<LoginVerifyOtpResponse> verifyLoginOtpApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.loginVerifyOtp);
    return LoginVerifyOtpResponse.fromJson(response);
  }
}
