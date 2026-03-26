part of 'land_details_bloc.dart';

abstract class LandDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LandDetailsFetched extends LandDetailsEvent {
  final String taskId;

  LandDetailsFetched(this.taskId);

  @override
  List<Object> get props => [taskId];
}
