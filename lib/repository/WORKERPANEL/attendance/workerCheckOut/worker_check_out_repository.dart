import 'package:digifarmer/model/WORKERPANEL/markAttendance/worker_check_out_model.dart';

abstract class WorkerCheckOutRepository {
  Future<WorkerCheckOutModel> checkOutApi(dynamic data);
}
