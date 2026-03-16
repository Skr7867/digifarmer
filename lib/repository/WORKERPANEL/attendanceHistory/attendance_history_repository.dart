import '../../../model/WORKERPANEL/attendanceHistory/attendence_history_model.dart';

abstract class AttendanceHistoryRepository {
  Future<AttendanceHistoryModel> getAttendanceHistory({
    int page = 1,
    int limit = 30,
  });
}
