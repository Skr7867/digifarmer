import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/WORKERPANEL/dashboard/worker_dashboard_model.dart';
import '../../../repository/WORKERPANEL/workerdashboard/worker_dashboard_repository.dart';

part 'worker_dashboard_event.dart';
part 'worker_dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final WorkerDashboardRepository workerDashboardRepository;

  DashboardBloc({required this.workerDashboardRepository})
    : super(DashboardState(workerDashboard: ApiResponse.loading())) {
    on<DashboardFetched>(_fetchDashboardApi);
  }

  Future<void> _fetchDashboardApi(
    DashboardFetched event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(workerDashboard: ApiResponse.loading()));

    try {
      final response = await workerDashboardRepository
          .fetchWorkerDashboardData();

      emit(state.copyWith(workerDashboard: ApiResponse.completed(response)));
    } catch (error) {
      emit(
        state.copyWith(workerDashboard: ApiResponse.error(error.toString())),
      );
    }
  }
}
