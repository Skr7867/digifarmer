class WorkerCheckOutModel {
  bool? success;
  String? message;
  Attendance? attendance;

  WorkerCheckOutModel({this.success, this.message, this.attendance});

  WorkerCheckOutModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    attendance = json['attendance'] != null
        ? Attendance.fromJson(json['attendance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (attendance != null) {
      data['attendance'] = attendance!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['checkIn'] = checkIn;
    data['checkOut'] = checkOut;
    data['totalHours'] = totalHours;
    data['amountEarned'] = amountEarned;
    return data;
  }
}
