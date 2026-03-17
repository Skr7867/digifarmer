class LandDetailsModel {
  bool? success;
  TaskDetail? task;

  LandDetailsModel({this.success, this.task});

  factory LandDetailsModel.fromJson(Map<String, dynamic> json) {
    return LandDetailsModel(
      success: json['success'],
      task: json['task'] != null ? TaskDetail.fromJson(json['task']) : null,
    );
  }
}

class TaskDetail {
  String? id;
  String? taskId;
  String? taskTitle;
  String? taskDescription;
  TaskLocation? location;
  String? status;
  String? priority;
  LandInfo? landId;
  String? workerId;
  String? taskType;
  String? startDate;
  String? dueDate;
  AssignedBy? assignedBy;
  List<StatusTimeline>? statusTimeline;
  String? assignedAt;
  String? createdAt;
  String? updatedAt;
  double? actualHours;
  String? completedAt;
  String? completedBy;
  String? completionNotes;
  List<TaskUpdate>? updates;

  TaskDetail({
    this.id,
    this.taskId,
    this.taskTitle,
    this.taskDescription,
    this.location,
    this.status,
    this.priority,
    this.landId,
    this.workerId,
    this.taskType,
    this.startDate,
    this.dueDate,
    this.assignedBy,
    this.statusTimeline,
    this.assignedAt,
    this.createdAt,
    this.updatedAt,
    this.actualHours,
    this.completedAt,
    this.completedBy,
    this.completionNotes,
    this.updates,
  });

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return TaskDetail(
      id: json['_id'],
      taskId: json['taskId'],
      taskTitle: json['taskTitle'],
      taskDescription: json['taskDescription'],
      location: json['location'] != null
          ? TaskLocation.fromJson(json['location'])
          : null,
      status: json['status'],
      priority: json['priority'],
      landId: json['landId'] != null ? LandInfo.fromJson(json['landId']) : null,
      workerId: json['workerId'],
      taskType: json['taskType'],
      startDate: json['startDate'],
      dueDate: json['dueDate'],
      assignedBy: json['assignedBy'] != null
          ? AssignedBy.fromJson(json['assignedBy'])
          : null,
      statusTimeline: json['statusTimeline'] != null
          ? List<StatusTimeline>.from(
              json['statusTimeline'].map((e) => StatusTimeline.fromJson(e)),
            )
          : null,
      assignedAt: json['assignedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      actualHours: (json['actualHours'] as num?)?.toDouble(),
      completedAt: json['completedAt'],
      completedBy: json['completedBy'],
      completionNotes: json['completionNotes'],
      updates: json['updates'] != null
          ? List<TaskUpdate>.from(
              json['updates'].map((e) => TaskUpdate.fromJson(e)),
            )
          : null,
    );
  }
}

class TaskLocation {
  String? country;
  String? timezone;

  TaskLocation({this.country, this.timezone});

  factory TaskLocation.fromJson(Map<String, dynamic> json) {
    return TaskLocation(country: json['country'], timezone: json['timezone']);
  }
}

class LandInfo {
  String? id;
  String? landTitle;
  String? areaUnit;
  double? totalSize;
  String? address;
  String? city;
  String? state;

  LandInfo({
    this.id,
    this.landTitle,
    this.areaUnit,
    this.totalSize,
    this.address,
    this.city,
    this.state,
  });

  factory LandInfo.fromJson(Map<String, dynamic> json) {
    return LandInfo(
      id: json['_id'],
      landTitle: json['landTitle'],
      areaUnit: json['areaUnit'],
      totalSize: (json['totalSize'] as num?)?.toDouble(),
      address: json['address'],
      city: json['city'],
      state: json['state'],
    );
  }
}

class AssignedBy {
  String? id;
  String? fullName;

  AssignedBy({this.id, this.fullName});

  factory AssignedBy.fromJson(Map<String, dynamic> json) {
    return AssignedBy(id: json['_id'], fullName: json['fullName']);
  }
}

class StatusTimeline {
  String? id;
  String? status;
  String? note;
  String? updatedBy;
  String? updatedAt;

  StatusTimeline({
    this.id,
    this.status,
    this.note,
    this.updatedBy,
    this.updatedAt,
  });

  factory StatusTimeline.fromJson(Map<String, dynamic> json) {
    return StatusTimeline(
      id: json['_id'],
      status: json['status'],
      note: json['note'],
      updatedBy: json['updatedBy'],
      updatedAt: json['updatedAt'],
    );
  }
}

class TaskUpdate {
  String? id;
  String? workDone;
  double? hoursWorked;
  List<UpdatePhoto>? photos;
  String? submittedAt;
  bool? approved;

  TaskUpdate({
    this.id,
    this.workDone,
    this.hoursWorked,
    this.photos,
    this.submittedAt,
    this.approved,
  });

  factory TaskUpdate.fromJson(Map<String, dynamic> json) {
    return TaskUpdate(
      id: json['id'],
      workDone: json['workDone'],
      hoursWorked: (json['hoursWorked'] as num?)?.toDouble(),
      photos: json['photos'] != null
          ? List<UpdatePhoto>.from(
              json['photos'].map((e) => UpdatePhoto.fromJson(e)),
            )
          : null,
      submittedAt: json['submittedAt'],
      approved: json['approved'],
    );
  }
}

class UpdatePhoto {
  String? id;
  String? url;
  String? caption;
  bool? isShareable;
  String? uploadedAt;

  UpdatePhoto({
    this.id,
    this.url,
    this.caption,
    this.isShareable,
    this.uploadedAt,
  });

  factory UpdatePhoto.fromJson(Map<String, dynamic> json) {
    return UpdatePhoto(
      id: json['_id'],
      url: json['url'],
      caption: json['caption'],
      isShareable: json['isShareable'],
      uploadedAt: json['uploadedAt'],
    );
  }
}
