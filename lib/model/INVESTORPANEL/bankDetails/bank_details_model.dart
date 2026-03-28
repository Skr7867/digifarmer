class BankDetailsModel {
  bool? success;
  String? message;
  String? kycStatus;

  BankDetailsModel({this.success, this.message, this.kycStatus});

  BankDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    kycStatus = json['kycStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['kycStatus'] = this.kycStatus;
    return data;
  }
}
