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
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    data['totalPages'] = totalPages;
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = nId;
    data['total'] = total;
    data['completed'] = completed;
    data['pending'] = pending;
    data['inProgress'] = inProgress;
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
    land = json['land'] != null ? Land.fromJson(json['land']) : null;
    status = json['status'];
    priority = json['priority'];
    startDate = json['startDate'];
    dueDate = json['dueDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['taskId'] = taskId;
    data['taskTitle'] = taskTitle;
    data['taskDescription'] = taskDescription;
    data['taskType'] = taskType;
    if (land != null) {
      data['land'] = land!.toJson();
    }
    data['status'] = status;
    data['priority'] = priority;
    data['startDate'] = startDate;
    data['dueDate'] = dueDate;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['landTitle'] = landTitle;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    return data;
  }
}
