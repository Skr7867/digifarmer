import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/repository/loginOtpVerify/login_otp_verify_repository.dart';

import '../../model/loginOtpVerify/login_verify_otp_response_model.dart';

class LoginOtpVerifyHttpRepository implements LoginOtpVerifyRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<LoginVerifyOtpResponse> verifyLoginOtpApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.loginVerifyOtp);
    return LoginVerifyOtpResponse.fromJson(response);
  }
}
