import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/WORKERPANEL/markAttendance/worker_check_out_model.dart';
import 'package:digifarmer/repository/WORKERPANEL/attendance/workerCheckOut/worker_check_out_repository.dart';

class WorkerCheckOutHttpRepository implements WorkerCheckOutRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<WorkerCheckOutModel> checkOutApi(dynamic data) async {
    final response = await _apiServices.postApi({}, ApiUrls.workerCheckOutApi);
    return WorkerCheckOutModel.fromJson(response);
  }
}
