import 'package:digifarmer/lib/repository/WORKERPANEL/taskUpdate/task_update_repository.dart';

import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/WORKERPANEL/taskUpdate/task_update_model.dart';

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
