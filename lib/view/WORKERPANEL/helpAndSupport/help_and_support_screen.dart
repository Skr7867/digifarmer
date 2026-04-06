import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res/customeWidgets/custom_app_bar.dart';
import '../faq/faq_screen.dart';

class WorkerHelpAndSupportScreen extends StatefulWidget {
  const WorkerHelpAndSupportScreen({super.key});

  @override
  State<WorkerHelpAndSupportScreen> createState() =>
      _WorkerHelpAndSupportScreenState();
}

class _WorkerHelpAndSupportScreenState
    extends State<WorkerHelpAndSupportScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: CustomAppBar(
        title: 'Help & Support',
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
            /// -------- Quick Actions ----------
            _sectionCard(
              title: "Quick Actions",
              child: Row(
                children: [
                  Expanded(
                    child: _quickButton(
                      color: const Color(0xff34A853),
                      icon: Icons.call,
                      text: "Call Support",
                      onTap: () => _makePhoneCall('9266157828'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _quickButton(
                      color: const Color(0xff1E4FA3),
                      icon: Icons.chat,
                      text: "Live Chat",
                      onTap: () => _openWhatsApp('9266157828'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// -------- Contact Info ----------
            _sectionCard(
              title: "Contact Information",
              child: Column(
                children: [
                  _contactTile(
                    icon: Icons.call,
                    color: Colors.green,
                    title: "Support Helpline",
                    value: "+91 9266157828",
                    onTap: () => _makePhoneCall('9266157828'),
                  ),
                  _contactTile(
                    icon: Icons.email,
                    color: Colors.blue,
                    title: "Email Support",
                    value: "info@digifarmer.in",
                    onTap: () => _sendEmail('info@digifarmer.in'),
                  ),
                  _contactTile(
                    icon: Icons.phone,
                    color: Colors.orange,
                    title: "WhatsApp Support",
                    value: "+91 9266157828",
                    onTap: () => _openWhatsApp('9266157828'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// -------- FAQ ----------
            _sectionCard(
              title: "Frequently Asked Questions",
              child: Column(children: [FAQScreen()]),
            ),

            const SizedBox(height: 14),

            /// -------- Help Categories ----------
            _sectionCard(
              title: "Help Categories",
              child: Column(
                children: [
                  _categoryTile(
                    Icons.trending_up,
                    "Investment Help",
                    onTap: () => _openWhatsApp('9266157828'),
                  ),
                  _categoryTile(
                    Icons.payment,
                    "Payment Issues",
                    onTap: () => _openWhatsApp('9266157828'),
                  ),
                  _categoryTile(
                    Icons.person,
                    "Account & KYC",
                    onTap: () => _openWhatsApp('9266157828'),
                  ),
                  _categoryTile(
                    Icons.agriculture,
                    "Farming & Tasks",
                    onTap: () => _openWhatsApp('9266157828'),
                  ),
                  _categoryTile(
                    Icons.security,
                    "Security & Privacy",
                    onTap: () => _openWhatsApp('9266157828'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// -------- Feedback ----------
            _sectionCard(
              title: "Send Feedback",
              child: Column(
                children: [
                  TextField(
                    controller: _feedbackController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Tell us how we can improve...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: _submitFeedback,
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xff34A853),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Submit Feedback",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
  Widget _sectionCard({required String title, required Widget child}) {
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
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  /// ---------- Quick Button ----------
  Widget _quickButton({
    required Color color,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- Contact Tile ----------
  Widget _contactTile({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(.15),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  /// ---------- FAQ Tile ----------

  /// ---------- Category Tile ----------
  Widget _categoryTile(
    IconData icon,
    String text, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
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
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  /// ---------- Phone Call Function ----------
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        _showErrorSnackBar('Could not make phone call');
      }
    } catch (e) {
      _showErrorSnackBar('Error making phone call');
    }
  }

  /// ---------- WhatsApp Function ----------
  Future<void> _openWhatsApp(String phoneNumber) async {
    // Remove any special characters and ensure it's in international format
    String formattedNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (formattedNumber.startsWith('0')) {
      formattedNumber = formattedNumber.substring(1);
    }

    // For WhatsApp, we need to add country code if not present
    if (!formattedNumber.startsWith('91') && formattedNumber.length == 10) {
      formattedNumber = '91$formattedNumber';
    }

    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: formattedNumber,
    );

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
      } else {
        _showErrorSnackBar('Please install WhatsApp to continue');
      }
    } catch (e) {
      _showErrorSnackBar('Error opening WhatsApp');
    }
  }

  /// ---------- Email Function ----------
  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Help & Support - DigiFarmer',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showErrorSnackBar('Could not open email app');
      }
    } catch (e) {
      _showErrorSnackBar('Error opening email');
    }
  }

  /// ---------- Submit Feedback ----------
  void _submitFeedback() {
    if (_feedbackController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter your feedback before submitting');
      return;
    }

    // Clear the feedback field
    _feedbackController.clear();

    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Your feedback submitted successfully!',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // You can also send the feedback to your backend here
    // _sendFeedbackToServer(_feedbackController.text);
  }

  /// ---------- Error Snackbar ----------
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
