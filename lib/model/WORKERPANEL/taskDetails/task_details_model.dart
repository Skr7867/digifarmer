class TaskDetailModel {
  final bool? success;
  final TaskDashboard? dashboard;

  TaskDetailModel({this.success, this.dashboard});

  factory TaskDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskDetailModel(
      success: json['success'],
      dashboard: json['dashboard'] != null
          ? TaskDashboard.fromJson(json['dashboard'])
          : null,
    );
  }
}

class TaskDashboard {
  final Task? task;
  final List<dynamic>? workUpdates;
  final List<dynamic>? equipment;
  final TaskSummary? summary;

  TaskDashboard({this.task, this.workUpdates, this.equipment, this.summary});

  factory TaskDashboard.fromJson(Map<String, dynamic> json) {
    return TaskDashboard(
      task: json['task'] != null ? Task.fromJson(json['task']) : null,
      workUpdates: json['workUpdates'] ?? [],
      equipment: json['equipment'] ?? [],
      summary: json['summary'] != null
          ? TaskSummary.fromJson(json['summary'])
          : null,
    );
  }
}

class Task {
  final String? id;
  final String? taskId;
  final String? taskTitle;
  final String? taskDescription;
  final String? taskType;
  final String? status;
  final StatusRating? statusRating;
  final String? priority;
  final TaskDates? dates;
  final TaskLocation? location;

  Task({
    this.id,
    this.taskId,
    this.taskTitle,
    this.taskDescription,
    this.taskType,
    this.status,
    this.statusRating,
    this.priority,
    this.dates,
    this.location,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      taskId: json['taskId'],
      taskTitle: json['taskTitle'],
      taskDescription: json['taskDescription'],
      taskType: json['taskType'],
      status: json['status'],
      statusRating: json['statusRating'] != null
          ? StatusRating.fromJson(json['statusRating'])
          : null,
      priority: json['priority'],
      dates: json['dates'] != null ? TaskDates.fromJson(json['dates']) : null,
      location: json['location'] != null
          ? TaskLocation.fromJson(json['location'])
          : null,
    );
  }
}

class StatusRating {
  final double? score;
  final String? label;
  final String? updatedAt;

  StatusRating({this.score, this.label, this.updatedAt});

  factory StatusRating.fromJson(Map<String, dynamic> json) {
    return StatusRating(
      score: (json['score'] as num?)?.toDouble(),
      label: json['label'],
      updatedAt: json['updatedAt'],
    );
  }
}

class TaskDates {
  final String? start;
  final String? due;

  TaskDates({this.start, this.due});

  factory TaskDates.fromJson(Map<String, dynamic> json) {
    return TaskDates(start: json['start'], due: json['due']);
  }
}

class TaskLocation {
  final String? country;
  final String? timezone;

  TaskLocation({this.country, this.timezone});

  factory TaskLocation.fromJson(Map<String, dynamic> json) {
    return TaskLocation(country: json['country'], timezone: json['timezone']);
  }
}

class TaskSummary {
  final int? completedItems;
  final int? totalItems;
  final int? completionPercentage;
  final int? totalHoursWorked;

  TaskSummary({
    this.completedItems,
    this.totalItems,
    this.completionPercentage,
    this.totalHoursWorked,
  });

  factory TaskSummary.fromJson(Map<String, dynamic> json) {
    return TaskSummary(
      completedItems: json['completedItems'],
      totalItems: json['totalItems'],
      completionPercentage: json['completionPercentage'],
      totalHoursWorked: json['totalHoursWorked'],
    );
  }
}
