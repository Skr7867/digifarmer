import 'package:digifarmer/model/register/create_account_send_otp_model.dart';
import 'package:digifarmer/repository/register/user_register_repository.dart';

class UserRegisterMockApiRepository implements UserRegisterRepository {
  @override
  Future<OtpResponseModel> userRegisterApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));

    final response = {
      'success': "true",
      'uniqueKey': 'UK_1771664872141_4e5af13c',
    };
    return OtpResponseModel.fromJson(response);
  }
}
