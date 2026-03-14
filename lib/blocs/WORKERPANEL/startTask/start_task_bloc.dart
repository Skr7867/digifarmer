import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/WORKERPANEL/startTask/start_task_model.dart';
import '../../../repository/WORKERPANEL/startTask/start_task_repository.dart';

part 'start_task_event.dart';
part 'start_task_state.dart';

class StartTaskBloc extends Bloc<StartTaskEvent, StartTaskState> {
  final StartTaskRepository repository;

  StartTaskBloc({required this.repository})
    : super(StartTaskState(startTaskResponse: ApiResponse.loading())) {
    on<StartTaskPressed>(_startTaskApi);
  }

  Future<void> _startTaskApi(
    StartTaskPressed event,
    Emitter<StartTaskState> emit,
  ) async {
    emit(state.copyWith(startTaskResponse: ApiResponse.loading()));

    try {
      final response = await repository.startTask(event.taskId);

      emit(state.copyWith(startTaskResponse: ApiResponse.completed(response)));
    } catch (e) {
      emit(state.copyWith(startTaskResponse: ApiResponse.error(e.toString())));
    }
  }
}
