import 'package:digifarmer/model/WORKERPANEL/dashboard/worker_dashboard_model.dart';
import 'package:digifarmer/repository/WORKERPANEL/workerdashboard/worker_dashboard_repository.dart';

import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';

class WorkerDashboardHttpRepository implements WorkerDashboardRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<WorkerDashboardModel> fetchWorkerDashboardData() async {
    final response = await _apiServices.getApi(ApiUrls.workerDashBoardDataApi);
    return WorkerDashboardModel.fromJson(response);
  }
}
