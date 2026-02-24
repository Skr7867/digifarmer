import 'package:digifarmer/model/verifyOtp/verify_otp_model.dart';

abstract class VerifyOtpRepository {
  Future<VerifyOtpModel> verifyOtpApi(dynamic data);
}
