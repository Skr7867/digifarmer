import 'package:digifarmer/model/userLogin/login_response_model.dart';

abstract class UserLoginRepository {
  Future<LoginResponseModel> userLoginApi(dynamic data);
}
