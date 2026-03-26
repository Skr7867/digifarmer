import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/INVESTORPANEL/verifyPayment/verify_payment_model.dart';
import 'verify_payment_repository.dart';

class VerifyPaymentHttpRepository implements VerifyPaymentRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<VerifyPaymentModel> verifyPaymentApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.verifyPayment);
    return VerifyPaymentModel.fromJson(response);
  }
}
