import '../../model/loginOtpVerify/login_verify_otp_response_model.dart';

abstract class LoginOtpVerifyRepository {
  Future<LoginVerifyOtpResponse> verifyLoginOtpApi(dynamic data);
}
