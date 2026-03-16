part of 'attendance_bloc.dart';

abstract class WorkerAttendanceEvent extends Equatable {
  const WorkerAttendanceEvent();

  @override
  List<Object?> get props => [];
}

class WorkerCheckInEvent extends WorkerAttendanceEvent {
  final double latitude;
  final double longitude;

  const WorkerCheckInEvent({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}

class WorkerCheckOutEvent extends WorkerAttendanceEvent {
  final double latitude;
  final double longitude;

  const WorkerCheckOutEvent({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
