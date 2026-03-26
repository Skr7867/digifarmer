class WorkerCheckInModel {
  bool? success;
  String? message;
  Attendance? attendance;

  WorkerCheckInModel({this.success, this.message, this.attendance});

  WorkerCheckInModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? status;

  Attendance({this.id, this.checkIn, this.date, this.status});

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkIn = json['checkIn'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['checkIn'] = this.checkIn;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}
