class WorkerDashBoardModel {
  bool? success;
  Dashboard? dashboard;

  WorkerDashBoardModel({this.success, this.dashboard});

  factory WorkerDashBoardModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return WorkerDashBoardModel();

    return WorkerDashBoardModel(
      success: json['success'],
      dashboard: json['dashboard'] != null
          ? Dashboard.fromJson(json['dashboard'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

  Dashboard({
    this.taskStatus,
    this.assignedLeads,
    this.taskCounts,
    this.priority,
    this.equipment,
    this.today,
    this.contact,
    this.contract,
  });

  factory Dashboard.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Dashboard();

    return Dashboard(
      taskStatus: json['taskStatus'] != null
          ? TaskStatus.fromJson(json['taskStatus'])
          : null,
      assignedLeads: json['assignedLeads'] != null
          ? List<AssignedLeads>.from(
              json['assignedLeads'].map((x) => AssignedLeads.fromJson(x)),
            )
          : null,
      taskCounts: json['taskCounts'] != null
          ? TaskCounts.fromJson(json['taskCounts'])
          : null,
      priority: json['priority'] != null
          ? Priority.fromJson(json['priority'])
          : null,
      equipment: json['equipment'] != null
          ? Equipment.fromJson(json['equipment'])
          : null,
      today: json['today'] != null ? Today.fromJson(json['today']) : null,
      contact: json['contact'] != null
          ? Contact.fromJson(json['contact'])
          : null,
      contract: json['contract'] != null
          ? Contract.fromJson(json['contract'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (taskStatus != null) {
      data['taskStatus'] = taskStatus!.toJson();
    }
    if (assignedLeads != null) {
      data['assignedLeads'] = assignedLeads!.map((v) => v.toJson()).toList();
    }
    if (taskCounts != null) {
      data['taskCounts'] = taskCounts!.toJson();
    }
    if (priority != null) {
      data['priority'] = priority!.toJson();
    }
    if (equipment != null) {
      data['equipment'] = equipment!.toJson();
    }
    if (today != null) {
      data['today'] = today!.toJson();
    }
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    if (contract != null) {
      data['contract'] = contract!.toJson();
    }
    return data;
  }
}

class TaskStatus {
  List<Completed>? completed;
  List<InProgress>? inProgress;
  List<dynamic>? pending;
  List<dynamic>? onHold;
  List<dynamic>? cancelled;

  TaskStatus({
    this.completed,
    this.inProgress,
    this.pending,
    this.onHold,
    this.cancelled,
  });

  factory TaskStatus.fromJson(Map<String, dynamic>? json) {
    if (json == null) return TaskStatus();

    return TaskStatus(
      completed: json['completed'] != null
          ? List<Completed>.from(
              json['completed'].map((x) => Completed.fromJson(x)),
            )
          : null,
      inProgress: json['inProgress'] != null
          ? List<InProgress>.from(
              json['inProgress'].map((x) => InProgress.fromJson(x)),
            )
          : null,
      pending: json['pending'] != null
          ? List<dynamic>.from(json['pending'])
          : null,
      onHold: json['onHold'] != null
          ? List<dynamic>.from(json['onHold'])
          : null,
      cancelled: json['cancelled'] != null
          ? List<dynamic>.from(json['cancelled'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (completed != null) {
      data['completed'] = completed!.map((v) => v.toJson()).toList();
    }
    if (inProgress != null) {
      data['inProgress'] = inProgress!.map((v) => v.toJson()).toList();
    }
    if (pending != null) {
      data['pending'] = pending!.toList();
    }
    if (onHold != null) {
      data['onHold'] = onHold!.toList();
    }
    if (cancelled != null) {
      data['cancelled'] = cancelled!.toList();
    }
    return data;
  }

  // Helper getters to safely access lists with empty fallback
  List<Completed> get completedList => completed ?? [];
  List<InProgress> get inProgressList => inProgress ?? [];
  List<dynamic> get pendingList => pending ?? [];
  List<dynamic> get onHoldList => onHold ?? [];
  List<dynamic> get cancelledList => cancelled ?? [];

  bool get hasCompleted => completed != null && completed!.isNotEmpty;
  bool get hasInProgress => inProgress != null && inProgress!.isNotEmpty;
}

class Completed {
  String? id;
  String? taskTitle;
  String? priority;
  String? status;
  String? workday;
  String? isoStandard;
  String? completedAt;

  Completed({
    this.id,
    this.taskTitle,
    this.priority,
    this.status,
    this.workday,
    this.isoStandard,
    this.completedAt,
  });

  factory Completed.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Completed();

    return Completed(
      id: json['id'],
      taskTitle: json['taskTitle'],
      priority: json['priority'],
      status: json['status'],
      workday: json['workday'],
      isoStandard: json['isoStandard'],
      completedAt: json['completedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['taskTitle'] = taskTitle;
    data['priority'] = priority;
    data['status'] = status;
    data['workday'] = workday;
    data['isoStandard'] = isoStandard;
    data['completedAt'] = completedAt;
    return data;
  }
}

class InProgress {
  String? id;
  String? taskTitle;
  String? priority;
  String? status;
  Land? land;
  String? workday;
  String? dueDate;
  int? progress;

  InProgress({
    this.id,
    this.taskTitle,
    this.priority,
    this.status,
    this.land,
    this.workday,
    this.dueDate,
    this.progress,
  });

  factory InProgress.fromJson(Map<String, dynamic>? json) {
    if (json == null) return InProgress();

    return InProgress(
      id: json['id'],
      taskTitle: json['taskTitle'],
      priority: json['priority'],
      status: json['status'],
      land: json['land'] != null ? Land.fromJson(json['land']) : null,
      workday: json['workday'],
      dueDate: json['dueDate'],
      progress: json['progress'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['taskTitle'] = taskTitle;
    data['priority'] = priority;
    data['status'] = status;
    if (land != null) {
      data['land'] = land!.toJson();
    }
    data['workday'] = workday;
    data['dueDate'] = dueDate;
    data['progress'] = progress;
    return data;
  }
}

class Land {
  String? sId;
  String? landTitle;

  Land({this.sId, this.landTitle});

  factory Land.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Land();

    return Land(sId: json['_id'], landTitle: json['landTitle']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['landTitle'] = landTitle;
    return data;
  }
}

class AssignedLeads {
  String? id;
  String? taskTitle;
  Land? land;
  String? workday;
  String? status;
  String? action;

  AssignedLeads({
    this.id,
    this.taskTitle,
    this.land,
    this.workday,
    this.status,
    this.action,
  });

  factory AssignedLeads.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AssignedLeads();

    return AssignedLeads(
      id: json['id'],
      taskTitle: json['taskTitle'],
      land: json['land'] != null ? Land.fromJson(json['land']) : null,
      workday: json['workday'],
      status: json['status'],
      action: json['action'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['taskTitle'] = taskTitle;
    if (land != null) {
      data['land'] = land!.toJson();
    }
    data['workday'] = workday;
    data['status'] = status;
    data['action'] = action;
    return data;
  }
}

class TaskCounts {
  int? total;
  int? completed;
  int? inProgress;
  int? pending;
  int? onHold;
  int? cancelled;

  TaskCounts({
    this.total,
    this.completed,
    this.inProgress,
    this.pending,
    this.onHold,
    this.cancelled,
  });

  factory TaskCounts.fromJson(Map<String, dynamic>? json) {
    if (json == null) return TaskCounts();

    return TaskCounts(
      total: json['total'],
      completed: json['completed'],
      inProgress: json['inProgress'],
      pending: json['pending'],
      onHold: json['onHold'],
      cancelled: json['cancelled'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['completed'] = completed;
    data['inProgress'] = inProgress;
    data['pending'] = pending;
    data['onHold'] = onHold;
    data['cancelled'] = cancelled;
    return data;
  }

  // Helper getters with default values
  int get totalCount => total ?? 0;
  int get completedCount => completed ?? 0;
  int get inProgressCount => inProgress ?? 0;
  int get pendingCount => pending ?? 0;
  int get onHoldCount => onHold ?? 0;
  int get cancelledCount => cancelled ?? 0;
}

class Priority {
  int? actions;
  int? activities;
  int? urgent;
  int? high;
  int? overdue;

  Priority({
    this.actions,
    this.activities,
    this.urgent,
    this.high,
    this.overdue,
  });

  factory Priority.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Priority();

    return Priority(
      actions: json['actions'],
      activities: json['activities'],
      urgent: json['urgent'],
      high: json['high'],
      overdue: json['overdue'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['actions'] = actions;
    data['activities'] = activities;
    data['urgent'] = urgent;
    data['high'] = high;
    data['overdue'] = overdue;
    return data;
  }

  // Helper getters with default values
  int get actionsCount => actions ?? 0;
  int get activitiesCount => activities ?? 0;
  int get urgentCount => urgent ?? 0;
  int get highCount => high ?? 0;
  int get overdueCount => overdue ?? 0;
}

class Equipment {
  int? maintenanceNeeded;
  int? totalAssigned;

  Equipment({this.maintenanceNeeded, this.totalAssigned});

  factory Equipment.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Equipment();

    return Equipment(
      maintenanceNeeded: json['maintenanceNeeded'],
      totalAssigned: json['totalAssigned'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenanceNeeded'] = maintenanceNeeded;
    data['totalAssigned'] = totalAssigned;
    return data;
  }

  // Helper getters with default values
  int get maintenanceNeededCount => maintenanceNeeded ?? 0;
  int get totalAssignedCount => totalAssigned ?? 0;
}

class Today {
  String? status;

  Today({this.status});

  factory Today.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Today();

    return Today(status: json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}

class Contact {
  String? phone;

  Contact({this.phone});

  factory Contact.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Contact();

    return Contact(phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    return data;
  }
}

class Contract {
  bool? hasContract;
  bool? canCancel;

  Contract({this.hasContract, this.canCancel});

  factory Contract.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Contract();

    return Contract(
      hasContract: json['hasContract'],
      canCancel: json['canCancel'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hasContract'] = hasContract;
    data['canCancel'] = canCancel;
    return data;
  }

  // Helper getters with default values
  bool get hasActiveContract => hasContract ?? false;
  bool get canCancelContract => canCancel ?? false;
}
