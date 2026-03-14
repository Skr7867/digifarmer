part of 'start_task_bloc.dart';

abstract class StartTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartTaskPressed extends StartTaskEvent {
  final String taskId;

  StartTaskPressed(this.taskId);

  @override
  List<Object> get props => [taskId];
}
