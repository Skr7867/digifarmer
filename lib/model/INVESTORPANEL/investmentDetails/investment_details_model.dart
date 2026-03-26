class InvestmentDetailsModel {
  bool? success;
  Investment? investment;

  InvestmentDetailsModel({this.success, this.investment});

  InvestmentDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    investment = json['investment'] != null
        ? new Investment.fromJson(json['investment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.investment != null) {
      data['investment'] = this.investment!.toJson();
    }
    return data;
  }
}

class Investment {
  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value);
    return null;
  }

  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  String? id;
  String? investmentId;
  String? investmentType;
  int? investmentAmount;
  int? durationMonths;
  num? expectedReturnPercent;
  String? applicationStatus;
  String? paymentStatus;
  String? paymentMethod;
  int? paidAmount;
  String? paidAt;
  String? paymentReference;
  String? razorpayOrderId;
  String? razorpayPaymentId;
  PlanId? planId;
  int? selectedDuration;
  String? roiFrequency;
  int? roiAmount;
  int? totalRoiExpected;
  int? totalROIPaid;
  int? pendingROI;
  String? startDate;
  String? endDate;
  String? maturityDate;
  int? lockInPeriodMonths;
  bool? prematureExitAllowed;
  String? riskLevel;
  String? agreementPdfUrl;
  List<Documents>? documents;
  List<StatusTimeline>? statusTimeline;
  String? adminRemarks;
  List<Null>? adminNotes;
  ApprovedBy? approvedBy;
  String? approvedAt;
  String? createdAt;
  String? updatedAt;
  Allocations? allocations;
  PoolInfo? poolInfo;

  Investment({
    this.id,
    this.investmentId,
    this.investmentType,
    this.investmentAmount,
    this.durationMonths,
    this.expectedReturnPercent,
    this.applicationStatus,
    this.paymentStatus,
    this.paymentMethod,
    this.paidAmount,
    this.paidAt,
    this.paymentReference,
    this.razorpayOrderId,
    this.razorpayPaymentId,
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
    this.agreementPdfUrl,
    this.documents,
    this.statusTimeline,
    this.adminRemarks,
    this.adminNotes,
    this.approvedBy,
    this.approvedAt,
    this.createdAt,
    this.updatedAt,
    this.allocations,
    this.poolInfo,
  });

  Investment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    investmentId = json['investmentId'];
    investmentType = json['investmentType'];

    // Convert to int with proper handling
    investmentAmount = _toInt(json['investmentAmount']);
    durationMonths = _toInt(json['durationMonths']);
    paidAmount = _toInt(json['paidAmount']);
    selectedDuration = _toInt(json['selectedDuration']);
    roiAmount = _toInt(json['roiAmount']);
    totalRoiExpected = _toInt(json['totalRoiExpected']);
    totalROIPaid = _toInt(json['totalROIPaid']);
    pendingROI = _toInt(json['pendingROI']);
    lockInPeriodMonths = _toInt(json['lockInPeriodMonths']);

    expectedReturnPercent = _toDouble(json['expectedReturnPercent']);

    applicationStatus = json['applicationStatus'];
    paymentStatus = json['paymentStatus'];
    paymentMethod = json['paymentMethod'];
    paidAt = json['paidAt'];
    paymentReference = json['paymentReference'];
    razorpayOrderId = json['razorpayOrderId'];
    razorpayPaymentId = json['razorpayPaymentId'];

    planId = json['planId'] != null ? PlanId.fromJson(json['planId']) : null;

    roiFrequency = json['roiFrequency'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    maturityDate = json['maturityDate'];
    prematureExitAllowed = json['prematureExitAllowed'];
    riskLevel = json['riskLevel'];
    agreementPdfUrl = json['agreementPdfUrl'];

    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }

    if (json['statusTimeline'] != null) {
      statusTimeline = <StatusTimeline>[];
      json['statusTimeline'].forEach((v) {
        statusTimeline!.add(StatusTimeline.fromJson(v));
      });
    }

    adminRemarks = json['adminRemarks'];

    if (json['adminNotes'] != null) {
      adminNotes = <Null>[];
    }

    approvedBy = json['approvedBy'] != null
        ? ApprovedBy.fromJson(json['approvedBy'])
        : null;

    approvedAt = json['approvedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    allocations = json['allocations'] != null
        ? Allocations.fromJson(json['allocations'])
        : null;

    poolInfo = json['poolInfo'] != null
        ? PoolInfo.fromJson(json['poolInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['investmentId'] = this.investmentId;
    data['investmentType'] = this.investmentType;
    data['investmentAmount'] = this.investmentAmount;
    data['durationMonths'] = this.durationMonths;
    data['expectedReturnPercent'] = this.expectedReturnPercent;
    data['applicationStatus'] = this.applicationStatus;
    data['paymentStatus'] = this.paymentStatus;
    data['paymentMethod'] = this.paymentMethod;
    data['paidAmount'] = this.paidAmount;
    data['paidAt'] = this.paidAt;
    data['paymentReference'] = this.paymentReference;
    data['razorpayOrderId'] = this.razorpayOrderId;
    data['razorpayPaymentId'] = this.razorpayPaymentId;
    if (this.planId != null) {
      data['planId'] = this.planId!.toJson();
    }
    data['selectedDuration'] = this.selectedDuration;
    data['roiFrequency'] = this.roiFrequency;
    data['roiAmount'] = this.roiAmount;
    data['totalRoiExpected'] = this.totalRoiExpected;
    data['totalROIPaid'] = this.totalROIPaid;
    data['pendingROI'] = this.pendingROI;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['maturityDate'] = this.maturityDate;
    data['lockInPeriodMonths'] = this.lockInPeriodMonths;
    data['prematureExitAllowed'] = this.prematureExitAllowed;
    data['riskLevel'] = this.riskLevel;
    data['agreementPdfUrl'] = this.agreementPdfUrl;
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    if (this.statusTimeline != null) {
      data['statusTimeline'] = this.statusTimeline!
          .map((v) => v.toJson())
          .toList();
    }
    data['adminRemarks'] = this.adminRemarks;

    if (this.approvedBy != null) {
      data['approvedBy'] = this.approvedBy!.toJson();
    }
    data['approvedAt'] = this.approvedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.allocations != null) {
      data['allocations'] = this.allocations!.toJson();
    }
    if (this.poolInfo != null) {
      data['poolInfo'] = this.poolInfo!.toJson();
    }
    return data;
  }
}

