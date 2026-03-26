class PurchasePlanRequestModel {
  final String planId;
  final String planName;
  final int investmentAmount;
  final int durationMonths;
  final String roiFrequency;
  final String startDate;
  final String riskLevel;
  final int lockInPeriodMonths;
  final bool prematureExitAllowed;
  final int prematureExitPenalty;
  final double expectedReturnPercent;
  final double maturityAmount;
  final double totalReturn;

  PurchasePlanRequestModel({
    required this.planId,
    required this.planName,
    required this.investmentAmount,
    required this.durationMonths,
    required this.roiFrequency,
    required this.startDate,
    required this.riskLevel,
    required this.lockInPeriodMonths,
    required this.prematureExitAllowed,
    required this.prematureExitPenalty,
    required this.expectedReturnPercent,
    required this.maturityAmount,
    required this.totalReturn,
  });

  Map<String, dynamic> toJson() {
    return {
      "planId": planId,
      "planName": planName,
      "investmentAmount": investmentAmount,
      "durationMonths": durationMonths,
      "roiFrequency": roiFrequency,
      "startDate": startDate,
      "riskLevel": riskLevel,
      "lockInPeriodMonths": lockInPeriodMonths,
      "prematureExitAllowed": prematureExitAllowed,
      "prematureExitPenalty": prematureExitPenalty,
      "expectedReturnPercent": expectedReturnPercent,
      "maturityAmount": maturityAmount,
      "totalReturn": totalReturn,
    };
  }
}
