import 'package:bloc/bloc.dart';
import 'package:digifarmer/repository/INVESTORPANEL/planPurchased/plan_purchased_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/INVESTORPANEL/planPurchase/plan_purchased_model.dart';
import '../../../model/INVESTORPANEL/planPurchase/purchase_plan_request_model.dart';

part 'plan_purchase_event.dart';
part 'plan_purchase_state.dart';

class PurchasePlanBloc extends Bloc<PurchasePlanEvent, PurchasePlanState> {
  final PlanPurchasedRepository repository;

  PurchasePlanBloc({required this.repository})
    : super(PurchasePlanState(purchaseResponse: ApiResponse.loading())) {
    on<PurchasePlanSubmitted>(_purchasePlan);
  }

  Future<void> _purchasePlan(
    PurchasePlanSubmitted event,
    Emitter<PurchasePlanState> emit,
  ) async {
    emit(state.copyWith(purchaseResponse: ApiResponse.loading()));

    try {
      final response = await repository.planPurchasedApi(
        event.request.toJson(),
      );

      emit(state.copyWith(purchaseResponse: ApiResponse.completed(response)));
    } catch (e) {
      emit(state.copyWith(purchaseResponse: ApiResponse.error(e.toString())));
    }
  }
}
