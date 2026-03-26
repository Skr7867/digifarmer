class VerifyPaymentModel {
  bool? success;
  String? message;
  Data? data;

  VerifyPaymentModel({this.success, this.message, this.data});

  VerifyPaymentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? paymentId;
  String? orderId;
  String? signature;
  String? status;

  Data({this.paymentId, this.orderId, this.signature, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    orderId = json['orderId'];
    signature = json['signature'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentId'] = paymentId;
    data['orderId'] = orderId;
    data['signature'] = signature;
    data['status'] = status;
    return data;
  }
}