class PlanId {
  String? sId;
  String? planName;
  int? minInvestment;
  int? maxInvestment;
  int? returnPercent;

  PlanId({
    this.sId,
    this.planName,
    this.minInvestment,
    this.maxInvestment,
    this.returnPercent,
  });

  PlanId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planName = json['planName'];
    minInvestment = json['minInvestment'];
    maxInvestment = json['maxInvestment'];
    returnPercent = json['returnPercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['planName'] = this.planName;
    data['minInvestment'] = this.minInvestment;
    data['maxInvestment'] = this.maxInvestment;
    data['returnPercent'] = this.returnPercent;
    return data;
  }
}

class Documents {
  String? type;
  String? url;
  String? name;
  String? uploadedAt;

  Documents({this.type, this.url, this.name, this.uploadedAt});

  Documents.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    name = json['name'];
    uploadedAt = json['uploadedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    data['name'] = this.name;
    data['uploadedAt'] = this.uploadedAt;
    return data;
  }
}

class StatusTimeline {
  String? status;
  String? note;
  String? updatedAt;
  String? updatedBy;

  StatusTimeline({this.status, this.note, this.updatedAt, this.updatedBy});

  StatusTimeline.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    note = json['note'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['note'] = this.note;
    data['updatedAt'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}

class ApprovedBy {
  String? sId;
  String? mobileNumber;
  String? fullName;

  ApprovedBy({this.sId, this.mobileNumber, this.fullName});

  ApprovedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mobileNumber = json['mobileNumber'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['mobileNumber'] = this.mobileNumber;
    data['fullName'] = this.fullName;
    return data;
  }
}

class Allocations {
  List<Lands>? lands;
  List<Null>? crops;
  String? allocatedAt;
  String? allocatedBy;

  Allocations({this.lands, this.crops, this.allocatedAt, this.allocatedBy});

  Allocations.fromJson(Map<String, dynamic> json) {
    if (json['lands'] != null) {
      lands = <Lands>[];
      json['lands'].forEach((v) {
        lands!.add(new Lands.fromJson(v));
      });
    }
    if (json['crops'] != null) {
      crops = <Null>[];
    }
    allocatedAt = json['allocatedAt'];
    allocatedBy = json['allocatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lands != null) {
      data['lands'] = this.lands!.map((v) => v.toJson()).toList();
    }

    data['allocatedAt'] = this.allocatedAt;
    data['allocatedBy'] = this.allocatedBy;
    return data;
  }
}

class Lands {
  LandId? landId;
  int? allocatedAmount;
  int? allocationPercent;
  LandDetails? landDetails;
  List<Crops>? crops;

  Lands({
    this.landId,
    this.allocatedAmount,
    this.allocationPercent,
    this.landDetails,
    this.crops,
  });

  Lands.fromJson(Map<String, dynamic> json) {
    landId = json['landId'] != null
        ? new LandId.fromJson(json['landId'])
        : null;
    allocatedAmount = json['allocatedAmount'];
    allocationPercent = json['allocationPercent'];
    landDetails = json['landDetails'] != null
        ? new LandDetails.fromJson(json['landDetails'])
        : null;
    if (json['crops'] != null) {
      crops = <Crops>[];
      json['crops'].forEach((v) {
        crops!.add(new Crops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.landId != null) {
      data['landId'] = this.landId!.toJson();
    }
    data['allocatedAmount'] = this.allocatedAmount;
    data['allocationPercent'] = this.allocationPercent;
    if (this.landDetails != null) {
      data['landDetails'] = this.landDetails!.toJson();
    }
    if (this.crops != null) {
      data['crops'] = this.crops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LandId {
  String? sId;
  String? landTitle;
  String? surveyNumber;
  String? areaUnit;
  int? totalSize;
  String? description;
  List<String>? landImages;
  String? address;
  String? city;
  String? state;

  LandId({
    this.sId,
    this.landTitle,
    this.surveyNumber,
    this.areaUnit,
    this.totalSize,
    this.description,
    this.landImages,
    this.address,
    this.city,
    this.state,
  });

  LandId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    landTitle = json['landTitle'];
    surveyNumber = json['surveyNumber'];
    areaUnit = json['areaUnit'];
    totalSize = json['totalSize'];
    description = json['description'];
    landImages = json['landImages'].cast<String>();
    address = json['address'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['landTitle'] = this.landTitle;
    data['surveyNumber'] = this.surveyNumber;
    data['areaUnit'] = this.areaUnit;
    data['totalSize'] = this.totalSize;
    data['description'] = this.description;
    data['landImages'] = this.landImages;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}

class LandDetails {
  String? title;
  String? location;
  int? area;
  String? unit;
  List<String>? images;

  LandDetails({this.title, this.location, this.area, this.unit, this.images});

  LandDetails.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    location = json['location'];
    area = json['area'];
    unit = json['unit'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['location'] = this.location;
    data['area'] = this.area;
    data['unit'] = this.unit;
    data['images'] = this.images;
    return data;
  }
}

class Crops {
  String? type;
  int? amount;
  int? percent;
  int? expectedReturn;
  String? season;

  Crops({
    this.type,
    this.amount,
    this.percent,
    this.expectedReturn,
    this.season,
  });

  Crops.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = json['amount'];
    percent = json['percent'];
    expectedReturn = json['expectedReturn'];
    season = json['season'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['percent'] = this.percent;
    data['expectedReturn'] = this.expectedReturn;
    data['season'] = this.season;
    return data;
  }
}

class PoolInfo {
  String? poolName;
  int? totalPoolSize;
  int? remainingAmount;
  List<Null>? allocatedLands;

  PoolInfo({
    this.poolName,
    this.totalPoolSize,
    this.remainingAmount,
    this.allocatedLands,
  });

  PoolInfo.fromJson(Map<String, dynamic> json) {
    poolName = json['poolName'];
    totalPoolSize = json['totalPoolSize'];
    remainingAmount = json['remainingAmount'];
    if (json['allocatedLands'] != null) {
      allocatedLands = <Null>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poolName'] = this.poolName;
    data['totalPoolSize'] = this.totalPoolSize;
    data['remainingAmount'] = this.remainingAmount;

    return data;
  }
}
