part of 'worker_dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({required this.workerDashboard});

  final ApiResponse<WorkerDashBoardModel> workerDashboard;

  DashboardState copyWith({
    ApiResponse<WorkerDashBoardModel>? workerDashboard,
  }) {
    return DashboardState(
      workerDashboard: workerDashboard ?? this.workerDashboard,
    );
  }

  @override
  List<Object?> get props => [workerDashboard];
}
