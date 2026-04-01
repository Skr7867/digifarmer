import 'package:digifarmer/model/INVESTORPANEL/withdrawalAmount/withdrawal_amount_model.dart';

abstract class WithdrawalAmountRepository {
  Future<WithdrawalAmountModel> withdrawalAmountApi(dynamic data);
}
