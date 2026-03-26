class AllTaskModel {
  bool? success;
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  Stats? stats;
  List<Tasks>? tasks;

  AllTaskModel({
    this.success,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.stats,
    this.tasks,
  });

  AllTaskModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stats {
  Null nId;
  int? total;
  int? completed;
  int? pending;
  int? inProgress;

  Stats({this.nId, this.total, this.completed, this.pending, this.inProgress});

  Stats.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    total = json['total'];
    completed = json['completed'];
    pending = json['pending'];
    inProgress = json['inProgress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.nId;
    data['total'] = this.total;
    data['completed'] = this.completed;
    data['pending'] = this.pending;
    data['inProgress'] = this.inProgress;
    return data;
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
    id = json['id'];
    taskId = json['taskId'];
    taskTitle = json['taskTitle'];
    taskDescription = json['taskDescription'];
    taskType = json['taskType'];
    land = json['land'] != null ? new Land.fromJson(json['land']) : null;
    status = json['status'];
    priority = json['priority'];
    startDate = json['startDate'];
    dueDate = json['dueDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['taskId'] = this.taskId;
    data['taskTitle'] = this.taskTitle;
    data['taskDescription'] = this.taskDescription;
    data['taskType'] = this.taskType;
    if (this.land != null) {
      data['land'] = this.land!.toJson();
    }
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['startDate'] = this.startDate;
    data['dueDate'] = this.dueDate;
    return data;
  }
}

class Land {
  String? sId;
  String? landTitle;
  String? address;
  String? city;
  String? state;

  Land({this.sId, this.landTitle, this.address, this.city, this.state});

  Land.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    landTitle = json['landTitle'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['landTitle'] = this.landTitle;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
