import 'package:digifarmer/repository/LANDOWNERPANEL/saveBasicInfo/save_basic_info_repository.dart';

import '../../../model/LANDOWNERSPANEL/saveBasicInfo/save_basic_info_model.dart';

class SaveBasicInfoMockRepository implements SaveBasicInfoRepository {
  @override
  Future<SaveBasicInfoModel> saveBasicInfoApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));

    final response = {
      'success': "true",
      'uniqueKey': 'UK_1771664872141_4e5af13c',
    };
    return SaveBasicInfoModel.fromJson(response);
  }
}
