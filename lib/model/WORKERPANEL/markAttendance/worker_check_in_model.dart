class WorkerCheckInModel {
  bool? success;
  String? message;
  Attendance? attendance;

  WorkerCheckInModel({this.success, this.message, this.attendance});

  WorkerCheckInModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['checkIn'] = checkIn;
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}
