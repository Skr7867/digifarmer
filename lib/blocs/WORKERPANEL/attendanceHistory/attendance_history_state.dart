part of 'attendance_history_bloc.dart';

abstract class AttendanceHistoryState extends Equatable {
  const AttendanceHistoryState();

  @override
  List<Object?> get props => [];
}

class AttendanceHistoryInitial extends AttendanceHistoryState {}

class AttendanceHistoryLoading extends AttendanceHistoryState {}

class AttendanceHistorySuccess extends AttendanceHistoryState {
  final AttendanceHistoryModel historyModel;

  const AttendanceHistorySuccess({required this.historyModel});

  @override
  List<Object?> get props => [historyModel];
}

class AttendanceHistoryFailure extends AttendanceHistoryState {
  final String errorMessage;

  const AttendanceHistoryFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
