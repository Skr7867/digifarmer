class WorkerDashBoardModel {
  bool? success;
  Dashboard? dashboard;

  WorkerDashBoardModel({this.success, this.dashboard});

  WorkerDashBoardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    dashboard = json['dashboard'] != null
        ? Dashboard.fromJson(json['dashboard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (dashboard != null) {
      data['dashboard'] = dashboard!.toJson();
    }
    return data;
  }
}

class Dashboard {
  TaskStatus? taskStatus;
  List<AssignedLeads>? assignedLeads;
  TaskCounts? taskCounts;
  Priority? priority;
  Equipment? equipment;
  Today? today;
  Contact? contact;
  Contract? contract;

  Dashboard.fromJson(Map<String, dynamic> json) {
    taskStatus = json['taskStatus'] != null
        ? TaskStatus.fromJson(json['taskStatus'])
        : null;

    if (json['assignedLeads'] != null) {
      assignedLeads = (json['assignedLeads'] as List)
          .map((e) => AssignedLeads.fromJson(e))
          .toList();
    }

    taskCounts = json['taskCounts'] != null
        ? TaskCounts.fromJson(json['taskCounts'])
        : null;
    priority = json['priority'] != null
        ? Priority.fromJson(json['priority'])
        : null;
    equipment = json['equipment'] != null
        ? Equipment.fromJson(json['equipment'])
        : null;
    today = json['today'] != null ? Today.fromJson(json['today']) : null;
    contact = json['contact'] != null
        ? Contact.fromJson(json['contact'])
        : null;
    contract = json['contract'] != null
        ? Contract.fromJson(json['contract'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (taskStatus != null) data['taskStatus'] = taskStatus!.toJson();
    if (assignedLeads != null) {
      data['assignedLeads'] = assignedLeads!.map((e) => e.toJson()).toList();
    }
    if (taskCounts != null) data['taskCounts'] = taskCounts!.toJson();
    if (priority != null) data['priority'] = priority!.toJson();
    if (equipment != null) data['equipment'] = equipment!.toJson();
    if (today != null) data['today'] = today!.toJson();
    if (contact != null) data['contact'] = contact!.toJson();
    if (contract != null) data['contract'] = contract!.toJson();

    return data;
  }
}

class TaskStatus {
  List<Completed>? completed;
  List<dynamic>? inProgress;
  List<Pending>? pending;
  List<dynamic>? onHold;
  List<dynamic>? cancelled;

  TaskStatus.fromJson(Map<String, dynamic> json) {
    if (json['completed'] != null) {
      completed = (json['completed'] as List)
          .map((e) => Completed.fromJson(e))
          .toList();
    }

    inProgress = json['inProgress'];
    onHold = json['onHold'];
    cancelled = json['cancelled'];

    if (json['pending'] != null) {
      pending = (json['pending'] as List)
          .map((e) => Pending.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (completed != null) {
      data['completed'] = completed!.map((e) => e.toJson()).toList();
    }
    data['inProgress'] = inProgress;
    if (pending != null) {
      data['pending'] = pending!.map((e) => e.toJson()).toList();
    }
    data['onHold'] = onHold;
    data['cancelled'] = cancelled;

    return data;
  }
}

class Completed {
  String? id;
  String? taskTitle;
  String? priority;
  String? status;
  String? workday;
  String? isoStandard;
  String? completedAt;

  Completed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskTitle = json['taskTitle'];
    priority = json['priority'];
    status = json['status'];
    workday = json['workday'];
    isoStandard = json['isoStandard'];
    completedAt = json['completedAt'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'taskTitle': taskTitle,
    'priority': priority,
    'status': status,
    'workday': workday,
    'isoStandard': isoStandard,
    'completedAt': completedAt,
  };
}

class Pending {
  String? id;
  String? taskTitle;
  String? priority;
  String? status;
  Land? land;
  String? workday;
  String? dueDate;

  Pending.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskTitle = json['taskTitle'];
    priority = json['priority'];
    status = json['status'];
    land = json['land'] != null ? Land.fromJson(json['land']) : null;
    workday = json['workday'];
    dueDate = json['dueDate'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'taskTitle': taskTitle,
    'priority': priority,
    'status': status,
    'land': land?.toJson(),
    'workday': workday,
    'dueDate': dueDate,
  };
}

class Land {
  String? id;
  String? landTitle;

  Land.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    landTitle = json['landTitle'];
  }

  Map<String, dynamic> toJson() => {'_id': id, 'landTitle': landTitle};
}

class AssignedLeads {
  String? id;
  String? taskTitle;
  Land? land;
  String? workday;
  String? status;
  String? action;

  AssignedLeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskTitle = json['taskTitle'];
    land = json['land'] != null ? Land.fromJson(json['land']) : null;
    workday = json['workday'];
    status = json['status'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'taskTitle': taskTitle,
    'land': land?.toJson(),
    'workday': workday,
    'status': status,
    'action': action,
  };
}

class TaskCounts {
  int? total;
  int? completed;
  int? inProgress;
  int? pending;
  int? onHold;
  int? cancelled;
  Breakdown? breakdown;

  TaskCounts.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    completed = json['completed'];
    inProgress = json['inProgress'];
    pending = json['pending'];
    onHold = json['onHold'];
    cancelled = json['cancelled'];
    breakdown = json['breakdown'] != null
        ? Breakdown.fromJson(json['breakdown'])
        : null;
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'completed': completed,
    'inProgress': inProgress,
    'pending': pending,
    'onHold': onHold,
    'cancelled': cancelled,
    'breakdown': breakdown?.toJson(),
  };
}

class Breakdown {
  int? completed;
  int? pending;

  Breakdown.fromJson(Map<String, dynamic> json) {
    completed = json['COMPLETED'];
    pending = json['PENDING'];
  }

  Map<String, dynamic> toJson() => {'COMPLETED': completed, 'PENDING': pending};
}

class Priority {
  int? actions;
  int? activities;
  int? urgent;
  int? high;
  int? overdue;

  Priority.fromJson(Map<String, dynamic> json) {
    actions = json['actions'];
    activities = json['activities'];
    urgent = json['urgent'];
    high = json['high'];
    overdue = json['overdue'];
  }

  Map<String, dynamic> toJson() => {
    'actions': actions,
    'activities': activities,
    'urgent': urgent,
    'high': high,
    'overdue': overdue,
  };
}

class Equipment {
  int? maintenanceNeeded;
  int? totalAssigned;

  Equipment.fromJson(Map<String, dynamic> json) {
    maintenanceNeeded = json['maintenanceNeeded'];
    totalAssigned = json['totalAssigned'];
  }

  Map<String, dynamic> toJson() => {
    'maintenanceNeeded': maintenanceNeeded,
    'totalAssigned': totalAssigned,
  };
}

class Today {
  String? status;
  String? checkIn;
  String? checkOut;
  int? hours;

  Today.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'checkIn': checkIn,
    'checkOut': checkOut,
    'hours': hours,
  };
}

class Contact {
  String? phone;

  Contact.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() => {'phone': phone};
}

class Contract {
  bool? hasContract;
  bool? canCancel;

  Contract.fromJson(Map<String, dynamic> json) {
    hasContract = json['hasContract'];
    canCancel = json['canCancel'];
  }

  Map<String, dynamic> toJson() => {
    'hasContract': hasContract,
    'canCancel': canCancel,
  };
}
