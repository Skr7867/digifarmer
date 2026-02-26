import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:digifarmer/repository/invesmentPlan/all_investment_plan_repository.dart';
import '../../config/data/response/api_response.dart';
import '../../model/investmentPlan/all_investment_plan_model.dart';

part 'all_investment_plan_event.dart';
part 'all_investment_plan_state.dart';

class AllInvestmentPlanBloc
    extends Bloc<AllInvestmentPlanEvent, AllInvestmentSplanState> {
  final AllInvestmentPlanRepository allInvestmentPlanRepository;

  AllInvestmentPlanBloc({required this.allInvestmentPlanRepository})
    : super(AllInvestmentSplanState(allInvestmentPlan: ApiResponse.loading())) {
    on<PlanFetched>(_fetchAllPlansApi);
  }

  Future<void> _fetchAllPlansApi(
    PlanFetched event,
    Emitter<AllInvestmentSplanState> emit,
  ) async {
    emit(state.copyWith(allInvestmentPlan: ApiResponse.loading()));

    try {
      final response = await allInvestmentPlanRepository.fetchInvestmentPlans();

      emit(state.copyWith(allInvestmentPlan: ApiResponse.completed(response)));
    } catch (error) {
      emit(
        state.copyWith(allInvestmentPlan: ApiResponse.error(error.toString())),
      );
    }
  }
}
