class InvestmentDetailsModel {
  bool? success;
  Investment? investment;

  InvestmentDetailsModel({this.success, this.investment});

  InvestmentDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    investment = json['investment'] != null
        ? Investment.fromJson(json['investment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (investment != null) {
      data['investment'] = investment!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['investmentId'] = investmentId;
    data['investmentType'] = investmentType;
    data['investmentAmount'] = investmentAmount;
    data['durationMonths'] = durationMonths;
    data['expectedReturnPercent'] = expectedReturnPercent;
    data['applicationStatus'] = applicationStatus;
    data['paymentStatus'] = paymentStatus;
    data['paymentMethod'] = paymentMethod;
    data['paidAmount'] = paidAmount;
    data['paidAt'] = paidAt;
    data['paymentReference'] = paymentReference;
    data['razorpayOrderId'] = razorpayOrderId;
    data['razorpayPaymentId'] = razorpayPaymentId;
    if (planId != null) {
      data['planId'] = planId!.toJson();
    }
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
    data['agreementPdfUrl'] = agreementPdfUrl;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    if (statusTimeline != null) {
      data['statusTimeline'] = statusTimeline!
          .map((v) => v.toJson())
          .toList();
    }
    data['adminRemarks'] = adminRemarks;

    if (approvedBy != null) {
      data['approvedBy'] = approvedBy!.toJson();
    }
    data['approvedAt'] = approvedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (allocations != null) {
      data['allocations'] = allocations!.toJson();
    }
    if (poolInfo != null) {
      data['poolInfo'] = poolInfo!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['planName'] = planName;
    data['minInvestment'] = minInvestment;
    data['maxInvestment'] = maxInvestment;
    data['returnPercent'] = returnPercent;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['url'] = url;
    data['name'] = name;
    data['uploadedAt'] = uploadedAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['note'] = note;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['mobileNumber'] = mobileNumber;
    data['fullName'] = fullName;
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
        lands!.add(Lands.fromJson(v));
      });
    }
    if (json['crops'] != null) {
      crops = <Null>[];
    }
    allocatedAt = json['allocatedAt'];
    allocatedBy = json['allocatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lands != null) {
      data['lands'] = lands!.map((v) => v.toJson()).toList();
    }

    data['allocatedAt'] = allocatedAt;
    data['allocatedBy'] = allocatedBy;
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
        ? LandId.fromJson(json['landId'])
        : null;
    allocatedAmount = json['allocatedAmount'];
    allocationPercent = json['allocationPercent'];
    landDetails = json['landDetails'] != null
        ? LandDetails.fromJson(json['landDetails'])
        : null;
    if (json['crops'] != null) {
      crops = <Crops>[];
      json['crops'].forEach((v) {
        crops!.add(Crops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (landId != null) {
      data['landId'] = landId!.toJson();
    }
    data['allocatedAmount'] = allocatedAmount;
    data['allocationPercent'] = allocationPercent;
    if (landDetails != null) {
      data['landDetails'] = landDetails!.toJson();
    }
    if (crops != null) {
      data['crops'] = crops!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['landTitle'] = landTitle;
    data['surveyNumber'] = surveyNumber;
    data['areaUnit'] = areaUnit;
    data['totalSize'] = totalSize;
    data['description'] = description;
    data['landImages'] = landImages;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['location'] = location;
    data['area'] = area;
    data['unit'] = unit;
    data['images'] = images;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['amount'] = amount;
    data['percent'] = percent;
    data['expectedReturn'] = expectedReturn;
    data['season'] = season;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poolName'] = poolName;
    data['totalPoolSize'] = totalPoolSize;
    data['remainingAmount'] = remainingAmount;

    return data;
  }
}
