import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/userLogin/login_response_model.dart';
import 'package:digifarmer/repository/userLogin/user_login_repository.dart';

class UserLoginHttpRepository implements UserLoginRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<LoginResponseModel> userLoginApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.loginSendOtp);
    return LoginResponseModel.fromJson(response);
  }
}
