part of 'task_details_bloc.dart';

class TaskDetailsState extends Equatable {
  const TaskDetailsState({required this.taskDetails});

  final ApiResponse<TaskDetailModel> taskDetails;

  TaskDetailsState copyWith({ApiResponse<TaskDetailModel>? taskDetails}) {
    return TaskDetailsState(taskDetails: taskDetails ?? this.taskDetails);
  }

  @override
  List<Object?> get props => [taskDetails];
}
