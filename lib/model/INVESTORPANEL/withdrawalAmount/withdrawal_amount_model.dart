class WithdrawalAmountModel {
  bool? success;
  String? message;
  WithdrawalRequest? withdrawalRequest;
  int? pendingWithdrawal;
  int? availableBalance;

  WithdrawalAmountModel({
    this.success,
    this.message,
    this.withdrawalRequest,
    this.pendingWithdrawal,
    this.availableBalance,
  });

  WithdrawalAmountModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    withdrawalRequest = json['withdrawalRequest'] != null
        ? new WithdrawalRequest.fromJson(json['withdrawalRequest'])
        : null;
    pendingWithdrawal = json['pendingWithdrawal'];
    availableBalance = json['availableBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.withdrawalRequest != null) {
      data['withdrawalRequest'] = this.withdrawalRequest!.toJson();
    }
    data['pendingWithdrawal'] = this.pendingWithdrawal;
    data['availableBalance'] = this.availableBalance;
    return data;
  }
}

class WithdrawalRequest {
  int? amount;
  String? status;
  String? requestedAt;
  String? paymentMethod;
  String? notes;
  String? id;

  WithdrawalRequest({
    this.amount,
    this.status,
    this.requestedAt,
    this.paymentMethod,
    this.notes,
    this.id,
  });

  WithdrawalRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    status = json['status'];
    requestedAt = json['requestedAt'];
    paymentMethod = json['paymentMethod'];
    notes = json['notes'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['requestedAt'] = this.requestedAt;
    data['paymentMethod'] = this.paymentMethod;
    data['notes'] = this.notes;
    data['id'] = this.id;
    return data;
  }
}
