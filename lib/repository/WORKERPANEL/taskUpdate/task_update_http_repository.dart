import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/WORKERPANEL/taskUpdate/task_update_model.dart';
import 'package:digifarmer/repository/WORKERPANEL/taskUpdate/task_update_repository.dart';

class TaskUpdateHttpRepository implements TaskUpdateRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<TaskUpdateModel> taskUpdateApi(dynamic data, String taskId) async {
    final response = await _apiServices.postApi(
      data,
      ApiUrls.taskUpdateApi(taskId),
    );
    return TaskUpdateModel.fromJson(response);
  }
}
