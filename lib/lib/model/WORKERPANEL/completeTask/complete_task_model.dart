class CompleteTaskModel {
  final bool? success;
  final String? message;
  final CompleteTaskData? task;

  CompleteTaskModel({this.success, this.message, this.task});

  factory CompleteTaskModel.fromJson(Map<String, dynamic> json) {
    return CompleteTaskModel(
      success: json['success'],
      message: json['message'],
      task: json['task'] != null
          ? CompleteTaskData.fromJson(json['task'])
          : null,
    );
  }
}

class CompleteTaskData {
  final String? id;
  final String? status;
  final String? completedAt;

  CompleteTaskData({this.id, this.status, this.completedAt});

  factory CompleteTaskData.fromJson(Map<String, dynamic> json) {
    return CompleteTaskData(
      id: json['id'],
      status: json['status'],
      completedAt: json['completedAt'],
    );
  }
}
