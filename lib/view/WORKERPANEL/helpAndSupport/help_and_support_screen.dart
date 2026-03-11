import 'package:flutter/material.dart';

class WorkerHelpAndSupportScreen extends StatelessWidget {
  const WorkerHelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        title: const Text(
          "Help & Support",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _quickButton(
                      color: const Color(0xff1E4FA3),
                      icon: Icons.chat,
                      text: "Live Chat",
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
                    value: "+91 9876 543 210",
                  ),
                  _contactTile(
                    icon: Icons.email,
                    color: Colors.blue,
                    title: "Email Support",
                    value: "support@agrinivest.com",
                  ),
                  _contactTile(
                    icon: Icons.phone,
                    color: Colors.orange,
                    title: "WhatsApp Support",
                    value: "+91 9876 543 211",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// -------- FAQ ----------
            _sectionCard(
              title: "Frequently Asked Questions",
              child: Column(
                children: [
                  _faqTile("How do I make my first investment?"),
                  _faqTile("When can I withdraw my investment?"),
                  _faqTile("How is my investment secured?"),
                  _faqTile("How do I track my farm progress?"),
                  _faqTile("What if my KYC is rejected?"),
                  _faqTile("How do I change my bank details?"),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// -------- Help Categories ----------
            _sectionCard(
              title: "Help Categories",
              child: Column(
                children: [
                  _categoryTile(Icons.trending_up, "Investment Help"),
                  _categoryTile(Icons.payment, "Payment Issues"),
                  _categoryTile(Icons.person, "Account & KYC"),
                  _categoryTile(Icons.agriculture, "Farming & Tasks"),
                  _categoryTile(Icons.security, "Security & Privacy"),
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
                  Container(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- Section Card ----------
  static Widget _sectionCard({required String title, required Widget child}) {
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
  static Widget _quickButton({
    required Color color,
    required IconData icon,
    required String text,
  }) {
    return Container(
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
    );
  }

  /// ---------- Contact Tile ----------
  static Widget _contactTile({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return ListTile(
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
    );
  }

  /// ---------- FAQ Tile ----------
  static Widget _faqTile(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(text, style: const TextStyle(fontSize: 13)),
        children: const [
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Answer content will be shown here.",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------- Category Tile ----------
  static Widget _categoryTile(IconData icon, String text) {
    return ListTile(
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
    );
  }
}
