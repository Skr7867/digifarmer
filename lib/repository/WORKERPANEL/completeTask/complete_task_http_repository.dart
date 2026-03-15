import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/WORKERPANEL/completeTask/complete_task_model.dart';
import 'package:digifarmer/repository/WORKERPANEL/completeTask/complete_task_repository.dart';

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
