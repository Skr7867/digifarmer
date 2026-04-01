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
    if (investment != null) data['investment'] = investment!.toJson();
    return data;
  }
}

// ✅ Shared helper mixin to avoid repeating _toInt/_toDouble everywhere
class _TypeHelper {
  static int? toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? toDouble(dynamic value) {
    if (value == null) return null;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value);
    return null;
  }
}

class Investment {
  String? id;
  String? investmentId;
  String? investmentType;
  int? investmentAmount;
  int? durationMonths;
  double? expectedReturnPercent;
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
  List<dynamic>? adminNotes;
  ApprovedBy? approvedBy;
  String? approvedAt;
  String? createdAt;
  String? updatedAt;
  Allocations? allocations;
  PoolInfo? poolInfo;
  TaskImages? taskImages; // ✅ NEW - was missing

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
    this.taskImages,
  });

  Investment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    investmentId = json['investmentId'];
    investmentType = json['investmentType'];
    investmentAmount = _TypeHelper.toInt(json['investmentAmount']);
    durationMonths = _TypeHelper.toInt(json['durationMonths']);
    paidAmount = _TypeHelper.toInt(json['paidAmount']);
    selectedDuration = _TypeHelper.toInt(json['selectedDuration']);
    roiAmount = _TypeHelper.toInt(json['roiAmount']);
    totalRoiExpected = _TypeHelper.toInt(json['totalRoiExpected']);
    totalROIPaid = _TypeHelper.toInt(json['totalROIPaid']);
    pendingROI = _TypeHelper.toInt(json['pendingROI']);
    lockInPeriodMonths = _TypeHelper.toInt(json['lockInPeriodMonths']);
    expectedReturnPercent = _TypeHelper.toDouble(json['expectedReturnPercent']);
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
      documents = (json['documents'] as List)
          .map((v) => Documents.fromJson(v))
          .toList();
    }

    if (json['statusTimeline'] != null) {
      statusTimeline = (json['statusTimeline'] as List)
          .map((v) => StatusTimeline.fromJson(v))
          .toList();
    }

    adminRemarks = json['adminRemarks'];
    adminNotes = json['adminNotes'] != null
        ? List<dynamic>.from(json['adminNotes'])
        : [];

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

    // ✅ NEW
    taskImages = json['taskImages'] != null
        ? TaskImages.fromJson(json['taskImages'])
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
    data['agreementPdfUrl'] = agreementPdfUrl;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    if (statusTimeline != null) {
      data['statusTimeline'] = statusTimeline!.map((v) => v.toJson()).toList();
    }
    data['adminRemarks'] = adminRemarks;
    data['adminNotes'] = adminNotes;
    if (approvedBy != null) data['approvedBy'] = approvedBy!.toJson();
    data['approvedAt'] = approvedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (allocations != null) data['allocations'] = allocations!.toJson();
    if (poolInfo != null) data['poolInfo'] = poolInfo!.toJson();
    if (taskImages != null) data['taskImages'] = taskImages!.toJson();
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
    minInvestment = _TypeHelper.toInt(json['minInvestment']);
    maxInvestment = _TypeHelper.toInt(json['maxInvestment']);
    returnPercent = _TypeHelper.toInt(json['returnPercent']);
  }

  Map<String, dynamic> toJson() => {
        '_id': sId,
        'planName': planName,
        'minInvestment': minInvestment,
        'maxInvestment': maxInvestment,
        'returnPercent': returnPercent,
      };
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

  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
        'name': name,
        'uploadedAt': uploadedAt,
      };
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

  Map<String, dynamic> toJson() => {
        'status': status,
        'note': note,
        'updatedAt': updatedAt,
        'updatedBy': updatedBy,
      };
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

  Map<String, dynamic> toJson() => {
        '_id': sId,
        'mobileNumber': mobileNumber,
        'fullName': fullName,
      };
}

class Allocations {
  List<Lands>? lands;
  List<dynamic>? crops;
  String? allocatedAt;
  String? allocatedBy;
  int? totalAllocatedAmount; // ✅ NEW
  String? allocationStatus;  // ✅ NEW

  Allocations({
    this.lands,
    this.crops,
    this.allocatedAt,
    this.allocatedBy,
    this.totalAllocatedAmount,
    this.allocationStatus,
  });

