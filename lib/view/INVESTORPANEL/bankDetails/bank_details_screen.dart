import 'package:digifarmer/blocs/INVESTORPANEL/submitBankDetails/submit_bank_details_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/repository/INVESTORPANEL/submitBankDetails/submit_bank_details_http_repository.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../utils/enums.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Focus nodes for validation
  final _accountNumberFocusNode = FocusNode();
  final _confirmAccountNumberFocusNode = FocusNode();
  final _ifscCodeFocusNode = FocusNode();
  final _bankNameFocusNode = FocusNode();
  final _accountHolderNameFocusNode = FocusNode();
  final _upiIdFocusNode = FocusNode();

  // Text editing controllers
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _confirmAccountNumberController =
      TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _accountHolderNameController =
      TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();

  // Dropdown values
  String? _selectedBankName;
  String? _selectedAccountType = 'Savings'; // Default to Savings

  // List of banks
  final List<String> _bankNames = [
    'State Bank of India (SBI)',
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'Kotak Mahindra Bank',
    'Punjab National Bank (PNB)',
    'Bank of Baroda',
    'Canara Bank',
    'Union Bank of India',
    'Yes Bank',
    'IDBI Bank',
    'IndusInd Bank',
  ];

  @override
  void initState() {
    super.initState();
    // Add focus listeners for validation on unfocus
    _accountNumberFocusNode.addListener(_onAccountNumberFocusChange);
    _confirmAccountNumberFocusNode.addListener(
      _onConfirmAccountNumberFocusChange,
    );
    _ifscCodeFocusNode.addListener(_onIfscCodeFocusChange);
    _accountHolderNameFocusNode.addListener(_onAccountHolderNameFocusChange);
    _upiIdFocusNode.addListener(_onUpiIdFocusChange);
  }

  void _onAccountNumberFocusChange() {
    if (!_accountNumberFocusNode.hasFocus && mounted) {
      // Use context from the widget tree
      final bloc = context.read<SubmitBankDetailsBloc>();
      bloc.add(AccountNumberUnfocused());
    }
  }

  void _onConfirmAccountNumberFocusChange() {
    if (!_confirmAccountNumberFocusNode.hasFocus && mounted) {
      final bloc = context.read<SubmitBankDetailsBloc>();
      bloc.add(ConfirmAccountNumberUnfocused());
    }
  }

  void _onIfscCodeFocusChange() {
    if (!_ifscCodeFocusNode.hasFocus && mounted) {
      final bloc = context.read<SubmitBankDetailsBloc>();
      bloc.add(IfscCodeUnfocused());
    }
  }

  void _onAccountHolderNameFocusChange() {
    if (!_accountHolderNameFocusNode.hasFocus && mounted) {
      final bloc = context.read<SubmitBankDetailsBloc>();
      bloc.add(AccountHolderNameUnfocused());
    }
  }

  void _onUpiIdFocusChange() {
    if (!_upiIdFocusNode.hasFocus && mounted) {
      final bloc = context.read<SubmitBankDetailsBloc>();
      bloc.add(UpiIdUnfocused());
    }
  }

  @override
  void dispose() {
    // Remove focus listeners
    _accountNumberFocusNode.removeListener(_onAccountNumberFocusChange);
    _confirmAccountNumberFocusNode.removeListener(
      _onConfirmAccountNumberFocusChange,
    );
    _ifscCodeFocusNode.removeListener(_onIfscCodeFocusChange);
    _accountHolderNameFocusNode.removeListener(_onAccountHolderNameFocusChange);
    _upiIdFocusNode.removeListener(_onUpiIdFocusChange);

    // Dispose focus nodes
    _accountNumberFocusNode.dispose();
    _confirmAccountNumberFocusNode.dispose();
    _ifscCodeFocusNode.dispose();
    _bankNameFocusNode.dispose();
    _accountHolderNameFocusNode.dispose();
    _upiIdFocusNode.dispose();

    // Dispose controllers
    _accountNumberController.dispose();
    _confirmAccountNumberController.dispose();
    _ifscCodeController.dispose();
    _accountHolderNameController.dispose();
    _upiIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Bank Details',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: BlocProvider(
        create: (_) => SubmitBankDetailsBloc(SubmitBankDetailsHttpRepository()),
        child: BlocListener<SubmitBankDetailsBloc, SubmitBankDetailsState>(
          listenWhen: (previous, current) =>
              previous.postApiStatus != current.postApiStatus,
          listener: (context, state) {
            if (state.postApiStatus == PostApiStatus.error) {
              FlushBarHelper.flushBarErrorMessage(state.messages, context);
            }
            if (state.postApiStatus == PostApiStatus.success) {
              FlushBarHelper.flushBarSuccessMessage(state.messages, context);
              // Navigate to next screen after successful submission
              Navigator.pushNamed(context, RoutesName.uploadDocumentScreen);
            }
          },
          child: BlocBuilder<SubmitBankDetailsBloc, SubmitBankDetailsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Progress Indicator
                        _buildProgressIndicator(),
                        const SizedBox(height: 24),

                        // Description
                        const Text(
                          'Secure bank account information for payments and transactions',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Bank Details Form
                        _buildBankDetailsForm(state, context),
                        const SizedBox(height: 24),

                        // UPI Details Section (Optional)
                        _buildUpiDetailsSection(state, context),
                        const SizedBox(height: 24),

                        // Security Note
                        _buildSecurityNote(),
                        const SizedBox(height: 32),

                        // Submit Button
                        _buildSubmitButton(state, context),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(2),
          ),
          child: const FractionallySizedBox(
            widthFactor: 1.0,
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(2),
                    right: Radius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Step 2 of 2 • 100%',
          style: TextStyle(
            fontSize: 14,
            color: Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBankDetailsForm(
    SubmitBankDetailsState state,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Number
            _buildTextField(
              controller: _accountNumberController,
              focusNode: _accountNumberFocusNode,
              label: 'Account Number *',
              hint: 'Enter account number',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              errorText: state.accountNumberError.isNotEmpty
                  ? state.accountNumberError
                  : null,
              onChanged: (value) {
                context.read<SubmitBankDetailsBloc>().add(
                  AccountNumberChanged(accountNumber: value),
                );
              },
            ),
            const SizedBox(height: 16),

            // Confirm Account Number
            _buildTextField(
              controller: _confirmAccountNumberController,
              focusNode: _confirmAccountNumberFocusNode,
              label: 'Confirm Account Number *',
              hint: 'Re-enter account number',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              errorText: state.confirmAccountNumberError.isNotEmpty
                  ? state.confirmAccountNumberError
                  : null,
              onChanged: (value) {
                context.read<SubmitBankDetailsBloc>().add(
                  ConfirmAccountNumberChanged(confirmAccountNumber: value),
                );
              },
            ),
            const SizedBox(height: 16),

            // IFSC Code
            _buildTextField(
              controller: _ifscCodeController,
              focusNode: _ifscCodeFocusNode,
              label: 'IFSC Code *',
              hint: 'SBIN0001234',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                LengthLimitingTextInputFormatter(11),
              ],
              errorText: state.ifscCodeError.isNotEmpty
                  ? state.ifscCodeError
                  : null,
              onChanged: (value) {
                context.read<SubmitBankDetailsBloc>().add(
                  IfscCodeChanged(ifscCode: value),
                );
              },
            ),
            const SizedBox(height: 16),

            // Bank Name Dropdown
            DropdownButtonFormField<String>(
              value: _selectedBankName,
              decoration: InputDecoration(
                labelText: 'Bank Name *',
                labelStyle: TextStyle(color: Colors.grey.shade600),
                floatingLabelStyle: const TextStyle(color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              items: _bankNames.map((String bank) {
                return DropdownMenuItem<String>(value: bank, child: Text(bank));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBankName = value;
                });
                if (value != null) {
                  context.read<SubmitBankDetailsBloc>().add(
                    BankNameChanged(bankName: value),
                  );
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select bank name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Account Holder Name
            _buildTextField(
              controller: _accountHolderNameController,
              focusNode: _accountHolderNameFocusNode,
              label: 'Account Holder Name *',
              hint: 'Name as per bank account',
              textCapitalization: TextCapitalization.words,
              errorText: state.accountHolderNameError.isNotEmpty
                  ? state.accountHolderNameError
                  : null,
              onChanged: (value) {
                context.read<SubmitBankDetailsBloc>().add(
                  AccountHolderNameChanged(accountHolderName: value),
                );
              },
            ),
            const SizedBox(height: 16),

            // Account Type Radio Buttons
            Text(
              'Account Type *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Savings'),
                    value: 'Savings',
                    groupValue: _selectedAccountType,
                    onChanged: (value) {
                      setState(() {
                        _selectedAccountType = value;
                      });
                      if (value != null) {
                        context.read<SubmitBankDetailsBloc>().add(
                          AccountTypeChanged(accountType: value),
                        );
                      }
                    },
                    activeColor: Colors.green,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Current'),
                    value: 'Current',
                    groupValue: _selectedAccountType,
                    onChanged: (value) {
                      setState(() {
                        _selectedAccountType = value;
                      });
                      if (value != null) {
                        context.read<SubmitBankDetailsBloc>().add(
                          AccountTypeChanged(accountType: value),
                        );
                      }
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpiDetailsSection(
    SubmitBankDetailsState state,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'UPI Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Optional',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _upiIdController,
              focusNode: _upiIdFocusNode,
              label: 'UPI ID',
              hint: 'yourname@paytm',
              keyboardType: TextInputType.emailAddress,
              errorText: state.upiIdError.isNotEmpty ? state.upiIdError : null,
              onChanged: (value) {
                context.read<SubmitBankDetailsBloc>().add(
                  UpiIdChanged(upiId: value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? errorText,
    Function(String)? onChanged,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        floatingLabelStyle: const TextStyle(color: Colors.green),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      textCapitalization: textCapitalization,
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.security, color: Colors.blue.shade700, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bank Grade Security',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'All banking information is encrypted with 256-bit SSL and stored securely as per RBI guidelines.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(
    SubmitBankDetailsState state,
    BuildContext context,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state.postApiStatus == PostApiStatus.loading
            ? null
            : () {
                // Manually validate the form before submission
                if (_formKey.currentState?.validate() ?? false) {
                  // Trigger form submission
                  context.read<SubmitBankDetailsBloc>().add(
                    SubmitBankDetailsApi(),
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: state.postApiStatus == PostApiStatus.loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Complete KYC Setup',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
