import 'package:digifarmer/model/WORKERPANEL/dashboard/worker_dashboard_model.dart';

abstract class WorkerDashboardRepository {
  Future<WorkerDashBoardModel> fetchWorkerDashboardData();
}
