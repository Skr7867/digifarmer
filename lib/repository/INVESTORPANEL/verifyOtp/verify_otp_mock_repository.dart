import '../../../model/INVESTORPANEL/verifyOtp/verify_otp_model.dart';
import 'verify_otp_repository.dart';

class VerifyOtpMockRepository implements VerifyOtpRepository {
  @override
  Future<VerifyOtpModel> verifyOtpApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));

    final response = {
      'success': "true",
      'uniqueKey': 'UK_1771664872141_4e5af13c',
    };
    return VerifyOtpModel.fromJson(response);
  }
}
