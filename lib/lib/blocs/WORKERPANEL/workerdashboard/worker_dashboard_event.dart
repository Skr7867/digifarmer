part of 'worker_dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardFetched extends DashboardEvent {}
