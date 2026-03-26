import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/WORKERPANEL/dashboard/worker_dashboard_model.dart';
import 'worker_dashboard_repository.dart';

class WorkerDashboardHttpRepository implements WorkerDashboardRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<WorkerDashBoardModel> fetchWorkerDashboardData() async {
    final response = await _apiServices.getApi(ApiUrls.workerDashBoardDataApi);
    return WorkerDashBoardModel.fromJson(response);
  }
}
