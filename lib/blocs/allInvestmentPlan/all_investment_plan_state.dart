part of 'all_investment_plan_bloc.dart';

class AllInvestmentSplanState extends Equatable {
  const AllInvestmentSplanState({required this.allInvestmentPlan});

  final ApiResponse<AllInvestmentPlanModel> allInvestmentPlan;

  AllInvestmentSplanState copyWith({
    ApiResponse<AllInvestmentPlanModel>? allInvestmentPlan,
  }) {
    return AllInvestmentSplanState(
      allInvestmentPlan: allInvestmentPlan ?? this.allInvestmentPlan,
    );
  }

  @override
  List<Object?> get props => [allInvestmentPlan];
}
