part of 'plan_purchase_bloc.dart';

abstract class PurchasePlanEvent extends Equatable {
  const PurchasePlanEvent();

  @override
  List<Object> get props => [];
}

class PurchasePlanSubmitted extends PurchasePlanEvent {
  final PurchasePlanRequestModel request;

  const PurchasePlanSubmitted(this.request);

  @override
  List<Object> get props => [request];
}
