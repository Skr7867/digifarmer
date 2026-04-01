class WalletResponse {
  final bool success;
  final WalletModel wallet;

  WalletResponse({
    required this.success,
    required this.wallet,
  });

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      success: json['success'] ?? false,
      wallet: WalletModel.fromJson(json['wallet']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'wallet': wallet.toJson(),
    };
  }
}

class WalletModel {
  final String id;
  final num totalInvested;
  final num totalROIEarned;
  final num availableBalance;
  final num lockedBalance;
  final num pendingWithdrawal;
  final WalletSummary summary;
  final List<dynamic> activeInvestments;
  final List<dynamic> upcomingUnlocks;
  final List<dynamic> withdrawalRequests;
  final List<dynamic> recentTransactions;

  WalletModel({
    required this.id,
    required this.totalInvested,
    required this.totalROIEarned,
    required this.availableBalance,
    required this.lockedBalance,
    required this.pendingWithdrawal,
    required this.summary,
    required this.activeInvestments,
    required this.upcomingUnlocks,
    required this.withdrawalRequests,
    required this.recentTransactions,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] ?? '',
      totalInvested: json['totalInvested'] ?? 0,
      totalROIEarned: json['totalROIEarned'] ?? 0,
      availableBalance: json['availableBalance'] ?? 0,
      lockedBalance: json['lockedBalance'] ?? 0,
      pendingWithdrawal: json['pendingWithdrawal'] ?? 0,
      summary: WalletSummary.fromJson(json['summary']),
      activeInvestments: json['activeInvestments'] ?? [],
      upcomingUnlocks: json['upcomingUnlocks'] ?? [],
      withdrawalRequests: json['withdrawalRequests'] ?? [],
      recentTransactions: json['recentTransactions'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'totalInvested': totalInvested,
      'totalROIEarned': totalROIEarned,
      'availableBalance': availableBalance,
      'lockedBalance': lockedBalance,
      'pendingWithdrawal': pendingWithdrawal,
      'summary': summary.toJson(),
      'activeInvestments': activeInvestments,
      'upcomingUnlocks': upcomingUnlocks,
      'withdrawalRequests': withdrawalRequests,
      'recentTransactions': recentTransactions,
    };
  }
}

class WalletSummary {
  final int activeInvestments;
  final int maturedInvestments;
  final int pendingWithdrawals;
  final num totalPendingWithdrawalAmount;

  WalletSummary({
    required this.activeInvestments,
    required this.maturedInvestments,
    required this.pendingWithdrawals,
    required this.totalPendingWithdrawalAmount,
  });

  factory WalletSummary.fromJson(Map<String, dynamic> json) {
    return WalletSummary(
      activeInvestments: json['activeInvestments'] ?? 0,
      maturedInvestments: json['maturedInvestments'] ?? 0,
      pendingWithdrawals: json['pendingWithdrawals'] ?? 0,
      totalPendingWithdrawalAmount: json['totalPendingWithdrawalAmount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeInvestments': activeInvestments,
      'maturedInvestments': maturedInvestments,
      'pendingWithdrawals': pendingWithdrawals,
      'totalPendingWithdrawalAmount': totalPendingWithdrawalAmount,
    };
  }
}