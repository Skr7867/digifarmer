import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/INVESTORPANEL/updateProfile/update_profile_model.dart';
import 'update_profile_repository.dart';

class UpdateProfileHttpRepository implements UpdateProfileRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<UpdateProfileModel> updateProfileApi(dynamic data) async {
    final response = await _apiServices.putApi(data, ApiUrls.updateProfileApi);
    return UpdateProfileModel.fromJson(response);
  }
}
