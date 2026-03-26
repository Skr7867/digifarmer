import '../../../../config/apiUrls/api_urls.dart';
import '../../../../config/data/network/network_services_api.dart';
import '../../../../model/WORKERPANEL/markAttendance/worker_check_in_model.dart';
import 'worker_check_in_repository.dart';

class WorkerCheckInHttpRepository implements WorkerCheckInRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<WorkerCheckInModel> checkInApi(dynamic data) async {
    final response = await _apiServices.postApi({}, ApiUrls.workerCheckInApi);
    return WorkerCheckInModel.fromJson(response);
  }
}
