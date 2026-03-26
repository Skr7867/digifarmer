import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/LANDOWNERSPANEL/landOwnerTimeLine/land_owner_timeline_model.dart';
import 'land_status_repository.dart';

class LandStatusHttpRepository implements LandStatusRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<LandOwnerTimelineModel> fetchLandStatus() async {
    final response = await _apiServices.getApi(ApiUrls.landStatusApi);
    return LandOwnerTimelineModel.fromJson(response);
  }
}
