class WorkerDashboardModel {
  final bool? success;
  final Dashboard? dashboard;

  WorkerDashboardModel({this.success, this.dashboard});

  factory WorkerDashboardModel.fromJson(Map<String, dynamic> json) {
    return WorkerDashboardModel(
      success: json['success'],
      dashboard: json['dashboard'] != null
          ? Dashboard.fromJson(json['dashboard'])
          : null,
    );
  }
}

class Dashboard {
  final List<dynamic>? completed;
  final List<AssignedLeads>? assignedLeads;
  final Priority? priority;
  final Equipment? equipment;
  final Today? today;
  final Contact? contact;
  final Contract? contract;

  Dashboard({
    this.completed,
    this.assignedLeads,
    this.priority,
    this.equipment,
    this.today,
    this.contact,
    this.contract,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      completed: json['completed'],
      assignedLeads: json['assignedLeads'] != null
          ? (json['assignedLeads'] as List)
                .map((e) => AssignedLeads.fromJson(e))
                .toList()
          : [],
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
}

class AssignedLeads {
  final String? id;
  final String? taskTitle;
  final Land? land;
  final String? workday;
  final String? status;
  final String? action;

  AssignedLeads({
    this.id,
    this.taskTitle,
    this.land,
    this.workday,
    this.status,
    this.action,
  });

  factory AssignedLeads.fromJson(Map<String, dynamic> json) {
    return AssignedLeads(
      id: json['id'],
      taskTitle: json['taskTitle'],
      land: json['land'] != null ? Land.fromJson(json['land']) : null,
      workday: json['workday'],
      status: json['status'],
      action: json['action'],
    );
  }
}

class Land {
  final String? id;
  final String? landTitle;

  Land({this.id, this.landTitle});

  factory Land.fromJson(Map<String, dynamic> json) {
    return Land(id: json['_id'], landTitle: json['landTitle']);
  }
}

class Priority {
  final int? actions;
  final int? activities;
  final int? urgent;
  final int? high;
  final int? overdue;

  Priority({
    this.actions,
    this.activities,
    this.urgent,
    this.high,
    this.overdue,
  });

  factory Priority.fromJson(Map<String, dynamic> json) {
    return Priority(
      actions: json['actions'],
      activities: json['activities'],
      urgent: json['urgent'],
      high: json['high'],
      overdue: json['overdue'],
    );
  }
}

class Equipment {
  final int? maintenanceNeeded;
  final int? totalAssigned;

  Equipment({this.maintenanceNeeded, this.totalAssigned});

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      maintenanceNeeded: json['maintenanceNeeded'],
      totalAssigned: json['totalAssigned'],
    );
  }
}

class Today {
  final String? status;

  Today({this.status});

  factory Today.fromJson(Map<String, dynamic> json) {
    return Today(status: json['status']);
  }
}

class Contact {
  final String? phone;

  Contact({this.phone});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(phone: json['phone']);
  }
}

class Contract {
  final bool? hasContract;
  final bool? canCancel;

  Contract({this.hasContract, this.canCancel});

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      hasContract: json['hasContract'],
      canCancel: json['canCancel'],
    );
  }
}
