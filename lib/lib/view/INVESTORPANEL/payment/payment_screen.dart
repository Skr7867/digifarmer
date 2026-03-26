import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../config/routes/routes_name.dart';
import '../../../res/color/app_colors.dart';
import '../../../res/customeWidgets/round_button.dart';
import '../../../res/fonts/app_fonts.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedMethod = 0;
  final TextEditingController upiController = TextEditingController();

  // Credit/Debit Card Controllers
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  // Net Banking Controllers
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();

  bool isCardSaved = false;

  @override
  void dispose() {
    upiController.dispose();
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    bankNameController.dispose();
    accountNumberController.dispose();
    ifscCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: Column(
        children: [
          /// 🔵 TOP HEADER
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff2F80ED), Color(0xff1C5DC9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Payment Method",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.help_outline, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 20),

                /// Amount Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "₹25,000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Investment",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Organic Rice Farm",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🟢 BODY CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Payment Method",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _paymentOption(0, "UPI Payment", "Pay using UPI ID or Apps"),
                  _paymentOption(
                    1,
                    "Credit/Debit Card",
                    "Visa, Mastercard, RuPay",
                  ),
                  _paymentOption(2, "Net Banking", "All major banks supported"),
                  _paymentOption(3, "Scan QR Code", "Scan & Pay instantly"),

                  const SizedBox(height: 20),

                  /// UPI DETAILS
                  if (selectedMethod == 0) _buildUPIPayment(),

                  /// CREDIT/DEBIT CARD DETAILS
                  if (selectedMethod == 1) _buildCardPayment(),

                  /// NET BANKING DETAILS
                  if (selectedMethod == 2) _buildNetBanking(),

                  /// SCAN QR CODE
                  if (selectedMethod == 3) _buildQRPayment(),

                  const SizedBox(height: 20),

                  /// Secure Payment Box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xffE8F5E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.lock, color: Colors.green),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "100% Secure Payment\nYour payment information is encrypted and secure.",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Amount to Pay Section
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount to Pay",
                        style: TextStyle(fontFamily: AppFonts.popins),
                      ),
                      Text(
                        "Processing Fee",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹25,000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      Text(
                        "Free",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// PAY BUTTON
                  RoundButton(
                    width: double.infinity,
                    title: "🔒 Pay Securely",
                    buttonColor: AppColors.greenColor,
                    onPress: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.paymentSucessScreen,
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "By proceeding, you agree to our Terms & Conditions",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUPIPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enter UPI Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "UPI ID",
                style: TextStyle(fontSize: 12, fontFamily: AppFonts.popins),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: upiController,
                decoration: const InputDecoration(
                  hintText: "yourname@upi",
                  hintStyle: TextStyle(fontFamily: AppFonts.popins),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontFamily: AppFonts.popins),
              ),
              const SizedBox(height: 6),
              const Text(
                "Enter your registered UPI ID",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          "Or pay using UPI Apps",
          style: TextStyle(fontFamily: AppFonts.popins),
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _upiApp("G", "Google Pay", Colors.green, () => _openUpiApp("gpay")),
            _upiApp(
              "P",
              "PhonePe",
              Colors.purple,
              () => _openUpiApp("phonepe"),
            ),
            _upiApp("P", "Paytm", Colors.blue, () => _openUpiApp("paytm")),
          ],
        ),
      ],
    );
  }

  Widget _buildCardPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enter Card Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              TextField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ],
                decoration: const InputDecoration(
                  labelText: "Card Number",
                  hintText: "1234 5678 9012 3456",
                  prefixIcon: Icon(Icons.credit_card),
                  labelStyle: TextStyle(fontFamily: AppFonts.popins),
                  hintStyle: TextStyle(fontFamily: AppFonts.popins),
                ),
                style: const TextStyle(fontFamily: AppFonts.popins),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: cardHolderNameController,
                decoration: const InputDecoration(
                  labelText: "Card Holder Name",
                  hintText: "John Doe",
                  prefixIcon: Icon(Icons.person),
                  labelStyle: TextStyle(fontFamily: AppFonts.popins),
                  hintStyle: TextStyle(fontFamily: AppFonts.popins),
                ),
                style: const TextStyle(fontFamily: AppFonts.popins),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: expiryDateController,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: const InputDecoration(
                        labelText: "MM/YY",
                        hintText: "12/25",
                        prefixIcon: Icon(Icons.calendar_today),
                        labelStyle: TextStyle(fontFamily: AppFonts.popins),
                        hintStyle: TextStyle(fontFamily: AppFonts.popins),
                      ),
                      style: const TextStyle(fontFamily: AppFonts.popins),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: cvvController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      decoration: const InputDecoration(
                        labelText: "CVV",
                        hintText: "123",
                        prefixIcon: Icon(Icons.lock),
                        labelStyle: TextStyle(fontFamily: AppFonts.popins),
                        hintStyle: TextStyle(fontFamily: AppFonts.popins),
                      ),
                      style: const TextStyle(fontFamily: AppFonts.popins),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: isCardSaved,
                    onChanged: (value) {
                      setState(() {
                        isCardSaved = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    "Save card for future payments",
                    style: TextStyle(fontFamily: AppFonts.popins),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNetBanking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Net Banking Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              TextField(
                controller: bankNameController,
                decoration: const InputDecoration(
                  labelText: "Bank Name",
                  hintText: "State Bank of India",
                  prefixIcon: Icon(Icons.account_balance),
                  labelStyle: TextStyle(fontFamily: AppFonts.popins),
                  hintStyle: TextStyle(fontFamily: AppFonts.popins),
                ),
                style: const TextStyle(fontFamily: AppFonts.popins),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: accountNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Account Number",
                  hintText: "1234567890",
                  prefixIcon: Icon(Icons.numbers),
                  labelStyle: TextStyle(fontFamily: AppFonts.popins),
                  hintStyle: TextStyle(fontFamily: AppFonts.popins),
                ),
                style: const TextStyle(fontFamily: AppFonts.popins),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ifscCodeController,
                decoration: const InputDecoration(
                  labelText: "IFSC Code",
                  hintText: "SBIN0012345",
                  prefixIcon: Icon(Icons.code),
                  labelStyle: TextStyle(fontFamily: AppFonts.popins),
                  hintStyle: TextStyle(fontFamily: AppFonts.popins),
                ),
                style: const TextStyle(fontFamily: AppFonts.popins),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQRPayment() {
    // Dummy payment details for QR
    final qrData =
        "upi://pay?pa=digifarmer@okhdfcbank&pn=DigiFarmer&am=25000&tn=Investment Payment";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Scan QR Code to Pay",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Scan this QR code using any UPI app",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
                gapless: false,
                errorStateBuilder: (cxt, err) {
                  return const Icon(Icons.qr_code, size: 100);
                },
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Payment Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _detailRow("Amount", "₹25,000"),
                    _detailRow("Payee", "DigiFarmer"),
                    _detailRow("UPI ID", "digifarmer@okhdfcbank"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _openUpiApp("any");
                  },
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text(
                    "Open UPI App to Scan",
                    style: TextStyle(fontFamily: AppFonts.popins),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentOption(int index, String title, String subtitle) {
    bool isSelected = selectedMethod == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              index == 0
                  ? Icons.account_balance_wallet
                  : index == 1
                  ? Icons.credit_card
                  : index == 2
                  ? Icons.account_balance
                  : Icons.qr_code_scanner,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _upiApp(String letter, String name, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color,
            child: Text(
              letter,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.popins,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(fontSize: 12, fontFamily: AppFonts.popins),
          ),
        ],
      ),
    );
  }

  void _openUpiApp(String appName) {
    // ignore: unused_local_variable
    String upiUrl = "";

    switch (appName) {
      case "gpay":
        upiUrl = "gpay://";
        break;
      case "phonepe":
        upiUrl = "phonepe://";
        break;
      case "paytm":
        upiUrl = "paytm://";
        break;
      default:
        upiUrl = "upi://";
    }

    // Construct UPI payment intent

    try {
      // Show dialog with UPI intent
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Open UPI App",
            style: TextStyle(fontFamily: AppFonts.popins),
          ),
          content: const Text(
            "Would you like to open the UPI app to complete payment?",
            style: TextStyle(fontFamily: AppFonts.popins),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(fontFamily: AppFonts.popins),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Here you would launch the UPI intent
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Opening UPI app...",
                      style: TextStyle(fontFamily: AppFonts.popins),
                    ),
                  ),
                );
              },
              child: const Text(
                "Open",
                style: TextStyle(fontFamily: AppFonts.popins),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please install $appName app",
            style: const TextStyle(fontFamily: AppFonts.popins),
          ),
        ),
      );
    }
  }
}
