part of 'submit_bank_details_bloc.dart';

class SubmitBankDetailsState extends Equatable {
  const SubmitBankDetailsState({
    this.accountNumber = '',
    this.confirmAccountNumber = '',
    this.ifscCode = '',
    this.bankName = '',
    this.accountHolderName = '',
    this.accountType = 'SAVINGS',
    this.upiId = '',
    this.accountNumberError = '',
    this.confirmAccountNumberError = '',
    this.ifscCodeError = '',
    this.bankNameError = '',
    this.accountHolderNameError = '',
    this.accountTypeError = '',
    this.upiIdError = '',
    this.messages = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String accountNumber;
  final String confirmAccountNumber;
  final String ifscCode;
  final String bankName;
  final String accountHolderName;
  final String accountType;
  final String upiId;
  
  // Error fields for validation
  final String accountNumberError;
  final String confirmAccountNumberError;
  final String ifscCodeError;
  final String bankNameError;
  final String accountHolderNameError;
  final String accountTypeError;
  final String upiIdError;
  
  final String messages;
  final PostApiStatus postApiStatus;

  SubmitBankDetailsState copyWith({
    String? accountNumber,
    String? confirmAccountNumber,
    String? ifscCode,
    String? bankName,
    String? accountHolderName,
    String? accountType,
    String? upiId,
    String? accountNumberError,
    String? confirmAccountNumberError,
    String? ifscCodeError,
    String? bankNameError,
    String? accountHolderNameError,
    String? accountTypeError,
    String? upiIdError,
    String? messages,
    PostApiStatus? postApiStatus,
  }) {
    return SubmitBankDetailsState(
      accountNumber: accountNumber ?? this.accountNumber,
      confirmAccountNumber: confirmAccountNumber ?? this.confirmAccountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      bankName: bankName ?? this.bankName,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountType: accountType ?? this.accountType,
      upiId: upiId ?? this.upiId,
      accountNumberError: accountNumberError ?? this.accountNumberError,
      confirmAccountNumberError: confirmAccountNumberError ?? this.confirmAccountNumberError,
      ifscCodeError: ifscCodeError ?? this.ifscCodeError,
      bankNameError: bankNameError ?? this.bankNameError,
      accountHolderNameError: accountHolderNameError ?? this.accountHolderNameError,
      accountTypeError: accountTypeError ?? this.accountTypeError,
      upiIdError: upiIdError ?? this.upiIdError,
      messages: messages ?? this.messages,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object?> get props => [
    accountNumber,
    confirmAccountNumber,
    ifscCode,
    bankName,
    accountHolderName,
    accountType,
    upiId,
    accountNumberError,
    confirmAccountNumberError,
    ifscCodeError,
    bankNameError,
    accountHolderNameError,
    accountTypeError,
    upiIdError,
    messages,
    postApiStatus,
  ];
}