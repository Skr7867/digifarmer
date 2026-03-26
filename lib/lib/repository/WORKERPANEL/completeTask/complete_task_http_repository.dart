import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/WORKERPANEL/completeTask/complete_task_model.dart';
import 'complete_task_repository.dart';

class CompleteTaskHttpRepository implements CompleteTaskRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<CompleteTaskModel> completetaskApi(dynamic data, String taskId) async {
    final response = await _apiServices.putApi(
      data,
      ApiUrls.taskCompleteApi(taskId),
    );
    return CompleteTaskModel.fromJson(response);
  }
}
