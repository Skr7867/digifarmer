import '../../../model/WORKERPANEL/startTask/start_task_model.dart';

abstract class StartTaskRepository {
  Future<StartTaskModel> startTask(String taskId);
}
