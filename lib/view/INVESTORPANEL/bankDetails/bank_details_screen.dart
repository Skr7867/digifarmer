import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

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

  // List of banks (you can expand this)
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
  void dispose() {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Bank Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
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
                _buildBankDetailsForm(),
                const SizedBox(height: 24),

                // UPI Details Section (Optional)
                _buildUpiDetailsSection(),
                const SizedBox(height: 24),

                // Security Note
                _buildSecurityNote(),
                const SizedBox(height: 32),

                // Submit Button
                _buildSubmitButton(),
                const SizedBox(height: 20),
              ],
            ),
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
          child: FractionallySizedBox(
            widthFactor: 1.0, // 100% complete
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Step 4 of 4 • 100%',
          style: TextStyle(
            fontSize: 14,
            color: Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBankDetailsForm() {
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
              label: 'Account Number *',
              hint: 'Enter account number',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter account number';
                }
                if (value.length < 9 || value.length > 18) {
                  return 'Account number should be between 9-18 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Confirm Account Number
            _buildTextField(
              controller: _confirmAccountNumberController,
              label: 'Confirm Account Number *',
              hint: 'Re-enter account number',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm account number';
                }
                if (value != _accountNumberController.text) {
                  return 'Account numbers do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // IFSC Code
            _buildTextField(
              controller: _ifscCodeController,
              label: 'IFSC Code *',
              hint: 'SBIN0001234',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                LengthLimitingTextInputFormatter(11),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter IFSC code';
                }
                if (value.length != 11) {
                  return 'IFSC code should be 11 characters';
                }
                return null;
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
              label: 'Account Holder Name *',
              hint: 'Name as per bank account',
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter account holder name';
                }
                if (value.length < 3) {
                  return 'Please enter valid name';
                }
                return null;
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

  Widget _buildUpiDetailsSection() {
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
              label: 'UPI ID',
              hint: 'yourname@paytm',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (!value.contains('@')) {
                    return 'Please enter valid UPI ID';
                  }
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        floatingLabelStyle: const TextStyle(color: Colors.green),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
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
      validator: validator,
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

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.uploadDocumentScreen);
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
        child: const Text(
          'Complete KYC Setup',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
