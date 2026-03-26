class ActiveInvestmentModel {
  bool? success;
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  Stats? stats;
  List<Investments>? investments;

  ActiveInvestmentModel({
    this.success,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.stats,
    this.investments,
  });

  ActiveInvestmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = _toInt(json['total']);
    page = _toInt(json['page']);
    limit = _toInt(json['limit']);
    totalPages = _toInt(json['totalPages']);
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    if (json['investments'] != null) {
      investments = <Investments>[];
      json['investments'].forEach((v) {
        investments!.add(Investments.fromJson(v));
      });
    }
  }

  // Helper method to safely convert to int
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    data['totalPages'] = totalPages;
    if (stats != null) data['stats'] = stats!.toJson();
    if (investments != null) {
      data['investments'] = investments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stats {
  int? totalInvested;
  int? activeInvestments;
  int? totalROIEarned;
  int? pendingROI;
  int? projectedReturns;
  double? avgReturnPercent;
  int? pendingPayments;

  Stats({
    this.totalInvested,
    this.activeInvestments,
    this.totalROIEarned,
    this.pendingROI,
    this.projectedReturns,
    this.avgReturnPercent,
    this.pendingPayments,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    totalInvested = _toInt(json['totalInvested']);
    activeInvestments = _toInt(json['activeInvestments']);
    totalROIEarned = _toInt(json['totalROIEarned']);
    pendingROI = _toInt(json['pendingROI']);
    projectedReturns = _toInt(json['projectedReturns']);
    avgReturnPercent = json['avgReturnPercent']?.toDouble();
    pendingPayments = _toInt(json['pendingPayments']);
  }

  // Helper method to safely convert to int
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'totalInvested': totalInvested,
      'activeInvestments': activeInvestments,
      'totalROIEarned': totalROIEarned,
      'pendingROI': pendingROI,
      'projectedReturns': projectedReturns,
      'avgReturnPercent': avgReturnPercent,
      'pendingPayments': pendingPayments,
    };
  }
}

class Investments {
  String? id;
  String? investmentId;
  String? investmentType;
  int? investmentAmount;
  int? durationMonths;
  double? expectedReturnPercent;
  String? applicationStatus;
  String? paymentStatus;
  PlanId? planId;
  int? selectedDuration;
  String? roiFrequency;
  double? roiAmount;
  double? totalRoiExpected;
  int? totalROIPaid;
  int? pendingROI;
  String? startDate;
  String? endDate;
  String? maturityDate;
  int? lockInPeriodMonths;
  bool? prematureExitAllowed;
  String? riskLevel;
  List<dynamic>? documents;
  List<StatusTimeline>? statusTimeline;
  List<dynamic>? adminNotes;
  String? createdAt;
  String? updatedAt;
  Allocations? allocations;
  PoolInfo? poolInfo;
  BankDetails? bankDetails;

  Investments({
    this.id,
    this.investmentId,
    this.investmentType,
    this.investmentAmount,
    this.durationMonths,
    this.expectedReturnPercent,
    this.applicationStatus,
    this.paymentStatus,
    this.planId,
    this.selectedDuration,
    this.roiFrequency,
    this.roiAmount,
    this.totalRoiExpected,
    this.totalROIPaid,
    this.pendingROI,
    this.startDate,
    this.endDate,
    this.maturityDate,
    this.lockInPeriodMonths,
    this.prematureExitAllowed,
    this.riskLevel,
    this.documents,
    this.statusTimeline,
    this.adminNotes,
    this.createdAt,
    this.updatedAt,
    this.allocations,
    this.poolInfo,
    this.bankDetails,
  });

