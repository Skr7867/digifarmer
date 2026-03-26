import '../../../model/LANDOWNERSPANEL/landOwnerTimeLine/land_owner_timeline_model.dart';

abstract class LandStatusRepository {
  Future<LandOwnerTimelineModel> fetchLandStatus();
}
