import '../../../model/LANDOWNERSPANEL/landLocation/land_location_model.dart';
import 'land_location_repository.dart';

class LandLocationMockRepository implements LandLocationRepository {
  @override
  Future<LandLocationModel> landLocationApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));

    final response = {
      'success': "true",
      'uniqueKey': 'UK_1771664872141_4e5af13c',
    };
    return LandLocationModel.fromJson(response);
  }
}
