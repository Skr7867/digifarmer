import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/LANDOWNERSPANEL/landLocation/land_location_model.dart';
import 'package:digifarmer/repository/LANDOWNERPANEL/landLocation/land_location_repository.dart';

class LandLocationHttpRepository implements LandLocationRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<LandLocationModel> landLocationApi(dynamic data) async {
    final response = await _apiServices.putApi(data, ApiUrls.landLocationApi);
    return LandLocationModel.fromJson(response);
  }
}
