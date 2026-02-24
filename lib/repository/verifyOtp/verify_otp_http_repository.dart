import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/verifyOtp/verify_otp_model.dart';
import 'package:digifarmer/repository/verifyOtp/verify_otp_repository.dart';

class VerifyOtpHttpRepository implements VerifyOtpRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<VerifyOtpModel> verifyOtpApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.verifyOtpApi);
    return VerifyOtpModel.fromJson(response);
  }
}
