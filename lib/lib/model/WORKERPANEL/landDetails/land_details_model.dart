class LandDetailsModel {
  bool? success;
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  Stats? stats;
  List<Tasks>? tasks;

  LandDetailsModel({
    this.success,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.stats,
    this.tasks,
  });

  LandDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;

    if (json['tasks'] != null) {
      tasks = (json['tasks'] as List)
          .map((e) => Tasks.fromJson(e))
          .toList();
    }
  }
}

class Stats {
  String? id;
  int? total;
  int? completed;
  int? pending;
  int? inProgress;
  int? totalHours;

  Stats({
    this.id,
    this.total,
    this.completed,
    this.pending,
    this.inProgress,
    this.totalHours,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    id = json['_id']?.toString();
    total = json['total'];
    completed = json['completed'];
    pending = json['pending'];
    inProgress = json['inProgress'];
    totalHours = json['totalHours'];
  }
}

class Tasks {
  String? id;
  String? taskId;
  String? taskTitle;
  String? taskDescription;
  String? taskType;
  Land? land;
  String? status;
  String? priority;
  String? startDate;
  String? dueDate;

  Tasks({
    this.id,
    this.taskId,
    this.taskTitle,
    this.taskDescription,
    this.taskType,
    this.land,
    this.status,
    this.priority,
    this.startDate,
    this.dueDate,
  });

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    taskId = json['taskId']?.toString();
    taskTitle = json['taskTitle']?.toString();
    taskDescription = json['taskDescription']?.toString();
    taskType = json['taskType']?.toString();
    land = json['land'] != null ? Land.fromJson(json['land']) : null;
    status = json['status']?.toString();
    priority = json['priority']?.toString();
    startDate = json['startDate']?.toString();
    dueDate = json['dueDate']?.toString();
  }
}

class Land {
  String? id;
  String? landTitle;
  String? areaUnit;
  double? totalSize;   // ⭐ FIXED HERE
  String? address;
  String? city;
  String? state;

  Land({
    this.id,
    this.landTitle,
    this.areaUnit,
    this.totalSize,
    this.address,
    this.city,
    this.state,
  });

  Land.fromJson(Map<String, dynamic> json) {
    id = json['_id']?.toString();
    landTitle = json['landTitle']?.toString();
    areaUnit = json['areaUnit']?.toString();
    totalSize = (json['totalSize'] as num?)?.toDouble(); // ⭐ SAFE CAST
    address = json['address']?.toString();
    city = json['city']?.toString();
    state = json['state']?.toString();
  }
}