import '../../../model/LANDOWNERSPANEL/landLocation/land_location_model.dart';

abstract class LandLocationRepository {
  Future<LandLocationModel> landLocationApi(dynamic data);
}
