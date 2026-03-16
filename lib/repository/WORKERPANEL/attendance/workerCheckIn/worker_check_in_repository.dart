import 'package:digifarmer/model/WORKERPANEL/markAttendance/worker_check_in_model.dart';

abstract class WorkerCheckInRepository {
  Future<WorkerCheckInModel> checkInApi(dynamic data);
}
