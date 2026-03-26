class WorkerCheckOutModel {
  bool? success;
  String? message;
  Attendance? attendance;

  WorkerCheckOutModel({this.success, this.message, this.attendance});

  WorkerCheckOutModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    attendance = json['attendance'] != null
        ? new Attendance.fromJson(json['attendance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.attendance != null) {
      data['attendance'] = this.attendance!.toJson();
    }
    return data;
  }
}

class Attendance {
  String? id;
  String? checkIn;
  String? checkOut;
  double? totalHours;
  double? amountEarned;

  Attendance({
    this.id,
    this.checkIn,
    this.checkOut,
    this.totalHours,
    this.amountEarned,
  });

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    totalHours = json['totalHours'];
    amountEarned = json['amountEarned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['totalHours'] = this.totalHours;
    data['amountEarned'] = this.amountEarned;
    return data;
  }
}
