part of 'active_investment_bloc.dart';

class ActiveInvestmentState extends Equatable {
  const ActiveInvestmentState({required this.activeInvestment});

  final ApiResponse<ActiveInvestmentModel> activeInvestment;

  ActiveInvestmentState copyWith({
    ApiResponse<ActiveInvestmentModel>? activeInvestment,
  }) {
    return ActiveInvestmentState(
      activeInvestment: activeInvestment ?? this.activeInvestment,
    );
  }

  @override
  List<Object?> get props => [activeInvestment];
}
