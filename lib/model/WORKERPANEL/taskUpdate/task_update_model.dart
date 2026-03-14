class TaskUpdateModel {
  final bool? success;
  final String? message;
  final TaskUpdateData? update;

  TaskUpdateModel({this.success, this.message, this.update});

  factory TaskUpdateModel.fromJson(Map<String, dynamic> json) {
    return TaskUpdateModel(
      success: json['success'],
      message: json['message'],
      update: json['update'] != null
          ? TaskUpdateData.fromJson(json['update'])
          : null,
    );
  }
}

class TaskUpdateData {
  final String? id;
  final String? workDone;
  final int? hoursWorked;
  final String? submittedAt;

  TaskUpdateData({this.id, this.workDone, this.hoursWorked, this.submittedAt});

  factory TaskUpdateData.fromJson(Map<String, dynamic> json) {
    return TaskUpdateData(
      id: json['id'],
      workDone: json['workDone'],
      hoursWorked: json['hoursWorked'],
      submittedAt: json['submittedAt'],
    );
  }
}
