import '../../../../config/apiUrls/api_urls.dart';
import '../../../../config/data/network/network_services_api.dart';
import '../../../../model/WORKERPANEL/markAttendance/worker_check_out_model.dart';
import 'worker_check_out_repository.dart';

class WorkerCheckOutHttpRepository implements WorkerCheckOutRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<WorkerCheckOutModel> checkOutApi(dynamic data) async {
    final response = await _apiServices.postApi({}, ApiUrls.workerCheckOutApi);
    return WorkerCheckOutModel.fromJson(response);
  }
}
