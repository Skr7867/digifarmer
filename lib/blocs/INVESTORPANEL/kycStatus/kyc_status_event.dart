part of 'kyc_status_bloc.dart';

abstract class KycStatusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class KycStatusFetched extends KycStatusEvent {}