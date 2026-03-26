import '../../../model/INVESTORPANEL/updateProfile/update_profile_model.dart';

abstract class UpdateProfileRepository {
  Future<UpdateProfileModel> updateProfileApi(dynamic data);
}
