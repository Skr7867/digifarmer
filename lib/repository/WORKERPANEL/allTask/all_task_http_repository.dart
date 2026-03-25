import 'package:digifarmer/model/WORKERPANEL/alltask/all_task_model.dart';
import 'package:digifarmer/repository/WORKERPANEL/allTask/all_task_repository.dart';

import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';

class AllTaskHttpRepository implements AllTaskRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<AllTaskModel> fetchAllTask() async {
    final response = await _apiServices.getApi(ApiUrls.workerAllTaskApi);
    return AllTaskModel.fromJson(response);
  }
}
