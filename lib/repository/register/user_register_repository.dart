import '../../model/register/create_account_send_otp_model.dart';

abstract class UserRegisterRepository {
  Future<OtpResponseModel> userRegisterApi(dynamic data);
}
