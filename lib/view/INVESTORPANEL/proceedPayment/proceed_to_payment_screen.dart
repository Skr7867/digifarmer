import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/color/app_colors.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

import 'investment_growth_screen.dart';

class ProceedToPaymentScreen extends StatelessWidget {
  const ProceedToPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 2, 34, 75), Color(0xff1C5DC9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(height: 80),
                      Icon(Icons.arrow_back, color: Colors.white),
                      SizedBox(width: 12),

                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.energy_savings_leaf_sharp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Organic Rice Farm",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                          Text(
                            "Maharashtra",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.share, color: Colors.white),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Investment Amount",
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
                                fontSize: 20,
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
                              "Tenure Selected",
                              style: TextStyle(
                                color: Colors.white70,
                                fontFamily: AppFonts.popins,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "3 Years",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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

            const SizedBox(height: 20),

            /// 🟢 SUMMARY CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 170,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: const Color(0xffE8F5E9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.greenColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.greenColor.withValues(alpha: .24),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.trending_up, color: Colors.green),
                      ),
                      title: Text(
                        "Maturity Amount",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      subtitle: const Text(
                        "₹35,123",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.popins,
                        ),
                      ),

                      trailing: Column(
                        children: [
                          SizedBox(height: 9),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              '+40.49',
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontFamily: AppFonts.popinsBold,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Total Growth',
                            style: TextStyle(
                              fontFamily: AppFonts.popins,
                              color: Colors.blueGrey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Returns",
                            style: TextStyle(fontFamily: AppFonts.popins),
                          ),
                          Text(
                            "₹10,123",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Annual ROI",
                            style: TextStyle(fontFamily: AppFonts.popins),
                          ),
                          Text(
                            "12%",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// 📈 Investment Growth Projection
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Investment Growth Projection",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
            const SizedBox(height: 12),

            AttractivePieChart(),

            const SizedBox(height: 24),

            /// 📅 Year-wise Breakdown
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Year-wise Breakdown",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
            const SizedBox(height: 12),

            _yearCard(
              "1",
              "Year 1",
              "Dec 2024 - Dec 2025",
              "₹28,000",
              "+₹3,000",
            ),

            _yearCard(
              "2",
              "Year 2",
              "Dec 2025 - Dec 2026",
              "₹31,360",
              "+₹3,360",
            ),

            _yearCard(
              "3",
              "Year 3 (Maturity)",
              "Dec 2026 - Dec 2027",
              "₹35,123",
              "+₹3,763",
            ),

            const SizedBox(height: 24),

            // Investment Features
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Investment Features",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: const [
                  _FeatureCard(
                    Icons.security,
                    "Secured",
                    "Insurance Protected",
                  ),
                  _FeatureCard(Icons.eco, "Organic", "Sustainable Farming"),
                  _FeatureCard(
                    Icons.visibility,
                    "Transparent",
                    "Real-time Updates",
                  ),
                  _FeatureCard(
                    Icons.phone_android,
                    "Digital",
                    "Easy Management",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// ✅ Ready to Invest
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xffE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Ready to Invest?\nSecure your investment in sustainable farming today.",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 🟢 PROCEED BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RoundButton(
                buttonColor: AppColors.greenColor,
                width: double.infinity,
                title: 'Proceed to payment',
                onPress: () {
                  Navigator.pushNamed(context, RoutesName.paymentScreen);
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  static Widget _yearCard(
    String number,
    String title,
    String subtitle,
    String amount,
    String profit,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔵 Number Circle
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xffE3F2FD),
              child: Text(
                number,
                style: const TextStyle(fontFamily: AppFonts.popins),
              ),
            ),

            const SizedBox(width: 12),

            /// 📅 Title + Subtitle Section
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
                    subtitle, // 👈 Dec 2024 - Dec 2025
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ],
              ),
            ),

            /// 💰 Amount Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profit,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureCard(this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.green),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }
}
