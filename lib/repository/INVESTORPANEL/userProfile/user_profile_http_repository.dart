import 'package:digifarmer/model/INVESTORPANEL/userProfile/user_profile_model.dart';
import 'package:digifarmer/repository/INVESTORPANEL/userProfile/user_profile_repository.dart';

import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';

class UserProfileHttpRepository implements UserProfileRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<UserProfileModel> fetchUserProfile() async {
    final response = await _apiServices.getApi(ApiUrls.userProfileApi);
    return UserProfileModel.fromJson(response);
  }
}
