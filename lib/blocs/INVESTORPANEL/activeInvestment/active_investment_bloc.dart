import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/INVESTORPANEL/activeInvestment/active_investment_model.dart';
import '../../../repository/INVESTORPANEL/activeInvestment/active_investment_repository.dart';

part 'active_investment_event.dart';
part 'active_investment_state.dart';

class ActiveInvestmentBloc
    extends Bloc<ActiveInvestmentEvent, ActiveInvestmentState> {
  final ActiveInvestmentRepository activeInvestmentRepository;

  ActiveInvestmentBloc({required this.activeInvestmentRepository})
    : super(ActiveInvestmentState(activeInvestment: ApiResponse.loading())) {
    on<ActiveInvestmentFetched>(_fetchActiveInvestmentApi);
  }

  Future<void> _fetchActiveInvestmentApi(
    ActiveInvestmentFetched event,
    Emitter<ActiveInvestmentState> emit,
  ) async {
    emit(state.copyWith(activeInvestment: ApiResponse.loading()));

    try {
      final response = await activeInvestmentRepository.fetchInvestmentApi();

      emit(state.copyWith(activeInvestment: ApiResponse.completed(response)));
    } catch (error, stacktrace) {
      log(error.toString());
      log('stackTrace:$stacktrace ');
      emit(
        state.copyWith(activeInvestment: ApiResponse.error(error.toString())),
      );
    }
  }
}
