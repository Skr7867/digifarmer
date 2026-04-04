class WalletResponse {
  bool? success;
  Wallet? wallet;

  WalletResponse({this.success, this.wallet});

  WalletResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    return data;
  }
}

class Wallet {
  String? id;
  int? totalInvested;
  int? totalROIEarned;
  int? availableBalance;
  int? lockedBalance;
  int? pendingWithdrawal;
  Summary? summary;

  List<dynamic>? activeInvestments;
  List<dynamic>? upcomingUnlocks;

  List<WithdrawalRequest>? withdrawalRequests;
  List<RecentTransactions>? recentTransactions;

  Wallet({
    this.id,
    this.totalInvested,
    this.totalROIEarned,
    this.availableBalance,
    this.lockedBalance,
    this.pendingWithdrawal,
    this.summary,
    this.activeInvestments,
    this.upcomingUnlocks,
    this.withdrawalRequests,
    this.recentTransactions,
  });

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalInvested = json['totalInvested'];
    totalROIEarned = json['totalROIEarned'];
    availableBalance = json['availableBalance'];
    lockedBalance = json['lockedBalance'];
    pendingWithdrawal = json['pendingWithdrawal'];

    summary = json['summary'] != null
        ? Summary.fromJson(json['summary'])
        : null;

    activeInvestments = json['activeInvestments'] != null
        ? List.from(json['activeInvestments'])
        : null;

    upcomingUnlocks = json['upcomingUnlocks'] != null
        ? List.from(json['upcomingUnlocks'])
        : null;

    // ✅ FIXED: withdrawalRequests model
    if (json['withdrawalRequests'] != null) {
      withdrawalRequests = (json['withdrawalRequests'] as List)
          .map((v) => WithdrawalRequest.fromJson(v))
          .toList();
    }

    // ✅ FIXED: recentTransactions with metadata
    if (json['recentTransactions'] != null) {
      recentTransactions = (json['recentTransactions'] as List)
          .map((v) => RecentTransactions.fromJson(v))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['totalInvested'] = totalInvested;
    data['totalROIEarned'] = totalROIEarned;
    data['availableBalance'] = availableBalance;
    data['lockedBalance'] = lockedBalance;
    data['pendingWithdrawal'] = pendingWithdrawal;

    if (summary != null) {
      data['summary'] = summary!.toJson();
    }

    if (activeInvestments != null) {
      data['activeInvestments'] = activeInvestments;
    }

    if (upcomingUnlocks != null) {
      data['upcomingUnlocks'] = upcomingUnlocks;
    }

    if (withdrawalRequests != null) {
      data['withdrawalRequests'] = withdrawalRequests!
          .map((v) => v.toJson())
          .toList();
    }

    if (recentTransactions != null) {
      data['recentTransactions'] = recentTransactions!
          .map((v) => v.toJson())
          .toList();
    }

    return data;
  }
}

class WithdrawalRequest {
  int? amount;
  String? status;
  String? requestedAt;
  String? paymentMethod;
  String? notes;
  String? id;

  WithdrawalRequest({
    this.amount,
    this.status,
    this.requestedAt,
    this.paymentMethod,
    this.notes,
    this.id,
  });

  WithdrawalRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    status = json['status'];
    requestedAt = json['requestedAt'];
    paymentMethod = json['paymentMethod'];
    notes = json['notes'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['amount'] = amount;
    data['status'] = status;
    data['requestedAt'] = requestedAt;
    data['paymentMethod'] = paymentMethod;
    data['notes'] = notes;
    data['id'] = id;
    return data;
  }
}

class Summary {
  int? activeInvestments;
  int? maturedInvestments;
  int? pendingWithdrawals;
  int? totalPendingWithdrawalAmount;

  Summary({
    this.activeInvestments,
    this.maturedInvestments,
    this.pendingWithdrawals,
    this.totalPendingWithdrawalAmount,
  });

  Summary.fromJson(Map<String, dynamic> json) {
    activeInvestments = json['activeInvestments'];
    maturedInvestments = json['maturedInvestments'];
    pendingWithdrawals = json['pendingWithdrawals'];
    totalPendingWithdrawalAmount = json['totalPendingWithdrawalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['activeInvestments'] = activeInvestments;
    data['maturedInvestments'] = maturedInvestments;
    data['pendingWithdrawals'] = pendingWithdrawals;
    data['totalPendingWithdrawalAmount'] = totalPendingWithdrawalAmount;
    return data;
  }
}

class RecentTransactions {
  String? transactionId;
  String? type;
  int? amount;
  String? status;
  String? description;
  Metadata? metadata; // ✅ NEW
  String? createdAt;
  String? updatedAt;

  RecentTransactions({
    this.transactionId,
    this.type,
    this.amount,
    this.status,
    this.description,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  RecentTransactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    type = json['type'];
    amount = json['amount'];
    status = json['status'];
    description = json['description'];
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['transactionId'] = transactionId;
    data['type'] = type;
    data['amount'] = amount;
    data['status'] = status;
    data['description'] = description;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Metadata {
  String? paymentMethod;
  String? notes;
  String? requestId;

  Metadata({this.paymentMethod, this.notes, this.requestId});

  Metadata.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['paymentMethod'];
    notes = json['notes'];
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['paymentMethod'] = paymentMethod;
    data['notes'] = notes;
    data['requestId'] = requestId;
    return data;
  }
}
