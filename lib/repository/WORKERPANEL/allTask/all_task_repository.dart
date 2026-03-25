import '../../../model/WORKERPANEL/alltask/all_task_model.dart';

abstract class AllTaskRepository {
  Future<AllTaskModel> fetchAllTask();
}
