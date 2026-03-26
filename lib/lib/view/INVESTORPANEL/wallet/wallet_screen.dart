import 'package:flutter/material.dart';

import '../../../config/routes/routes_name.dart';
import '../../../res/color/app_colors.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/customeWidgets/round_button.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/flush_bar_helper.dart';

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
      appBar: CustomAppBar(
        title: 'Withdraw Funds',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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

            _addNewBank(() {
              FlushBarHelper.flushBarSuccessMessage(
                "This will Be work after integrating payment gateway",
                context,
              );
            }),

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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1C5D9F), Color(0xff2FA463)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                "Available Balance",
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: AppFonts.popins,
                ),
              ),
              RoundButton(
                width: 70,
                height: 30,
                fontSize: 12,
                buttonColor: AppColors.whiteColor.withValues(alpha: 0.2),
                title: 'Status',
                onPress: () {
                  Navigator.pushNamed(context, RoutesName.withdrawScreen);
                },
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            "₹1,24,500",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Locked Amount: ₹75,000\nWithdrawable: ₹49,500",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontFamily: AppFonts.popins,
            ),
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
            fontFamily: AppFonts.popins,
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  Text(
                    account,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xff1E8E5A),
                        fontSize: 12,
                        fontFamily: AppFonts.popins,
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

  Widget _addNewBank(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
        ),
        child: const Center(
          child: Text(
            "+ Add New Bank Account",
            style: TextStyle(color: Colors.grey, fontFamily: AppFonts.popins),
          ),
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
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.popins,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "• Processing time: 2-3 business days\n"
            "• No withdrawal charges\n"
            "• Minimum withdrawal ₹500",
            style: TextStyle(fontSize: 12, fontFamily: AppFonts.popins),
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
            onPressed: () {
              FlushBarHelper.flushBarSuccessMessage(
                "This will Be work after integrating payment gateway",
                context,
              );
            },
            child: Text(
              "Proceed to Withdraw",
              style: TextStyle(
                fontFamily: AppFonts.popins,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
