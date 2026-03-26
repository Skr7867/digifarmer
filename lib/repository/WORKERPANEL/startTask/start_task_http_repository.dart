import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/WORKERPANEL/startTask/start_task_model.dart';
import 'start_task_repository.dart';

class StartTaskHttpRepository implements StartTaskRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<StartTaskModel> startTask(String taskId) async {
    final response = await _apiServices.putApi(
      {},
      ApiUrls.startTaskApi(taskId),
    );

    return StartTaskModel.fromJson(response);
  }
}