  Allocations.fromJson(Map<String, dynamic> json) {
    if (json['lands'] != null) {
      lands = (json['lands'] as List)
          .map((v) => Lands.fromJson(v))
          .toList();
    }
    crops = json['crops'] != null ? List<dynamic>.from(json['crops']) : [];
    allocatedAt = json['allocatedAt'];
    allocatedBy = json['allocatedBy'];
    totalAllocatedAmount = _TypeHelper.toInt(json['totalAllocatedAmount']); // ✅ NEW
    allocationStatus = json['allocationStatus']; // ✅ NEW
  }

  Map<String, dynamic> toJson() => {
        'lands': lands?.map((v) => v.toJson()).toList(),
        'crops': crops,
        'allocatedAt': allocatedAt,
        'allocatedBy': allocatedBy,
        'totalAllocatedAmount': totalAllocatedAmount,
        'allocationStatus': allocationStatus,
      };
}

class Lands {
  LandId? landId;
  int? allocatedAmount;
  int? allocationPercent;
  String? allocatedAt;       // ✅ NEW
  bool? isActive;            // ✅ NEW
  LandDetails? landDetails;
  List<Crops>? crops;
  List<TaskImage>? taskImages;   // ✅ NEW
  int? taskImagesCount;          // ✅ NEW

  Lands({
    this.landId,
    this.allocatedAmount,
    this.allocationPercent,
    this.allocatedAt,
    this.isActive,
    this.landDetails,
    this.crops,
    this.taskImages,
    this.taskImagesCount,
  });

  Lands.fromJson(Map<String, dynamic> json) {
    landId = json['landId'] != null ? LandId.fromJson(json['landId']) : null;
    allocatedAmount = _TypeHelper.toInt(json['allocatedAmount']);
    allocationPercent = _TypeHelper.toInt(json['allocationPercent']);
    allocatedAt = json['allocatedAt'];       // ✅ NEW
    isActive = json['isActive'];             // ✅ NEW
    landDetails = json['landDetails'] != null
        ? LandDetails.fromJson(json['landDetails'])
        : null;
    if (json['crops'] != null) {
      crops = (json['crops'] as List)
          .map((v) => Crops.fromJson(v))
          .toList();
    }
    // ✅ NEW
    if (json['taskImages'] != null) {
      taskImages = (json['taskImages'] as List)
          .map((v) => TaskImage.fromJson(v))
          .toList();
    }
    taskImagesCount = _TypeHelper.toInt(json['taskImagesCount']); // ✅ NEW
  }

  Map<String, dynamic> toJson() => {
        'landId': landId?.toJson(),
        'allocatedAmount': allocatedAmount,
        'allocationPercent': allocationPercent,
        'allocatedAt': allocatedAt,
        'isActive': isActive,
        'landDetails': landDetails?.toJson(),
        'crops': crops?.map((v) => v.toJson()).toList(),
        'taskImages': taskImages?.map((v) => v.toJson()).toList(),
        'taskImagesCount': taskImagesCount,
      };
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
    totalSize = _TypeHelper.toInt(json['totalSize']);
    description = json['description'];
    landImages = json['landImages'] != null
        ? List<String>.from(json['landImages'])
        : [];
    address = json['address'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() => {
        '_id': sId,
        'landTitle': landTitle,
        'surveyNumber': surveyNumber,
        'areaUnit': areaUnit,
        'totalSize': totalSize,
        'description': description,
        'landImages': landImages,
        'address': address,
        'city': city,
        'state': state,
      };
}

class LandDetails {
  String? id;       // ✅ NEW - was missing
  String? title;
  String? location;
  int? area;
  String? unit;
  List<String>? images;

  LandDetails({
    this.id,
    this.title,
    this.location,
    this.area,
    this.unit,
    this.images,
  });

  LandDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];       // ✅ NEW
    title = json['title'];
    location = json['location'];
    area = _TypeHelper.toInt(json['area']);
    unit = json['unit'];
    images = json['images'] != null
        ? List<String>.from(json['images'])
        : [];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'area': area,
        'unit': unit,
        'images': images,
      };
}

