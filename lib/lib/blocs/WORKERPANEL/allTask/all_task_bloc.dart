import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../config/data/response/api_response.dart';
import '../../../model/WORKERPANEL/alltask/all_task_model.dart';
import '../../../repository/WORKERPANEL/allTask/all_task_repository.dart';

part 'all_task_event.dart';
part 'all_task_state.dart';

class AllTaskBloc extends Bloc<AllTaskEvent, AllTaskState> {
  final AllTaskRepository allTaskRepository;

  AllTaskBloc({required this.allTaskRepository})
    : super(AllTaskState(allTask: ApiResponse.loading())) {
    on<AllTaskFetched>(_fetchAllTaskApi);
  }

  Future<void> _fetchAllTaskApi(
    AllTaskFetched event,
    Emitter<AllTaskState> emit,
  ) async {
    emit(state.copyWith(allTask: ApiResponse.loading()));

    try {
      final response = await allTaskRepository.fetchAllTask();
      emit(state.copyWith(allTask: ApiResponse.completed(response)));
    } catch (error) {
      emit(state.copyWith(allTask: ApiResponse.error(error.toString())));
    }
  }
}
