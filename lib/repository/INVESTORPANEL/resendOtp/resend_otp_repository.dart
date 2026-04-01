import '../../../model/INVESTORPANEL/resendOtp/resend_otp_model.dart';

abstract class ResendOtpRepository {
  Future<ResendOtpModel> resendOtpApi(dynamic data);
}
