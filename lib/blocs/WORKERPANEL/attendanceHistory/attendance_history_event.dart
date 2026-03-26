part of 'attendance_history_bloc.dart';

abstract class AttendanceHistoryEvent extends Equatable {
  const AttendanceHistoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchAttendanceHistoryEvent extends AttendanceHistoryEvent {
  final int page;
  final int limit;

  const FetchAttendanceHistoryEvent({this.page = 1, this.limit = 30});

  @override
  List<Object?> get props => [page, limit];
}
