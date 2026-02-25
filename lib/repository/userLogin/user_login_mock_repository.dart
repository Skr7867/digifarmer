import 'package:digifarmer/model/userLogin/login_response_model.dart';
import 'package:digifarmer/repository/userLogin/user_login_repository.dart';

class UserLoginMockRepository implements UserLoginRepository {
  @override
  Future<LoginResponseModel> userLoginApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));

    final response = {
      'success': "true",
      'uniqueKey': 'UK_1771664872141_4e5af13c',
    };
    return LoginResponseModel.fromJson(response);
  }
}
