import 'package:digifarmer/res/color/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedMethod = 0;
  final TextEditingController upiController = TextEditingController();

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
                SizedBox(height: 20),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.help_outline, color: Colors.white),
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
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "₹25,000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Organic Rice Farm",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                    style: TextStyle(fontWeight: FontWeight.bold),
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

                  /// UPI DETAILS (Only if selected)
                  if (selectedMethod == 0) ...[
                    const Text(
                      "Enter UPI Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                          const Text("UPI ID", style: TextStyle(fontSize: 12)),
                          const SizedBox(height: 6),
                          TextField(
                            controller: upiController,
                            decoration: const InputDecoration(
                              hintText: "yourname@upi",
                              border: InputBorder.none,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Enter your registered UPI ID",
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text("Or pay using UPI Apps"),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _upiApp("G", "Google Pay", Colors.green),
                        _upiApp("P", "PhonePe", Colors.purple),
                        _upiApp("P", "Paytm", Colors.blue),
                      ],
                    ),
                  ],

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
                            style: TextStyle(fontSize: 12),
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
                      Text("Amount to Pay"),
                      Text(
                        "Processing Fee",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹25,000",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Free",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// PAY BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "🔒 Pay Securely",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "By proceeding, you agree to our Terms & Conditions",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
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

  /// Payment Option Widget
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
              Icons.account_balance_wallet,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
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

  /// UPI App Button
  Widget _upiApp(String letter, String name, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color,
          child: Text(
            letter,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
