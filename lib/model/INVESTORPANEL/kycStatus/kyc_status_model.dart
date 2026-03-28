class KycStatusModel {
  bool? success;
  Data? data;

  KycStatusModel({this.success, this.data});

  KycStatusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? kycStatus;
  List<VerificationSteps>? verificationSteps;
  String? submittedAt;
  PanCard? panCard;
  AadhaarCard? aadhaarCard;
  PanCard? selfie;
  BankDetails? bankDetails;

  Data(
      {this.kycStatus,
      this.verificationSteps,
      this.submittedAt,
      this.panCard,
      this.aadhaarCard,
      this.selfie,
      this.bankDetails});

  Data.fromJson(Map<String, dynamic> json) {
    kycStatus = json['kycStatus'];
    if (json['verificationSteps'] != null) {
      verificationSteps = <VerificationSteps>[];
      json['verificationSteps'].forEach((v) {
        verificationSteps!.add(new VerificationSteps.fromJson(v));
      });
    }
    submittedAt = json['submittedAt'];
    panCard =
        json['panCard'] != null ? new PanCard.fromJson(json['panCard']) : null;
    aadhaarCard = json['aadhaarCard'] != null
        ? new AadhaarCard.fromJson(json['aadhaarCard'])
        : null;
    selfie =
        json['selfie'] != null ? new PanCard.fromJson(json['selfie']) : null;
    bankDetails = json['bankDetails'] != null
        ? new BankDetails.fromJson(json['bankDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kycStatus'] = this.kycStatus;
    if (this.verificationSteps != null) {
      data['verificationSteps'] =
          this.verificationSteps!.map((v) => v.toJson()).toList();
    }
    data['submittedAt'] = this.submittedAt;
    if (this.panCard != null) {
      data['panCard'] = this.panCard!.toJson();
    }
    if (this.aadhaarCard != null) {
      data['aadhaarCard'] = this.aadhaarCard!.toJson();
    }
    if (this.selfie != null) {
      data['selfie'] = this.selfie!.toJson();
    }
    if (this.bankDetails != null) {
      data['bankDetails'] = this.bankDetails!.toJson();
    }
    return data;
  }
}

class VerificationSteps {
  int? step;
  String? name;
  String? status;
  String? completedAt;
  String? sId;

  VerificationSteps(
      {this.step, this.name, this.status, this.completedAt, this.sId});

  VerificationSteps.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    name = json['name'];
    status = json['status'];
    completedAt = json['completedAt'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['step'] = this.step;
    data['name'] = this.name;
    data['status'] = this.status;
    data['completedAt'] = this.completedAt;
    data['_id'] = this.sId;
    return data;
  }
}

class PanCard {
  bool? uploaded;
  bool? verified;
  String? url;

  PanCard({this.uploaded, this.verified, this.url});

  PanCard.fromJson(Map<String, dynamic> json) {
    uploaded = json['uploaded'];
    verified = json['verified'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploaded'] = this.uploaded;
    data['verified'] = this.verified;
    data['url'] = this.url;
    return data;
  }
}

class AadhaarCard {
  bool? uploaded;
  bool? verified;
  String? frontUrl;

  AadhaarCard({this.uploaded, this.verified, this.frontUrl});

  AadhaarCard.fromJson(Map<String, dynamic> json) {
    uploaded = json['uploaded'];
    verified = json['verified'];
    frontUrl = json['frontUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploaded'] = this.uploaded;
    data['verified'] = this.verified;
    data['frontUrl'] = this.frontUrl;
    return data;
  }
}

class BankDetails {
  bool? provided;
  bool? verified;
  String? bankName;
  String? accountNumber;

  BankDetails(
      {this.provided, this.verified, this.bankName, this.accountNumber});

  BankDetails.fromJson(Map<String, dynamic> json) {
    provided = json['provided'];
    verified = json['verified'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provided'] = this.provided;
    data['verified'] = this.verified;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}
