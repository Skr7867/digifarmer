class StartTaskModel {
  final bool? success;
  final String? message;
  final StartTaskData? task;

  StartTaskModel({this.success, this.message, this.task});

  factory StartTaskModel.fromJson(Map<String, dynamic> json) {
    return StartTaskModel(
      success: json['success'],
      message: json['message'],
      task: json['task'] != null ? StartTaskData.fromJson(json['task']) : null,
    );
  }
}

class StartTaskData {
  final String? id;
  final String? status;
  final String? startDate;

  StartTaskData({this.id, this.status, this.startDate});

  factory StartTaskData.fromJson(Map<String, dynamic> json) {
    return StartTaskData(
      id: json['id'],
      status: json['status'],
      startDate: json['startDate'],
    );
  }
}
