part of 'active_investment_bloc.dart';

abstract class ActiveInvestmentEvent extends Equatable {
  const ActiveInvestmentEvent();

  @override
  List<Object> get props => [];
}

class ActiveInvestmentFetched extends ActiveInvestmentEvent {}
