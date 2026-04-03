import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repository/INVESTORPANEL/submitBankDetails/submit_bank_details_repository.dart';
import '../../../utils/enums.dart';

part 'submit_bank_details_event.dart';
part 'submit_bank_details_state.dart';

class SubmitBankDetailsBloc
    extends Bloc<SubmitBankDetailsEvents, SubmitBankDetailsState> {
  final SubmitBankDetailsRepository submitBankDetailsRepository;

  SubmitBankDetailsBloc(this.submitBankDetailsRepository)
    : super(const SubmitBankDetailsState()) {
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<ConfirmAccountNumberChanged>(_onConfirmAccountNumberChanged);
    on<IfscCodeChanged>(_onIfscCodeChanged);
    on<BankNameChanged>(_onBankNameChanged);
    on<AccountHolderNameChanged>(_onAccountHolderNameChanged);
    on<AccountTypeChanged>(_onAccountTypeChanged);
    on<UpiIdChanged>(_onUpiIdChanged);
    on<SubmitBankDetailsApi>(_submitBankDetailsApi);

    // Unfocused events
    on<AccountNumberUnfocused>(_onAccountNumberUnfocused);
    on<ConfirmAccountNumberUnfocused>(_onConfirmAccountNumberUnfocused);
    on<IfscCodeUnfocused>(_onIfscCodeUnfocused);
    on<BankNameUnfocused>(_onBankNameUnfocused);
    on<AccountHolderNameUnfocused>(_onAccountHolderNameUnfocused);
    on<AccountTypeUnfocused>(_onAccountTypeUnfocused);
    on<UpiIdUnfocused>(_onUpiIdUnfocused);
  }

  void _onAccountNumberChanged(
    AccountNumberChanged event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    emit(state.copyWith(accountNumber: event.accountNumber));

    // Clear error when user starts typing
    if (state.accountNumberError.isNotEmpty) {
      emit(state.copyWith(accountNumberError: ''));
    }
  }

  void _onConfirmAccountNumberChanged(
    ConfirmAccountNumberChanged event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    emit(state.copyWith(confirmAccountNumber: event.confirmAccountNumber));

    // Clear error when user starts typing
    if (state.confirmAccountNumberError.isNotEmpty) {
      emit(state.copyWith(confirmAccountNumberError: ''));
    }
  }

  void _onIfscCodeChanged(
    IfscCodeChanged event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    emit(state.copyWith(ifscCode: event.ifscCode.toUpperCase()));

    // Clear error when user starts typing
    if (state.ifscCodeError.isNotEmpty) {
      emit(state.copyWith(ifscCodeError: ''));
    }
  }

  void _onBankNameChanged(
    BankNameChanged event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    emit(state.copyWith(bankName: event.bankName));

    // Clear error when user starts typing
    if (state.bankNameError.isNotEmpty) {
      emit(state.copyWith(bankNameError: ''));
    }
  }

  void _onAccountHolderNameChanged(
    AccountHolderNameChanged event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    emit(state.copyWith(accountHolderName: event.accountHolderName));

    // Clear error when user starts typing
    if (state.accountHolderNameError.isNotEmpty) {
      emit(state.copyWith(accountHolderNameError: ''));
    }
  }

  void _onAccountTypeChanged(
    AccountTypeChanged event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    // Convert to uppercase to match API expectation (SAVINGS / CURRENT)
    emit(state.copyWith(accountType: event.accountType.toUpperCase()));

    if (state.accountTypeError.isNotEmpty) {
      emit(state.copyWith(accountTypeError: ''));
    }
  }

  void _onUpiIdChanged(
    UpiIdChanged event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    emit(state.copyWith(upiId: event.upiId));

    // Clear error when user starts typing
    if (state.upiIdError.isNotEmpty) {
      emit(state.copyWith(upiIdError: ''));
    }
  }

  // Validation on unfocus
  void _onAccountNumberUnfocused(
    AccountNumberUnfocused event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    final error = _validateAccountNumber(state.accountNumber);
    emit(state.copyWith(accountNumberError: error));
  }

  void _onConfirmAccountNumberUnfocused(
    ConfirmAccountNumberUnfocused event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    final error = _validateConfirmAccountNumber(
      state.confirmAccountNumber,
      state.accountNumber,
    );
    emit(state.copyWith(confirmAccountNumberError: error));
  }

  void _onIfscCodeUnfocused(
    IfscCodeUnfocused event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    final error = _validateIfscCode(state.ifscCode);
    emit(state.copyWith(ifscCodeError: error));
  }

  void _onBankNameUnfocused(
    BankNameUnfocused event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    final error = _validateBankName(state.bankName);
    emit(state.copyWith(bankNameError: error));
  }

  void _onAccountHolderNameUnfocused(
    AccountHolderNameUnfocused event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    final error = _validateAccountHolderName(state.accountHolderName);
    emit(state.copyWith(accountHolderNameError: error));
  }

  void _onAccountTypeUnfocused(
    AccountTypeUnfocused event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    final error = _validateAccountType(state.accountType);
    emit(state.copyWith(accountTypeError: error));
  }

  void _onUpiIdUnfocused(
    UpiIdUnfocused event,
    Emitter<SubmitBankDetailsState> emit,
  ) {
    final error = _validateUpiId(state.upiId);
    emit(state.copyWith(upiIdError: error));
  }

  // Validation methods
  String _validateAccountNumber(String accountNumber) {
    if (accountNumber.isEmpty) {
      return 'Account number is required';
    }
    if (accountNumber.length < 9 || accountNumber.length > 18) {
      return 'Account number should be between 9-18 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(accountNumber)) {
      return 'Account number should contain only digits';
    }
    return '';
  }

  String _validateConfirmAccountNumber(
    String confirmAccountNumber,
    String accountNumber,
  ) {
    if (confirmAccountNumber.isEmpty) {
      return 'Please confirm account number';
    }
    if (confirmAccountNumber != accountNumber) {
      return 'Account numbers do not match';
    }
    return '';
  }

  String _validateIfscCode(String ifscCode) {
    if (ifscCode.isEmpty) {
      return 'IFSC code is required';
    }
    if (ifscCode.length != 11) {
      return 'IFSC code should be 11 characters';
    }
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifscCode)) {
      return 'Invalid IFSC code format';
    }
    return '';
  }

  String _validateBankName(String bankName) {
    if (bankName.isEmpty) {
      return 'Bank name is required';
    }
    if (bankName.length < 3) {
      return 'Bank name should be at least 3 characters';
    }
    return '';
  }

  String _validateAccountHolderName(String accountHolderName) {
    if (accountHolderName.isEmpty) {
      return 'Account holder name is required';
    }
    if (accountHolderName.length < 3) {
      return 'Name should be at least 3 characters';
    }
    return '';
  }

  String _validateAccountType(String accountType) {
    if (accountType.isEmpty) {
      return 'Account type is required';
    }
    return '';
  }

  String _validateUpiId(String upiId) {
    if (upiId.isNotEmpty) {
      if (!RegExp(r'^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$').hasMatch(upiId)) {
        return 'Invalid UPI ID format (e.g., username@bank)';
      }
    }
    return '';
  }

  bool _validateForm(SubmitBankDetailsState state) {
    final accountNumberError = _validateAccountNumber(state.accountNumber);
    final confirmAccountNumberError = _validateConfirmAccountNumber(
      state.confirmAccountNumber,
      state.accountNumber,
    );
    final ifscCodeError = _validateIfscCode(state.ifscCode);
    final bankNameError = _validateBankName(state.bankName);
    final accountHolderNameError = _validateAccountHolderName(
      state.accountHolderName,
    );
    final accountTypeError = _validateAccountType(state.accountType);
    final upiIdError = _validateUpiId(state.upiId);

    // ignore: invalid_use_of_visible_for_testing_member
    emit(
      state.copyWith(
        accountNumberError: accountNumberError,
        confirmAccountNumberError: confirmAccountNumberError,
        ifscCodeError: ifscCodeError,
        bankNameError: bankNameError,
        accountHolderNameError: accountHolderNameError,
        accountTypeError: accountTypeError,
        upiIdError: upiIdError,
      ),
    );

    return accountNumberError.isEmpty &&
        confirmAccountNumberError.isEmpty &&
        ifscCodeError.isEmpty &&
        bankNameError.isEmpty &&
        accountHolderNameError.isEmpty &&
        accountTypeError.isEmpty &&
        upiIdError.isEmpty;
  }

  Future<void> _submitBankDetailsApi(
    SubmitBankDetailsApi event,
    Emitter<SubmitBankDetailsState> emit,
  ) async {
    // Validate form before submission
    if (!_validateForm(state)) {
      return;
    }

    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      final Map<String, dynamic> data = {
        "accountNumber": state.accountNumber,
        "confirmAccountNumber": state.confirmAccountNumber,
        "ifscCode": state.ifscCode,
        "bankName": state.bankName,
        "accountHolderName": state.accountHolderName,
        "accountType": state.accountType,
        "upiId": state.upiId,
      };

      final response = await submitBankDetailsRepository.submitBankDetailsApi(
        data,
      );

      if (response.success == true) {
        emit(
          state.copyWith(
            messages: response.message ?? "Bank details submitted successfully",
            postApiStatus: PostApiStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            messages: response.message ?? "Failed to submit bank details",
            postApiStatus: PostApiStatus.error,
          ),
        );
      }
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());

      emit(
        state.copyWith(
          messages: error.toString(),
          postApiStatus: PostApiStatus.error,
        ),
      );
    }
  }
}
