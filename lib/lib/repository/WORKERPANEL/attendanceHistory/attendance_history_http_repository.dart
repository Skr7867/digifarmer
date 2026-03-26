import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/WORKERPANEL/attendanceHistory/attendence_history_model.dart';
import 'attendance_history_repository.dart';

class AttendanceHistoryHttpRepository implements AttendanceHistoryRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<AttendanceHistoryModel> getAttendanceHistory({
    int page = 1,
    int limit = 30,
  }) async {
    final response = await _apiServices.getApi(
      '${ApiUrls.workerAttendanceHistoryApi}?page=$page&limit=$limit',
    );
    return AttendanceHistoryModel.fromJson(response);
  }
}
