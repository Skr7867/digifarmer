import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import '../../../model/INVESTORPANEL/resendOtp/resend_otp_model.dart';
import 'resend_otp_repository.dart';


class ResendOtpHttpRepository implements ResendOtpRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<ResendOtpModel> resendOtpApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.resendOtp);
    return ResendOtpModel.fromJson(response);
  }
}
