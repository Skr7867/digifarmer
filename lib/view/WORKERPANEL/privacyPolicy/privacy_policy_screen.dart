import 'package:flutter/material.dart';

import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
        title: 'Privacy Policy',
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
            Text("Privacy Policy", style: _titleStyle()),
            const SizedBox(height: 8),

            Text("Last Updated: February 26, 2026", style: _bodyStyle()),

            const SizedBox(height: 20),

            /// 1. Introduction
            Text("1. Introduction", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "Welcome to DigiFarmer. We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about our policy, or our practices with regards to your personal information, please contact us.",
              style: _bodyStyle(),
            ),

            const SizedBox(height: 20),

            /// 2. Information We Collect
            Text("2. Information We Collect", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "We collect personal information that you voluntarily provide to us when registering at the platform, expressing an interest in obtaining information about us or our products and services, when participating in activities on the platform or otherwise contacting us.",
              style: _bodyStyle(),
            ),

            const SizedBox(height: 10),

            _bullet(
              "Name and Contact Data (Name, email address, phone number).",
            ),
            _bullet(
              "Credentials (Passwords and similar security information).",
            ),
            _bullet(
              "Financial Data (Information necessary to process your investment).",
            ),

            const SizedBox(height: 20),

            /// 3. How We Use Your Information
            Text("3. How We Use Your Information", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "We use personal information collected via our platform for a variety of business purposes. We process your personal information for these purposes in reliance on our legitimate business interests, in order to enter into or perform a contract with you, with your consent, and/or for compliance with our legal obligations.",
              style: _bodyStyle(),
            ),

            const SizedBox(height: 20),

            /// 4. Sharing Your Information
            Text("4. Sharing Your Information", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "We only share information with your consent, to comply with laws, to provide you with services, to protect your rights, or to fulfill business obligations.",
              style: _bodyStyle(),
            ),

            const SizedBox(height: 20),

            /// 5. Security
            Text("5. Security of Your Information", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "We use administrative, technical, and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable.",
              style: _bodyStyle(),
            ),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 20),

            /// 6. Contact Us
            Text("6. Contact Us", style: _headingStyle()),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.justify,
              "If you have questions or comments about this policy, you may email us at info@digifarmer.com",
              style: _bodyStyle(),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  /// Bullet Widget
  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            textAlign: TextAlign.justify,
            "• ",
            style: TextStyle(fontFamily: AppFonts.popins),
          ),
          Expanded(child: Text(text, style: _bodyStyle())),
        ],
      ),
    );
  }
}
