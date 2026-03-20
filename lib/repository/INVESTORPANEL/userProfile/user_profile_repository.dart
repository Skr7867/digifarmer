import 'package:digifarmer/model/INVESTORPANEL/userProfile/user_profile_model.dart';

abstract class UserProfileRepository {
  Future<UserProfileModel> fetchUserProfile();
}
