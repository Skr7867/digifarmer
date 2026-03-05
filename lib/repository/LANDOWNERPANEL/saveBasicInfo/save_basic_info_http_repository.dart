import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/repository/LANDOWNERPANEL/saveBasicInfo/save_basic_info_repository.dart';

import '../../../model/LANDOWNERSPANEL/saveBasicInfo/save_basic_info_model.dart';

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
