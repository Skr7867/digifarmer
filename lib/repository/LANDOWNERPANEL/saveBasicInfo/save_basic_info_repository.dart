import '../../../model/LANDOWNERSPANEL/saveBasicInfo/save_basic_info_model.dart';

abstract class SaveBasicInfoRepository {
  Future<SaveBasicInfoModel> saveBasicInfoApi(dynamic data);
}
