class SubmitKycDocumentsModel {
  bool? success;
  String? message;
  String? kycStatus;
  String? submittedAt;

  SubmitKycDocumentsModel(
      {this.success, this.message, this.kycStatus, this.submittedAt});

  SubmitKycDocumentsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    kycStatus = json['kycStatus'];
    submittedAt = json['submittedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['kycStatus'] = this.kycStatus;
    data['submittedAt'] = this.submittedAt;
    return data;
  }
}
