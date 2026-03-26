import 'package:digifarmer/model/INVESTORPANEL/verifyPayment/verify_payment_model.dart';

abstract class VerifyPaymentRepository {
  Future<VerifyPaymentModel> verifyPaymentApi(dynamic data);
}