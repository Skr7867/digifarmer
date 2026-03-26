import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/INVESTORPANEL/investmentDetails/investment_details_model.dart';
import '../../../repository/INVESTORPANEL/investmentDetails/investment_details_repository.dart';

part 'investment_details_event.dart';
part 'investment_details_state.dart';

class InvestmentDetailsBloc
    extends Bloc<InvestmentDetailsEvent, InvestmentDetailsState> {
  final InvestmentDetailsRepository investmentDetailsRepository;

  InvestmentDetailsBloc({required this.investmentDetailsRepository})
      : super(InvestmentDetailsState(
          investmentDetails: ApiResponse.loading(),
        )) {
    on<InvestmentDetailsFetched>(_fetchInvestmentDetailsApi);
  }

  Future<void> _fetchInvestmentDetailsApi(
    InvestmentDetailsFetched event,
    Emitter<InvestmentDetailsState> emit,
  ) async {
    emit(state.copyWith(investmentDetails: ApiResponse.loading()));

    try {
      final response = await investmentDetailsRepository.fetchInvestmentDetails(
        event.planId,
      );

      emit(state.copyWith(investmentDetails: ApiResponse.completed(response)));
    } catch (error) {
      emit(state.copyWith(
        investmentDetails: ApiResponse.error(error.toString()),
      ));
    }
  }
}