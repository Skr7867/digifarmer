part of 'all_task_bloc.dart';

class AllTaskState extends Equatable {
  const AllTaskState({required this.allTask});

  final ApiResponse<AllTaskModel> allTask;

  AllTaskState copyWith({ApiResponse<AllTaskModel>? allTask}) {
    return AllTaskState(allTask: allTask ?? this.allTask);
  }

  @override
  List<Object?> get props => [allTask];
}
