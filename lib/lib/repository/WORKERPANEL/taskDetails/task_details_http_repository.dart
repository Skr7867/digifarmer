import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/WORKERPANEL/taskDetails/task_details_model.dart';
import 'task_details_repository.dart';

class TaskDetailsHttpRepository implements TaskDetailsRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<TaskDetailModel> fetchTaskDetailsApi(String taskId) async {
    final response = await _apiServices.getApi(ApiUrls.taskDetailsApi(taskId));

    return TaskDetailModel.fromJson(response);
  }
}
