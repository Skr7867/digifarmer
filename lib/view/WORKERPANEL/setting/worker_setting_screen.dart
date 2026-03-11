import 'package:digifarmer/view/WORKERPANEL/helpAndSupport/help_and_support_screen.dart';
import 'package:flutter/material.dart';

class WorkerSettingScreen extends StatelessWidget {
  const WorkerSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// -------- Account Section ----------
            _sectionCard(
              title: "Account",
              children: [
                _tile(icon: Icons.person, text: "Edit Profile"),
                _tile(icon: Icons.verified_user, text: "KYC Documents"),
                _tile(icon: Icons.account_balance, text: "Bank Details"),
              ],
            ),

            const SizedBox(height: 14),

            /// -------- App Preference ----------
            _sectionCard(
              title: "App Preferences",
              children: [
                _tile(
                  icon: Icons.language,
                  text: "Language",
                  subtitle: "English",
                ),
                _switchTile(
                  icon: Icons.dark_mode,
                  text: "Dark Mode",
                  subtitle: "Switch to dark theme",
                  value: false,
                ),
                _tile(
                  icon: Icons.palette,
                  text: "Theme",
                  subtitle: "Green & Blue",
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// -------- Notifications ----------
            _sectionCard(
              title: "Notifications",
              children: [
                _switchTile(
                  icon: Icons.show_chart,
                  text: "Investment Updates",
                  subtitle: "Portfolio and maturity alerts",
                  value: true,
                ),
                _switchTile(
                  icon: Icons.payment,
                  text: "Payment Alerts",
                  subtitle: "Transaction confirmations",
                  value: true,
                ),
                _switchTile(
                  icon: Icons.agriculture,
                  text: "Farm Progress",
                  subtitle: "Crop updates and milestones",
                  value: true,
                ),
                _switchTile(
                  icon: Icons.warning,
                  text: "Security Alerts",
                  subtitle: "Login and account security",
                  value: true,
                ),
                _switchTile(
                  icon: Icons.campaign,
                  text: "Promotional",
                  subtitle: "Offers and new features",
                  value: false,
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// -------- Security ----------
            _sectionCard(
              title: "Security & Privacy",
              children: [
                _tile(icon: Icons.lock, text: "Change PIN"),
                _switchTile(
                  icon: Icons.fingerprint,
                  text: "Biometric Login",
                  subtitle: "Use fingerprint to login",
                  value: true,
                ),
                _tile(
                  icon: Icons.timer,
                  text: "Auto Lock",
                  subtitle: "5 minutes",
                ),
                _tile(icon: Icons.policy, text: "Privacy Policy"),
              ],
            ),

            const SizedBox(height: 14),

            /// -------- Support ----------
            _sectionCard(
              title: "Support & About",
              children: [
                _tile(icon: Icons.help, text: "Help & FAQ"),
                _tile(
                  icon: Icons.support_agent,
                  text: "Contact Support",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WorkerHelpAndSupportScreen(),
                      ),
                    );
                  },
                ),
                _tile(icon: Icons.star, text: "Rate App"),
                _tile(
                  icon: Icons.info,
                  text: "About",
                  subtitle: "Version 1.2.0",
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// -------- Logout ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xffFFEAEA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- Section Card ----------
  static Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  /// ---------- Normal Tile ----------
  static Widget _tile({
    required IconData icon,
    required String text,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.grey.shade100,
        child: Icon(icon, size: 20),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(fontSize: 12))
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  /// ---------- Switch Tile ----------
  static Widget _switchTile({
    required IconData icon,
    required String text,
    String? subtitle,
    required bool value,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.grey.shade100,
        child: Icon(icon, size: 20),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(fontSize: 12))
          : null,
      value: value,
      onChanged: (v) {},
    );
  }
}
