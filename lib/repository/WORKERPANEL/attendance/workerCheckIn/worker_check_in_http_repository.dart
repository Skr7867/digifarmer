import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/WORKERPANEL/markAttendance/worker_check_in_model.dart';
import 'package:digifarmer/repository/WORKERPANEL/attendance/workerCheckIn/worker_check_in_repository.dart';

class WorkerCheckInHttpRepository implements WorkerCheckInRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<WorkerCheckInModel> checkInApi(dynamic data) async {
    final response = await _apiServices.postApi({}, ApiUrls.workerCheckInApi);
    return WorkerCheckInModel.fromJson(response);
  }
}
