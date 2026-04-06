// ignore_for_file: unused_element, unused_field

import 'package:digifarmer/view/WORKERPANEL/helpAndSupport/help_and_support_screen.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/routes_name.dart';
import '../../../res/color/app_colors.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../service/storage/local_storage.dart';

class WorkerSettingScreen extends StatefulWidget {
  const WorkerSettingScreen({super.key});

  @override
  State<WorkerSettingScreen> createState() => _WorkerSettingScreenState();
}

class _WorkerSettingScreenState extends State<WorkerSettingScreen> {
  // State variables for switches
  bool _darkMode = false;
  bool _investmentUpdates = true;
  bool _paymentAlerts = true;
  bool _farmProgress = true;
  bool _biometricLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: CustomAppBar(
        title: 'Settings',
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
          children: [
            /// -------- Account Section ----------
            // _sectionCard(
            //   title: "Account",
            //   children: [
            //     _tile(icon: Icons.person, text: "Edit Profile"),
            //     _tile(icon: Icons.verified_user, text: "KYC Documents"),
            //     _tile(icon: Icons.account_balance, text: "Bank Details"),
            //   ],
            // ),
            const SizedBox(height: 14),

            /// -------- App Preference ----------
            // _sectionCard(
            //   title: "App Preferences",
            //   children: [
            //     _tile(
            //       icon: Icons.language,
            //       text: "Language",
            //       subtitle: "English",
            //       onTap: () {
            //         _showLanguageDialog();
            //       },
            //     ),
            //     _switchTile(
            //       icon: Icons.dark_mode,
            //       text: "Dark Mode",
            //       subtitle: "Switch to dark theme",
            //       value: _darkMode,
            //       onChanged: (value) {
            //         setState(() {
            //           _darkMode = value;
            //         });
            //         _handleDarkModeChange(value);
            //       },
            //     ),
            //     _tile(
            //       icon: Icons.palette,
            //       text: "Theme",
            //       subtitle: "Green & Blue",
            //       onTap: () {
            //         _showThemeDialog();
            //       },
            //     ),
            //   ],
            // ),

            /// -------- Notifications ----------
            _sectionCard(
              title: "Notifications",
              children: [
                _switchTile(
                  icon: Icons.show_chart,
                  text: "Investment Updates",
                  subtitle: "Portfolio and maturity alerts",
                  value: _investmentUpdates,
                  onChanged: (value) {
                    setState(() {
                      _investmentUpdates = value;
                    });
                    _handleNotificationChange('investment', value);
                  },
                ),
                _switchTile(
                  icon: Icons.payment,
                  text: "Payment Alerts",
                  subtitle: "Transaction confirmations",
                  value: _paymentAlerts,
                  onChanged: (value) {
                    setState(() {
                      _paymentAlerts = value;
                    });
                    _handleNotificationChange('payment', value);
                  },
                ),
                _switchTile(
                  icon: Icons.agriculture,
                  text: "Farm Progress",
                  subtitle: "Crop updates and milestones",
                  value: _farmProgress,
                  onChanged: (value) {
                    setState(() {
                      _farmProgress = value;
                    });
                    _handleNotificationChange('farm', value);
                  },
                ),
                // _switchTile(
                //   icon: Icons.warning,
                //   text: "Security Alerts",
                //   subtitle: "Login and account security",
                //   value: true,
                // ),
                // _switchTile(
                //   icon: Icons.campaign,
                //   text: "Promotional",
                //   subtitle: "Offers and new features",
                //   value: false,
                // ),
              ],
            ),

            const SizedBox(height: 14),

            /// -------- Security ----------
            _sectionCard(
              title: "Security & Privacy",
              children: [
                _tile(
                  icon: Icons.lock,
                  text: "Terms & Condition",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.termAndConditionScreen,
                    );
                  },
                ),
                // _switchTile(
                //   icon: Icons.fingerprint,
                //   text: "Biometric Login",
                //   subtitle: "Use fingerprint to login",
                //   value: _biometricLogin,
                //   onChanged: (value) {
                //     setState(() {
                //       _biometricLogin = value;
                //     });
                //     _handleBiometricChange(value);
                //   },
                // ),
                // _tile(
                //   icon: Icons.timer,
                //   text: "Auto Lock",
                //   subtitle: "5 minutes",
                // ),
                _tile(
                  icon: Icons.policy,
                  text: "Privacy Policy",
                  onTap: () {
                    // _showPrivacyPolicy();
                    Navigator.pushNamed(
                      context,
                      RoutesName.privacyPolicyScreen,
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// -------- Support ----------
            _sectionCard(
              title: "Support & About",
              children: [
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
                // _tile(icon: Icons.star, text: "Rate App"),
                _tile(
                  icon: Icons.info,
                  text: "About",
                  subtitle: "Version 1.2.0",
                  onTap: () {
                    _showAboutDialog();
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// -------- Logout ----------
            InkWell(
              onTap: () {
                _showLogoutDialog();
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- Section Card ----------
  Widget _sectionCard({required String title, required List<Widget> children}) {
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
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  /// ---------- Normal Tile ----------
  Widget _tile({
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
        child: Icon(icon, size: 20, color: Colors.grey.shade700),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.popins,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(fontSize: 12, fontFamily: AppFonts.popins),
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  /// ---------- Switch Tile ----------
  Widget _switchTile({
    required IconData icon,
    required String text,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.grey.shade100,
        child: Icon(icon, size: 20, color: Colors.grey.shade700),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.popins,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(fontSize: 12, fontFamily: AppFonts.popins),
            )
          : null,
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.greenColor,
    );
  }

  /// ---------- Logout Functionality ----------
  Future<void> _performLogout() async {
    try {
      LocalStorage localStorage = LocalStorage();
      await localStorage.clearValue('token');
      await localStorage.clearValue('isLogin');
      await localStorage.clearValue('userData');

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.userLoginScreen,
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error during logout: $e',
              style: const TextStyle(fontFamily: AppFonts.popins),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showLogoutDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontFamily: AppFonts.popins,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontFamily: AppFonts.popins),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: const Text(
                'Cancel',
                style: TextStyle(fontFamily: AppFonts.popins),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: AppFonts.popins,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// ---------- Helper Methods for Settings ----------
  void _handleDarkModeChange(bool value) {
    // Implement dark mode logic here
    // You can use a theme provider or save to local storage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value ? 'Dark mode enabled' : 'Light mode enabled',
          style: const TextStyle(fontFamily: AppFonts.popins),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleNotificationChange(String type, bool value) {
    // Save notification preferences to local storage or API
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${type.toUpperCase()} notifications ${value ? "enabled" : "disabled"}',
          style: const TextStyle(fontFamily: AppFonts.popins),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleBiometricChange(bool value) {
    // Implement biometric login logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value ? 'Biometric login enabled' : 'Biometric login disabled',
          style: const TextStyle(fontFamily: AppFonts.popins),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Language',
            style: TextStyle(fontFamily: AppFonts.popins),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  'English',
                  style: TextStyle(fontFamily: AppFonts.popins),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Implement language change
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Language changed to English'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'हिंदी',
                  style: TextStyle(fontFamily: AppFonts.popins),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Implement language change
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('भाषा हिंदी में बदल दी गई'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'मराठी',
                  style: TextStyle(fontFamily: AppFonts.popins),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Implement language change
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('भाषा मराठीमध्ये बदलली'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Theme',
            style: TextStyle(fontFamily: AppFonts.popins),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  'Green & Blue',
                  style: TextStyle(fontFamily: AppFonts.popins),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Theme: Green & Blue'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(fontFamily: AppFonts.popins),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _darkMode = true;
                  });
                  _handleDarkModeChange(true);
                },
              ),
              ListTile(
                title: const Text(
                  'Light Mode',
                  style: TextStyle(fontFamily: AppFonts.popins),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _darkMode = false;
                  });
                  _handleDarkModeChange(false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showHelpAndFAQ() {
    // Navigate to Help & FAQ screen or show dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Help & FAQ section coming soon'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'About',
            style: TextStyle(fontFamily: AppFonts.popins),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.agriculture, size: 50, color: Colors.green),
              SizedBox(height: 10),
              Text(
                'DigiFarmer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Version 1.2.0',
                style: TextStyle(fontFamily: AppFonts.popins),
              ),
              SizedBox(height: 10),
              Text(
                'Empowering farmers with technology',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: AppFonts.popins),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
