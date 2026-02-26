part of 'all_investment_plan_bloc.dart';

abstract class AllInvestmentPlanEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlanFetched extends AllInvestmentPlanEvent {}
