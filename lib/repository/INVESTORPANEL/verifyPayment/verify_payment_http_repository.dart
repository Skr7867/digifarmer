import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/INVESTORPANEL/verifyPayment/verify_payment_model.dart';
import 'package:digifarmer/repository/INVESTORPANEL/verifyPayment/verify_payment_repository.dart';

class VerifyPaymentHttpRepository implements VerifyPaymentRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<VerifyPaymentModel> verifyPaymentApi(dynamic data) async {
    final response = await _apiServices.postApi(
      data,
      ApiUrls.verifyPayment,
    );
    return VerifyPaymentModel.fromJson(response);
  }
}