class Crops {
  String? type;
  double? amount;    // ✅ changed int→double (API sends 15000.000000000002)
  double? percent;  // ✅ changed int→double (API sends 33.333333333333336)
  double? expectedReturn; // ✅ changed int→double (API sends 2700.0000000000005)
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
    amount = _TypeHelper.toDouble(json['amount']);
    percent = _TypeHelper.toDouble(json['percent']);
    expectedReturn = _TypeHelper.toDouble(json['expectedReturn']);
    season = json['season'];
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'amount': amount,
        'percent': percent,
        'expectedReturn': expectedReturn,
        'season': season,
      };
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
    totalPoolSize = _TypeHelper.toInt(json['totalPoolSize']);
    remainingAmount = _TypeHelper.toInt(json['remainingAmount']);
    allocatedLands = json['allocatedLands'] != null
        ? List<dynamic>.from(json['allocatedLands'])
        : [];
  }

  Map<String, dynamic> toJson() => {
        'poolName': poolName,
        'totalPoolSize': totalPoolSize,
        'remainingAmount': remainingAmount,
        'allocatedLands': allocatedLands,
      };
}

// ✅ NEW - TaskImage model (used in both Lands.taskImages and TaskImages.allImages)
class TaskImage {
  String? id;
  String? taskId;
  String? taskTitle;
  String? taskType;
  String? workDone;
  int? hoursWorked;
  String? submittedAt;
  String? imageUrl;
  String? caption;
  bool? isShareable;
  String? landId;         // only in allImages / imagesByLand
  String? landTitle;      // only in allImages / imagesByLand
  String? landLocation;   // only in allImages / imagesByLand

  TaskImage({
    this.id,
    this.taskId,
    this.taskTitle,
    this.taskType,
    this.workDone,
    this.hoursWorked,
    this.submittedAt,
    this.imageUrl,
    this.caption,
    this.isShareable,
    this.landId,
    this.landTitle,
    this.landLocation,
  });

  TaskImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['taskId'];
    taskTitle = json['taskTitle'];
    taskType = json['taskType'];
    workDone = json['workDone'];
    hoursWorked = _TypeHelper.toInt(json['hoursWorked']);
    submittedAt = json['submittedAt'];
    imageUrl = json['imageUrl'];
    caption = json['caption'];
    isShareable = json['isShareable'];
    landId = json['landId'];
    landTitle = json['landTitle'];
    landLocation = json['landLocation'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'taskId': taskId,
        'taskTitle': taskTitle,
        'taskType': taskType,
        'workDone': workDone,
        'hoursWorked': hoursWorked,
        'submittedAt': submittedAt,
        'imageUrl': imageUrl,
        'caption': caption,
        'isShareable': isShareable,
        'landId': landId,
        'landTitle': landTitle,
        'landLocation': landLocation,
      };
}

// ✅ NEW - TaskImages wrapper (top-level investment.taskImages)
class TaskImages {
  List<TaskImage>? allImages;
  List<ImagesByLand>? imagesByLand;
  int? totalImages;
  int? landsWithImages;

  TaskImages({
    this.allImages,
    this.imagesByLand,
    this.totalImages,
    this.landsWithImages,
  });

  TaskImages.fromJson(Map<String, dynamic> json) {
    if (json['allImages'] != null) {
      allImages = (json['allImages'] as List)
          .map((v) => TaskImage.fromJson(v))
          .toList();
    }
    if (json['imagesByLand'] != null) {
      imagesByLand = (json['imagesByLand'] as List)
          .map((v) => ImagesByLand.fromJson(v))
          .toList();
    }
    totalImages = _TypeHelper.toInt(json['totalImages']);
    landsWithImages = _TypeHelper.toInt(json['landsWithImages']);
  }

  Map<String, dynamic> toJson() => {
        'allImages': allImages?.map((v) => v.toJson()).toList(),
        'imagesByLand': imagesByLand?.map((v) => v.toJson()).toList(),
        'totalImages': totalImages,
        'landsWithImages': landsWithImages,
      };
}

// ✅ NEW - ImagesByLand model
class ImagesByLand {
  String? landId;
  String? landTitle;
  String? landLocation;
  List<String>? landImages;
  List<TaskImage>? images;

  ImagesByLand({
    this.landId,
    this.landTitle,
    this.landLocation,
    this.landImages,
    this.images,
  });

  ImagesByLand.fromJson(Map<String, dynamic> json) {
    landId = json['landId'];
    landTitle = json['landTitle'];
    landLocation = json['landLocation'];
    landImages = json['landImages'] != null
        ? List<String>.from(json['landImages'])
        : [];
    if (json['images'] != null) {
      images = (json['images'] as List)
          .map((v) => TaskImage.fromJson(v))
          .toList();
    }
  }

  Map<String, dynamic> toJson() => {
        'landId': landId,
        'landTitle': landTitle,
        'landLocation': landLocation,
        'landImages': landImages,
        'images': images?.map((v) => v.toJson()).toList(),
      };
}