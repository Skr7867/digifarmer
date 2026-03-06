part of 'land_status_bloc.dart';

abstract class LandStatusEvent extends Equatable {
  const LandStatusEvent();

  @override
  List<Object> get props => [];
}

class LandStatusFetched extends LandStatusEvent {
  const LandStatusFetched();
}
