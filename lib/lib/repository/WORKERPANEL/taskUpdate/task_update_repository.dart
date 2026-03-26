import '../../../model/WORKERPANEL/taskUpdate/task_update_model.dart';

abstract class TaskUpdateRepository {
  Future<TaskUpdateModel> taskUpdateApi(dynamic data, String taskId);
}
