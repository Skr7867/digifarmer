import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/LANDOWNERSPANEL/saveBasicInfo/save_basic_info_model.dart';
import 'save_basic_info_repository.dart';

class SaveBasicInfoHttpRepository implements SaveBasicInfoRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<SaveBasicInfoModel> saveBasicInfoApi(dynamic data) async {
    final response = await _apiServices.postApi(
      data,
      ApiUrls.landOwnerSaveBasicInfoApi,
    );
    return SaveBasicInfoModel.fromJson(response);
  }
}
