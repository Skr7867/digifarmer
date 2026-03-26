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
        ? new PlanDetails.fromJson(json['planDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['orderId'] = this.orderId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['keyId'] = this.keyId;
    data['investmentId'] = this.investmentId;
    data['investmentNumber'] = this.investmentNumber;
    if (this.planDetails != null) {
      data['planDetails'] = this.planDetails!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['returnPercent'] = this.returnPercent;
    data['durationMonths'] = this.durationMonths;
    return data;
  }
}
