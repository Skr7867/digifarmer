import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:digifarmer/model/WORKERPANEL/markAttendance/worker_check_in_model.dart';
import 'package:digifarmer/model/WORKERPANEL/markAttendance/worker_check_out_model.dart';
import 'package:digifarmer/repository/WORKERPANEL/attendance/workerCheckIn/worker_check_in_http_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/attendance/workerCheckOut/worker_check_out_http_repository.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class WorkerAttendanceBloc
    extends Bloc<WorkerAttendanceEvent, WorkerAttendanceState> {
  final WorkerCheckInHttpRepository _checkInRepository;
  final WorkerCheckOutHttpRepository _checkOutRepository;

  WorkerAttendanceBloc({
    required WorkerCheckInHttpRepository checkInRepository,
    required WorkerCheckOutHttpRepository checkOutRepository,
  }) : _checkInRepository = checkInRepository,
       _checkOutRepository = checkOutRepository,
       super(WorkerAttendanceInitial()) {
    on<WorkerCheckInEvent>(_onCheckIn);
    on<WorkerCheckOutEvent>(_onCheckOut);
  }

  // ─── Check In Handler ────────────────────────────────────────────
  Future<void> _onCheckIn(
    WorkerCheckInEvent event,
    Emitter<WorkerAttendanceState> emit,
  ) async {
    emit(WorkerCheckInLoading());
    try {
      final data = {'latitude': event.latitude, 'longitude': event.longitude};
      final result = await _checkInRepository.checkInApi(data);

      if (result.success == true) {
        emit(WorkerCheckInSuccess(checkInModel: result));
      } else {
        emit(
          WorkerCheckInFailure(
            errorMessage:
                result.message ?? 'Check-in failed. Please try again.',
          ),
        );
      }
    } catch (e) {
      emit(WorkerCheckInFailure(errorMessage: e.toString()));
    }
  }

  // ─── Check Out Handler ───────────────────────────────────────────
  Future<void> _onCheckOut(
    WorkerCheckOutEvent event,
    Emitter<WorkerAttendanceState> emit,
  ) async {
    emit(WorkerCheckOutLoading());
    try {
      final data = {'latitude': event.latitude, 'longitude': event.longitude};
      final result = await _checkOutRepository.checkOutApi(data);

      if (result.success == true) {
        emit(WorkerCheckOutSuccess(checkOutModel: result));
      } else {
        emit(
          WorkerCheckOutFailure(
            errorMessage:
                result.message ?? 'Check-out failed. Please try again.',
          ),
        );
      }
    } catch (e) {
      emit(WorkerCheckOutFailure(errorMessage: e.toString()));
    }
  }
}
