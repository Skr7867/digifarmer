part of 'all_task_bloc.dart';

abstract class AllTaskEvent extends Equatable {
  const AllTaskEvent();

  @override
  List<Object> get props => [];
}

class AllTaskFetched extends AllTaskEvent {}
