import '../../model/loginOtpVerify/login_verify_otp_response_model.dart';
import 'login_otp_verify_repository.dart';

class LoginOtpVerifyMockRepository implements LoginOtpVerifyRepository {
  @override
  Future<LoginVerifyOtpResponse> verifyLoginOtpApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));

    final response = {
      'success': "true",
      'uniqueKey': 'UK_1771664872141_4e5af13c',
    };
    return LoginVerifyOtpResponse.fromJson(response);
  }
}
