part of 'plan_purchase_bloc.dart';

class PurchasePlanState extends Equatable {
  final ApiResponse<PlanPurchasedModel> purchaseResponse;

  const PurchasePlanState({required this.purchaseResponse});

  PurchasePlanState copyWith({
    ApiResponse<PlanPurchasedModel>? purchaseResponse,
  }) {
    return PurchasePlanState(
      purchaseResponse: purchaseResponse ?? this.purchaseResponse,
    );
  }

  @override
  List<Object?> get props => [purchaseResponse];
}
