import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/INVESTORPANEL/createPayment/create_payment_model.dart';
import 'create_payment_repository.dart';

class CreatePaymentHttpRepository implements CreatePaymentRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<CreatePaymentModel> createPaymentApi(String investmentId) async {
    final url = ApiUrls.createPayment(investmentId);
    final response = await _apiServices.postApi({}, url);

    return CreatePaymentModel.fromJson(response);
  }
}
