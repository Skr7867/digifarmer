import '../../../model/WORKERPANEL/taskDetails/task_details_model.dart';

abstract class TaskDetailsRepository {
  Future<TaskDetailModel> fetchTaskDetailsApi(String taskId);
}
