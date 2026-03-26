import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/WORKERPANEL/landDetails/land_details_model.dart';
import 'land_details_repository.dart';

class LandDetailsHttpRepository implements LandDetailsRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<LandDetailsModel> fetchLandDetailsApi(String taskId) async {
    final response = await _apiServices.getApi(ApiUrls.landDetailsApi(taskId));

    return LandDetailsModel.fromJson(response);
  }
}
