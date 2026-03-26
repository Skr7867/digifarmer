part of 'attendance_bloc.dart';

abstract class WorkerAttendanceState extends Equatable {
  const WorkerAttendanceState();

  @override
  List<Object?> get props => [];
}

class WorkerAttendanceInitial extends WorkerAttendanceState {}

// ─── Check In States ───────────────────────────────────────────────
class WorkerCheckInLoading extends WorkerAttendanceState {}

class WorkerCheckInSuccess extends WorkerAttendanceState {
  final WorkerCheckInModel checkInModel;

  const WorkerCheckInSuccess({required this.checkInModel});

  @override
  List<Object?> get props => [checkInModel];
}

class WorkerCheckInFailure extends WorkerAttendanceState {
  final String errorMessage;

  const WorkerCheckInFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// ─── Check Out States ──────────────────────────────────────────────
class WorkerCheckOutLoading extends WorkerAttendanceState {}

class WorkerCheckOutSuccess extends WorkerAttendanceState {
  final WorkerCheckOutModel checkOutModel;

  const WorkerCheckOutSuccess({required this.checkOutModel});

  @override
  List<Object?> get props => [checkOutModel];
}

class WorkerCheckOutFailure extends WorkerAttendanceState {
  final String errorMessage;

  const WorkerCheckOutFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
