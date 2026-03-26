import 'package:digifarmer/model/INVESTORPANEL/createPayment/create_payment_model.dart';
import 'package:digifarmer/repository/INVESTORPANEL/createPayment/create_payment_repository.dart';

import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';

class CreatePaymentHttpRepository implements CreatePaymentRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<CreatePaymentModel> createPaymentApi(String investmentId) async {
    final url = ApiUrls.createPayment(investmentId);
    final response = await _apiServices.postApi({}, url);

    return CreatePaymentModel.fromJson(response);
  }
}
