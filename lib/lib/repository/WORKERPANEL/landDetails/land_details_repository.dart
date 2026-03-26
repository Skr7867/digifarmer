import '../../../model/WORKERPANEL/landDetails/land_details_model.dart';

abstract class LandDetailsRepository {
  Future<LandDetailsModel> fetchLandDetailsApi(String taskId);
}
