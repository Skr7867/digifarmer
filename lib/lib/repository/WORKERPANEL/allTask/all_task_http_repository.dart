import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/WORKERPANEL/alltask/all_task_model.dart';
import 'all_task_repository.dart';

class AllTaskHttpRepository implements AllTaskRepository {
  final _apiServices = NetworkApiServices();
  @override
  Future<AllTaskModel> fetchAllTask() async {
    final response = await _apiServices.getApi(ApiUrls.workerAllTaskApi);
    return AllTaskModel.fromJson(response);
  }
}
