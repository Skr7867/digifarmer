part of 'investment_details_bloc.dart';

class InvestmentDetailsState extends Equatable {
  const InvestmentDetailsState({
    required this.investmentDetails,
  });

  final ApiResponse<InvestmentDetailsModel> investmentDetails;

  InvestmentDetailsState copyWith({
    ApiResponse<InvestmentDetailsModel>? investmentDetails,
  }) {
    return InvestmentDetailsState(
      investmentDetails: investmentDetails ?? this.investmentDetails,
    );
  }

  @override
  List<Object?> get props => [investmentDetails];
}