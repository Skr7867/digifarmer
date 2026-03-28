import 'package:digifarmer/model/INVESTORPANEL/kycStatus/kyc_status_model.dart';
abstract class KycStatusRepository {
  Future<KycStatusModel> fetchKycStatus();
}
