import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../res/color/app_colors.dart';

class NewInvestmentScreen extends StatefulWidget {
  const NewInvestmentScreen({super.key});

  @override
  State<NewInvestmentScreen> createState() => _NewInvestmentScreenState();
}

class _NewInvestmentScreenState extends State<NewInvestmentScreen> {
  int selectedTenure = 3;
  double investmentAmount = 25000;

  final Map<int, double> interestRates = {2: 10, 3: 12, 5: 14};

  double calculateReturns() {
    double rate = interestRates[selectedTenure]! / 100;
    return investmentAmount * rate * selectedTenure;
  }

  double calculateMaturity() {
    return investmentAmount + calculateReturns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xffE6F4EA),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.eco, color: Colors.green),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Organic Rice Farm",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                        Text(
                          "Maharashtra",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),

              const SizedBox(height: 20),

              /// STEP INDICATOR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _stepCircle("1", true),
                        _stepLine(),
                        _stepCircle("2", false),
                        _stepLine(),
                        _stepCircle("3", false),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// ENTER INVESTMENT
                    const Text(
                      "Enter Investment Amount",
                      style: TextStyle(
                        fontFamily: AppFonts.popins,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Choose how much you want to invest",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: AppFonts.popins,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// AMOUNT BOX
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.25),
                        ),
                        color: const Color(0xffE9EEF5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Investment Amount",
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "₹ ${investmentAmount.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// MIN MAX
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Minimum ₹5,000",
                          style: TextStyle(fontFamily: AppFonts.popins),
                        ),
                        Text(
                          "Maximum ₹1,00,000",
                          style: TextStyle(fontFamily: AppFonts.popins),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// QUICK AMOUNT BUTTONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _amountButton(10000),
                        _amountButton(25000),
                        _amountButton(50000),
                        _amountButton(100000),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// TENURE
                    const Text(
                      "Select Investment Tenure",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Higher tenure offers better returns",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: AppFonts.popins,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _tenureCard(2),
                    const SizedBox(height: 12),
                    _tenureCard(3, popular: true),
                    const SizedBox(height: 12),
                    _tenureCard(5),

                    const SizedBox(height: 20),

                    /// INFO BOX
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF4DB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info, color: Colors.orange),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Yearly Compounding\nReturns are compounded annually. Your investment grows faster with longer tenure periods.",
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// TOTAL SECTION
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total Investment"),
                              Text(
                                "₹ ${investmentAmount.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Expected Returns",
                                style: TextStyle(fontFamily: AppFonts.popins),
                              ),
                              Text(
                                "₹ ${calculateReturns().toStringAsFixed(0)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// CONTINUE BUTTON
                    RoundButton(
                      width: double.infinity,
                      buttonColor: AppColors.greenColor,
                      title: 'Continue to review',
                      onPress: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.proceedPaymentScreen,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _amountButton(double amount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          investmentAmount = amount;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          "₹${(amount / 1000).toStringAsFixed(0)}K",
          style: TextStyle(fontFamily: AppFonts.popins),
        ),
      ),
    );
  }

  Widget _tenureCard(int year, {bool popular = false}) {
    bool isSelected = selectedTenure == year;
    double rate = interestRates[year]!;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTenure = year;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: year,
                  // ignore: deprecated_member_use
                  groupValue: selectedTenure,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      selectedTenure = value!;
                    });
                  },
                ),
                Text(
                  "$year Years",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const Spacer(),

                Text(
                  "$rate% per annum",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const SizedBox(width: 6),
                if (popular)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Popular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xffE8F5E9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _rowData(
                    "Estimated Returns",
                    "₹ ${calculateReturns().toStringAsFixed(0)}",
                  ),
                  const SizedBox(height: 6),
                  _rowData(
                    "Maturity Amount",
                    "₹ ${calculateMaturity().toStringAsFixed(0)}",
                    isGreen: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowData(String title, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isGreen ? Colors.green : Colors.black,
            fontFamily: AppFonts.popins,
          ),
        ),
      ],
    );
  }

  Widget _stepCircle(String text, bool active) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.blue : Colors.grey.shade300,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.popins,
          ),
        ),
      ),
    );
  }

  Widget _stepLine() {
    return Container(width: 40, height: 2, color: Colors.grey.shade300);
  }
}
