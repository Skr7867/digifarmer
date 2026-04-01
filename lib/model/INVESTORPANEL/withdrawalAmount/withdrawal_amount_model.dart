class WithdrawalAmountModel {
  final bool success;
  final String? message;
  final dynamic data;

  WithdrawalAmountModel({
    required this.success,
    this.message,
    this.data,
  });

  factory WithdrawalAmountModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalAmountModel(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'],
    );
  }
}