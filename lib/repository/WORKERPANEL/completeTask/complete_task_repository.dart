import 'package:digifarmer/model/WORKERPANEL/completeTask/complete_task_model.dart';

abstract class CompleteTaskRepository {
  Future<CompleteTaskModel> completetaskApi(dynamic data, String taskId);
}
