part of 'start_task_bloc.dart';

class StartTaskState extends Equatable {
  final ApiResponse<StartTaskModel> startTaskResponse;

  const StartTaskState({required this.startTaskResponse});

  StartTaskState copyWith({ApiResponse<StartTaskModel>? startTaskResponse}) {
    return StartTaskState(
      startTaskResponse: startTaskResponse ?? this.startTaskResponse,
    );
  }

  @override
  List<Object?> get props => [startTaskResponse];
}
