class CreatePaymentModel {
  bool? success;
  String? orderId;
  int? amount;
  String? currency;
  String? keyId;
  String? investmentId;
  String? investmentNumber;
  PlanDetails? planDetails;

  CreatePaymentModel({
    this.success,
    this.orderId,
    this.amount,
    this.currency,
    this.keyId,
    this.investmentId,
    this.investmentNumber,
    this.planDetails,
  });

  CreatePaymentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    orderId = json['orderId'];
    amount = json['amount'];
    currency = json['currency'];
    keyId = json['keyId'];
    investmentId = json['investmentId'];
    investmentNumber = json['investmentNumber'];
    planDetails = json['planDetails'] != null
        ? PlanDetails.fromJson(json['planDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['orderId'] = orderId;
    data['amount'] = amount;
    data['currency'] = currency;
    data['keyId'] = keyId;
    data['investmentId'] = investmentId;
    data['investmentNumber'] = investmentNumber;
    if (planDetails != null) {
      data['planDetails'] = planDetails!.toJson();
    }
    return data;
  }
}

class PlanDetails {
  String? name;
  int? returnPercent;
  int? durationMonths;

  PlanDetails({this.name, this.returnPercent, this.durationMonths});

  PlanDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    returnPercent = json['returnPercent'];
    durationMonths = json['durationMonths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['returnPercent'] = returnPercent;
    data['durationMonths'] = durationMonths;
    return data;
  }
}
