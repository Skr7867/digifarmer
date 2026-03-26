part of 'task_details_bloc.dart';

abstract class TaskDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskDetailsFetched extends TaskDetailsEvent {
  final String taskId;

  TaskDetailsFetched(this.taskId);

  @override
  List<Object> get props => [taskId];
}
