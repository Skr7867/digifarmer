import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/WORKERPANEL/attendanceHistory/attendence_history_model.dart';
import '../../../repository/WORKERPANEL/attendanceHistory/attendance_history_repository.dart';

part 'attendance_history_event.dart';
part 'attendance_history_state.dart';

class AttendanceHistoryBloc
    extends Bloc<AttendanceHistoryEvent, AttendanceHistoryState> {
  final AttendanceHistoryRepository _repository;

  AttendanceHistoryBloc({required AttendanceHistoryRepository repository})
    : _repository = repository,
      super(AttendanceHistoryInitial()) {
    on<FetchAttendanceHistoryEvent>(_onFetch);
  }

  Future<void> _onFetch(
    FetchAttendanceHistoryEvent event,
    Emitter<AttendanceHistoryState> emit,
  ) async {
    emit(AttendanceHistoryLoading());
    try {
      final result = await _repository.getAttendanceHistory(
        page: event.page,
        limit: event.limit,
      );
      if (result.success == true) {
        emit(AttendanceHistorySuccess(historyModel: result));
      } else {
        emit(
          const AttendanceHistoryFailure(
            errorMessage: 'Failed to load attendance history.',
          ),
        );
      }
    } catch (e) {
      emit(AttendanceHistoryFailure(errorMessage: e.toString()));
    }
  }
}
