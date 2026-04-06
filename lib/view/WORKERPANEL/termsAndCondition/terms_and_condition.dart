import 'package:flutter/material.dart';

import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  TextStyle _titleStyle() {
    return const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: AppFonts.popins,
    );
  }

  TextStyle _headingStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: AppFonts.popins,
    );
  }

  TextStyle _bodyStyle() {
    return const TextStyle(
      fontSize: 14,
      height: 1.6,
      fontFamily: AppFonts.popins,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Terms & Conditions',
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
            /// Title
            Text("Terms & Conditions", style: _titleStyle()),
            const SizedBox(height: 8),

            Text("Effective Date: February 26, 2026", style: _bodyStyle()),

            const SizedBox(height: 20),

            /// 1
            Text("1. Agreement to Terms", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "By accessing or using our platform, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you may not access the platform.",
              style: _bodyStyle(),
            ),

            const SizedBox(height: 20),

            /// 2
            Text("2. Investment Risks", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "Agricultural investments involve risks, including but not limited to weather conditions, market prices, and regulatory changes. Past performance is not indicative of future results. You should carefully consider your financial situation and consult with financial advisors before making any investment.",
              style: _bodyStyle(),
            ),

            const SizedBox(height: 20),

            /// 3
            Text("3. User Accounts", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "You are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer. You agree to accept responsibility for all activities that occur under your account or password.",
              style: _bodyStyle(),
            ),

            const SizedBox(height: 20),

            /// 4
            Text("4. Intellectual Property", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "The platform and its original content, features, and functionality are and will remain the exclusive property of DigiFarmer and its licensors. Our trademarks and trade dress may not be used in connection with any product or service without the prior written consent of DigiFarmer.",
              style: _bodyStyle(),
            ),

            const SizedBox(height: 20),

            /// 5
            Text("5. Limitation of Liability", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "In no event shall DigiFarmer, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses.",
              style: _bodyStyle(),
            ),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 20),

            /// 6
            Text("6. Governing Law", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "These Terms shall be governed and construed in accordance with the laws of Kenya, without regard to its conflict of law provisions.",
              style: _bodyStyle(),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
