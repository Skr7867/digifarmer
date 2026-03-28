part of 'submit_bank_details_bloc.dart';

abstract class SubmitBankDetailsEvents extends Equatable {
  const SubmitBankDetailsEvents();

  @override
  List<Object> get props => [];
}

class AccountNumberChanged extends SubmitBankDetailsEvents {
  const AccountNumberChanged({required this.accountNumber});
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

class ConfirmAccountNumberChanged extends SubmitBankDetailsEvents {
  const ConfirmAccountNumberChanged({required this.confirmAccountNumber});
  final String confirmAccountNumber;

  @override
  List<Object> get props => [confirmAccountNumber];
}

class IfscCodeChanged extends SubmitBankDetailsEvents {
  const IfscCodeChanged({required this.ifscCode});
  final String ifscCode;

  @override
  List<Object> get props => [ifscCode];
}

class BankNameChanged extends SubmitBankDetailsEvents {
  const BankNameChanged({required this.bankName});
  final String bankName;

  @override
  List<Object> get props => [bankName];
}

class AccountHolderNameChanged extends SubmitBankDetailsEvents {
  const AccountHolderNameChanged({required this.accountHolderName});
  final String accountHolderName;

  @override
  List<Object> get props => [accountHolderName];
}

class AccountTypeChanged extends SubmitBankDetailsEvents {
  const AccountTypeChanged({required this.accountType});
  final String accountType;

  @override
  List<Object> get props => [accountType];
}

class UpiIdChanged extends SubmitBankDetailsEvents {
  const UpiIdChanged({required this.upiId});
  final String upiId;

  @override
  List<Object> get props => [upiId];
}

class AccountNumberUnfocused extends SubmitBankDetailsEvents {}
class ConfirmAccountNumberUnfocused extends SubmitBankDetailsEvents {}
class IfscCodeUnfocused extends SubmitBankDetailsEvents {}
class BankNameUnfocused extends SubmitBankDetailsEvents {}
class AccountHolderNameUnfocused extends SubmitBankDetailsEvents {}
class AccountTypeUnfocused extends SubmitBankDetailsEvents {}
class UpiIdUnfocused extends SubmitBankDetailsEvents {}

class SubmitBankDetailsApi extends SubmitBankDetailsEvents {}