  Investments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    investmentId = json['investmentId'];
    investmentType = json['investmentType'];
    investmentAmount = _toInt(json['investmentAmount']);
    durationMonths = _toInt(json['durationMonths']);
    expectedReturnPercent = json['expectedReturnPercent']?.toDouble();
    applicationStatus = json['applicationStatus'];
    paymentStatus = json['paymentStatus'];
    planId = json['planId'] != null ? PlanId.fromJson(json['planId']) : null;
    selectedDuration = _toInt(json['selectedDuration']);
    roiFrequency = json['roiFrequency'];
    roiAmount = json['roiAmount']?.toDouble();
    totalRoiExpected = json['totalRoiExpected']?.toDouble();
    totalROIPaid = _toInt(json['totalROIPaid']);
    pendingROI = _toInt(json['pendingROI']);
    startDate = json['startDate'];
    endDate = json['endDate'];
    maturityDate = json['maturityDate'];
    lockInPeriodMonths = _toInt(json['lockInPeriodMonths']);
    prematureExitAllowed = json['prematureExitAllowed'];
    riskLevel = json['riskLevel'];
    documents = json['documents'] != null
        ? List<dynamic>.from(json['documents'])
        : null;
    if (json['statusTimeline'] != null) {
      statusTimeline = <StatusTimeline>[];
      json['statusTimeline'].forEach((v) {
        statusTimeline!.add(StatusTimeline.fromJson(v));
      });
    }
    adminNotes = json['adminNotes'] != null
        ? List<dynamic>.from(json['adminNotes'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    allocations = json['allocations'] != null
        ? Allocations.fromJson(json['allocations'])
        : null;
    poolInfo = json['poolInfo'] != null
        ? PoolInfo.fromJson(json['poolInfo'])
        : null;
    bankDetails = json['bankDetails'] != null
        ? BankDetails.fromJson(json['bankDetails'])
        : null;
  }

  // Helper method to safely convert to int
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['investmentId'] = investmentId;
    data['investmentType'] = investmentType;
    data['investmentAmount'] = investmentAmount;
    data['durationMonths'] = durationMonths;
    data['expectedReturnPercent'] = expectedReturnPercent;
    data['applicationStatus'] = applicationStatus;
    data['paymentStatus'] = paymentStatus;
    if (planId != null) data['planId'] = planId!.toJson();
    data['selectedDuration'] = selectedDuration;
    data['roiFrequency'] = roiFrequency;
    data['roiAmount'] = roiAmount;
    data['totalRoiExpected'] = totalRoiExpected;
    data['totalROIPaid'] = totalROIPaid;
    data['pendingROI'] = pendingROI;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['maturityDate'] = maturityDate;
    data['lockInPeriodMonths'] = lockInPeriodMonths;
    data['prematureExitAllowed'] = prematureExitAllowed;
    data['riskLevel'] = riskLevel;
    if (documents != null) data['documents'] = documents;
    if (statusTimeline != null) {
      data['statusTimeline'] = statusTimeline!.map((v) => v.toJson()).toList();
    }
    if (adminNotes != null) data['adminNotes'] = adminNotes;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (allocations != null) data['allocations'] = allocations!.toJson();
    if (poolInfo != null) data['poolInfo'] = poolInfo!.toJson();
    if (bankDetails != null) data['bankDetails'] = bankDetails!.toJson();
    return data;
  }
}

class PlanId {
  String? sId;
  String? planName;
  int? returnPercent;

  PlanId({this.sId, this.planName, this.returnPercent});

  PlanId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planName = json['planName'];
    returnPercent = json['returnPercent'];
  }

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'planName': planName,
    'returnPercent': returnPercent,
  };
}

class StatusTimeline {
  String? status;
  String? note;
  String? updatedAt;

  StatusTimeline({this.status, this.note, this.updatedAt});

  StatusTimeline.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    note = json['note'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'note': note,
    'updatedAt': updatedAt,
  };
}

class Allocations {
  List<dynamic>? lands;
  List<dynamic>? crops;

  Allocations({this.lands, this.crops});

  Allocations.fromJson(Map<String, dynamic> json) {
    lands = json['lands'] != null ? List<dynamic>.from(json['lands']) : null;
    crops = json['crops'] != null ? List<dynamic>.from(json['crops']) : null;
  }

  Map<String, dynamic> toJson() => {'lands': lands, 'crops': crops};
}

class PoolInfo {
  String? poolName;
  int? totalPoolSize;
  int? remainingAmount;
  List<dynamic>? allocatedLands;

  PoolInfo({
    this.poolName,
    this.totalPoolSize,
    this.remainingAmount,
    this.allocatedLands,
  });

  PoolInfo.fromJson(Map<String, dynamic> json) {
    poolName = json['poolName'];
    totalPoolSize = _toInt(json['totalPoolSize']);
    remainingAmount = _toInt(json['remainingAmount']);
    allocatedLands = json['allocatedLands'] != null
        ? List<dynamic>.from(json['allocatedLands'])
        : null;
  }

  // Helper method to safely convert to int
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() => {
    'poolName': poolName,
    'totalPoolSize': totalPoolSize,
    'remainingAmount': remainingAmount,
    'allocatedLands': allocatedLands,
  };
}

class BankDetails {
  String? accountHolderName;
  String? bankName;
  String? accountNumber;
  String? ifscCode;
  String? accountType;
  bool? verified;

  BankDetails({
    this.accountHolderName,
    this.bankName,
    this.accountNumber,
    this.ifscCode,
    this.accountType,
    this.verified,
  });

  BankDetails.fromJson(Map<String, dynamic> json) {
    accountHolderName = json['accountHolderName'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    ifscCode = json['ifscCode'];
    accountType = json['accountType'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() => {
    'accountHolderName': accountHolderName,
    'bankName': bankName,
    'accountNumber': accountNumber,
    'ifscCode': ifscCode,
    'accountType': accountType,
    'verified': verified,
  };
}
