import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../../res/customeWidgets/custom_app_bar.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Identity Verification',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator
              _buildProgressIndicator(),
              const SizedBox(height: 32),

              // Title
              const Text(
                'Let\'s verify your identity to keep your account secure and comply with financial regulations',
                style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.4),
              ),
              const SizedBox(height: 32),

              // Verification Steps
              _buildVerificationSteps(),
              const SizedBox(height: 32),

              // Security Note
              _buildSecurityNote(),
              const SizedBox(height: 32),

              // Action Buttons
              _buildActionButtons(),
              const SizedBox(height: 16),

              // Footer Links
              _buildFooterLinks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Align(
            alignment: Alignment.centerLeft, // ✅ force start from left
            child: FractionallySizedBox(
              widthFactor: 0.5, // 50%
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Step 1 of 2 • 50%',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationSteps() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildVerificationStep(
            icon: Icons.upload_file,
            iconColor: Colors.blue,
            title: 'Document Upload',
            description:
                'Upload a government-issued ID like Aadhaar card or passport',
            isFirst: true,
          ),
          Divider(height: 1, color: Colors.grey.shade200, indent: 60),
          _buildVerificationStep(
            icon: Icons.camera_alt,
            iconColor: Colors.orange,
            title: 'Take a Selfie',
            description:
                'Capture a clear photo of yourself for identity confirmation',
            isFirst: false,
          ),
          Divider(height: 1, color: Colors.grey.shade200, indent: 60),
          _buildVerificationStep(
            icon: Icons.verified,
            iconColor: Colors.green,
            title: 'Quick Verification',
            description: 'We\'ll verify your details within 24 hours',
            isFirst: false,
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationStep({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required bool isFirst,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.shield, color: Colors.green.shade700, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your data is secure',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'We use bank-level encryption to protect your personal information and comply with all privacy regulations.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.bankDetailsScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Start Verification',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade300),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Skip for now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      children: [
        Center(
          child: TextButton(
            onPressed: () {
              _showWhyWeNeedThis();
            },
            child: Text(
              'Why do we need this?',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              _showKycRequirements();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Learn about KYC requirements',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // void _skipVerification() {
  //   // Show confirmation dialog
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Skip Verification?'),
  //       content: const Text(
  //         'You can complete verification later, but some features may be limited until your identity is verified.',
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //             // Navigate to dashboard or next screen
  //             // Navigator.pushReplacementNamed(context, RoutesName.dashboard);
  //           },
  //           style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
  //           child: const Text('Skip'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showWhyWeNeedThis() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Why do we need verification?'),
        content: const Text(
          'Identity verification helps us:\n\n'
          '• Protect your account from unauthorized access\n'
          '• Comply with financial regulations and KYC norms\n'
          '• Prevent fraud and money laundering\n'
          '• Ensure secure transactions\n\n'
          'Your information is encrypted and stored securely.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _showKycRequirements() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('KYC Requirements'),
        content: const Text(
          'Know Your Customer (KYC) is a regulatory requirement that helps verify your identity.\n\n'
          'Accepted Documents:\n'
          '✓ Aadhaar Card\n'
          '✓ PAN Card\n'
          '✓ Passport\n'
          '✓ Voter ID\n'
          '✓ Driving License\n\n'
          'Documents should be clear and valid.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
