import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final TextEditingController _amountController = TextEditingController(
    text: "0",
  );

  int selectedBankIndex = 0;
  int selectedQuickAmount = -1;

  final List<int> quickAmounts = [5000, 10000, 25000, 50000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff1E8E5A),
        title: const Text("Withdraw Funds"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Balance Card
            _balanceCard(),

            const SizedBox(height: 20),

            /// Withdrawal Amount
            const Text(
              "Withdrawal Amount",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: "₹ ",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Min: ₹500",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "Withdraw Max",
                  style: TextStyle(
                    color: Color(0xff1E8E5A),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Quick Select
            const Text(
              "Quick Select",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: List.generate(
                quickAmounts.length,
                (index) => _quickAmountButton(index),
              ),
            ),

            const SizedBox(height: 25),

            /// Bank Selection
            const Text(
              "Select Bank Account",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            _bankTile(
              index: 0,
              bankName: "HDFC Bank",
              account: "**** 4567",
              subtitle: "Primary Account",
            ),

            const SizedBox(height: 12),

            _bankTile(index: 1, bankName: "ICICI Bank", account: "**** 8901"),

            const SizedBox(height: 12),

            _addNewBank(),

            const SizedBox(height: 20),

            /// Info Box
            _infoBox(),

            const SizedBox(height: 20),

            /// Bottom Section
            _bottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _balanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff1E8E5A), Color(0xff2BB673)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Available Balance", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 6),
          Text(
            "₹1,24,500",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Locked Amount: ₹75,000\nWithdrawable: ₹49,500",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _quickAmountButton(int index) {
    final isSelected = selectedQuickAmount == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedQuickAmount = index;
          _amountController.text = quickAmounts[index].toString();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff1E8E5A) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "₹${quickAmounts[index] ~/ 1000}K",
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _bankTile({
    required int index,
    required String bankName,
    required String account,
    String? subtitle,
  }) {
    final isSelected = selectedBankIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBankIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xff1E8E5A) : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.account_balance, color: Colors.blueGrey),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bankName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(account, style: const TextStyle(color: Colors.grey)),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xff1E8E5A),
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? const Color(0xff1E8E5A) : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _addNewBank() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: const Center(
        child: Text(
          "+ Add New Bank Account",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _infoBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Withdrawal Information",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text(
            "• Processing time: 2-3 business days\n"
            "• No withdrawal charges\n"
            "• Minimum withdrawal ₹500",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _bottomSection() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("You will receive"), Text("₹0")],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2BB673),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text("Proceed to Withdraw"),
          ),
        ),
      ],
    );
  }
}
