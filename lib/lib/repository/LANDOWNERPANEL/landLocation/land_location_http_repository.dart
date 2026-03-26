import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/LANDOWNERSPANEL/landLocation/land_location_model.dart';
import 'land_location_repository.dart';

class LandLocationHttpRepository implements LandLocationRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<LandLocationModel> landLocationApi(dynamic data) async {
    final response = await _apiServices.putApi(data, ApiUrls.landLocationApi);
    return LandLocationModel.fromJson(response);
  }
}
