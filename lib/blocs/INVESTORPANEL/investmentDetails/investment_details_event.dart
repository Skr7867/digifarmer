part of 'investment_details_bloc.dart';

abstract class InvestmentDetailsEvent extends Equatable {
  const InvestmentDetailsEvent();

  @override
  List<Object> get props => [];
}

class InvestmentDetailsFetched extends InvestmentDetailsEvent {
  final String planId;

  const InvestmentDetailsFetched({required this.planId});

  @override
  List<Object> get props => [planId];
}