import '../../../model/INVESTORPANEL/createPayment/create_payment_model.dart';

abstract class CreatePaymentRepository {
  Future<CreatePaymentModel> createPaymentApi(String planId);
}
