class AttendanceHistoryModel {
  bool? success;
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  Summary? summary;
  List<AttendanceRecord>? attendance;

  AttendanceHistoryModel({
    this.success,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.summary,
    this.attendance,
  });

  factory AttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryModel(
      success: json['success'],
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      summary: json['summary'] != null
          ? Summary.fromJson(json['summary'])
          : null,
      attendance: json['attendance'] != null
          ? List<AttendanceRecord>.from(
              json['attendance'].map((e) => AttendanceRecord.fromJson(e)),
            )
          : null,
    );
  }
}

class Summary {
  String? id;
  int? totalDays;
  int? presentDays;
  int? absentDays;
  double? totalEarnings;
  double? totalHours;

  Summary({
    this.id,
    this.totalDays,
    this.presentDays,
    this.absentDays,
    this.totalEarnings,
    this.totalHours,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      id: json['_id'],
      totalDays: json['totalDays'],
      presentDays: json['presentDays'],
      absentDays: json['absentDays'],
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble(),
      totalHours: (json['totalHours'] as num?)?.toDouble(),
    );
  }
}

class AttendanceRecord {
  String? id;
  String? date;
  String? status;
  String? checkIn;
  String? checkOut;
  double? totalHours;
  double? amountEarned;

  AttendanceRecord({
    this.id,
    this.date,
    this.status,
    this.checkIn,
    this.checkOut,
    this.totalHours,
    this.amountEarned,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'],
      date: json['date'],
      status: json['status'],
      checkIn: json['checkIn'],
      checkOut: json['checkOut'],
      totalHours: (json['totalHours'] as num?)?.toDouble(),
      amountEarned: (json['amountEarned'] as num?)?.toDouble(),
    );
  }

  /// Helpers
  bool get isCheckedOut => checkOut != null;

  DateTime? get dateTime => date != null ? DateTime.tryParse(date!) : null;

  DateTime? get checkInDateTime =>
      checkIn != null ? DateTime.tryParse(checkIn!) : null;

  DateTime? get checkOutDateTime =>
      checkOut != null ? DateTime.tryParse(checkOut!) : null;
}
