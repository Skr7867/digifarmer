import '../../../model/INVESTORPANEL/userLogin/login_response_model.dart';

abstract class UserLoginRepository {
  Future<LoginResponseModel> userLoginApi(dynamic data);
}
