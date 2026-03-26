import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/WORKERPANEL/taskDetails/task_details_model.dart';
import '../../../repository/WORKERPANEL/taskDetails/task_details_repository.dart';

part 'task_details_event.dart';
part 'task_details_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  final TaskDetailsRepository taskDetailsRepository;

  TaskDetailsBloc({required this.taskDetailsRepository})
    : super(TaskDetailsState(taskDetails: ApiResponse.loading())) {
    on<TaskDetailsFetched>(_fetchTaskDetailsApi);
  }

  Future<void> _fetchTaskDetailsApi(
    TaskDetailsFetched event,
    Emitter<TaskDetailsState> emit,
  ) async {
    emit(state.copyWith(taskDetails: ApiResponse.loading()));

    try {
      final response = await taskDetailsRepository.fetchTaskDetailsApi(
        event.taskId,
      );

      emit(state.copyWith(taskDetails: ApiResponse.completed(response)));
    } catch (error) {
      emit(state.copyWith(taskDetails: ApiResponse.error(error.toString())));
    }
  }
}
