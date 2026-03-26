import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/routes/routes_name.dart';

class KYCVerificationStatusScreen extends StatefulWidget {
  const KYCVerificationStatusScreen({super.key});

  @override
  State<KYCVerificationStatusScreen> createState() =>
      _KYCVerificationStatusScreenState();
}

class _KYCVerificationStatusScreenState
    extends State<KYCVerificationStatusScreen> {
  final DateTime _submittedDate = DateTime(2024, 12, 29, 14, 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'KYC Verification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Card
              _buildStatusCard(),
              const SizedBox(height: 24),

              // Verification Steps
              _buildVerificationSteps(),
              const SizedBox(height: 24),

              // Submitted Documents
              _buildSubmittedDocuments(),
              const SizedBox(height: 24),

              // Need Help Section
              _buildNeedHelpSection(),
              const SizedBox(height: 32),

              // Back to Home Button
              _buildBackToHomeButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange.shade50, Colors.orange.shade100],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.pending_actions,
                    color: Colors.orange.shade800,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Under Review',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Verification in Progress',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your documents are being reviewed by our verification team. This usually takes 24-48 hours.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade800,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Submitted on',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('MMM dd, yyyy').format(_submittedDate),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'at ${DateFormat('h:mm a').format(_submittedDate)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
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
    );
  }

  Widget _buildVerificationSteps() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verification Steps',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            _buildStepItem(
              title: 'Documents Submitted',
              status: 'All required documents uploaded successfully',
              isCompleted: true,
              isInProgress: false,
            ),
            const SizedBox(height: 16),
            _buildStepItem(
              title: 'Document Verification',
              status: 'Our team is reviewing your documents',
              isCompleted: false,
              isInProgress: true,
            ),
            const SizedBox(height: 16),
            _buildStepItem(
              title: 'Identity Verification',
              status: 'Verifying identity details with authorities',
              isCompleted: false,
              isInProgress: false,
            ),
            const SizedBox(height: 16),
            _buildStepItem(
              title: 'Approval',
              status: 'Final approval and account activation',
              isCompleted: false,
              isInProgress: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem({
    required String title,
    required String status,
    required bool isCompleted,
    required bool isInProgress,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? Colors.green
                : isInProgress
                ? Colors.orange
                : Colors.grey.shade300,
          ),
          child: Icon(
            isCompleted
                ? Icons.check
                : isInProgress
                ? Icons.hourglass_empty
                : Icons.access_time,
            size: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isCompleted || isInProgress
                      ? Colors.black87
                      : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: TextStyle(
                  fontSize: 13,
                  color: isCompleted || isInProgress
                      ? Colors.grey.shade700
                      : Colors.grey.shade500,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        if (isCompleted)
          Icon(Icons.check_circle, size: 20, color: Colors.green.shade600)
        else if (isInProgress)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Text(
              'In Progress',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.orange.shade700,
              ),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              'Pending',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSubmittedDocuments() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Submitted Documents',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            _buildDocumentItem(
              title: 'PAN Card',
              detail: '4BCDE1234F',
              icon: Icons.credit_card,
              iconColor: Colors.orange,
            ),
            const SizedBox(height: 16),
            _buildDocumentItem(
              title: 'Aadhaar Card',
              detail: 'xxxx XXXX 4567',
              icon: Icons.credit_card,
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildDocumentItem(
              title: 'Bank Details',
              detail: 'Account ending in 4567',
              icon: Icons.account_balance,
              iconColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentItem({
    required String title,
    required String detail,
    required IconData icon,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                detail,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.info_outline, size: 20, color: Colors.grey.shade400),
          onPressed: () {
            _showDocumentInfo(title);
          },
        ),
      ],
    );
  }

  Widget _buildNeedHelpSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: Colors.blue.shade700, size: 24),
              const SizedBox(width: 12),
              Text(
                'Need Help?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'If you have any questions about your verification status, our support team is here to help.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade800,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              _contactSupport();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Contact Support',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Colors.blue.shade700,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackToHomeButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          _navigateToHome();
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.green.shade300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Back to Home',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.green.shade700,
          ),
        ),
      ),
    );
  }

  void _showDocumentInfo(String documentType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(documentType),
        content: Text(
          documentType == 'PAN Card'
              ? 'PAN Card is a 10-character alphanumeric identifier issued by the Income Tax Department.'
              : documentType == 'Aadhaar Card'
              ? 'Aadhaar is a 12-digit unique identity number issued by the Government of India.'
              : 'Bank details are securely stored for processing payouts and refunds.',
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

  void _contactSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Contact Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📧 Email: support@digifarmer.com'),
            SizedBox(height: 8),
            Text('📞 Phone: +91 12345 67890'),
            SizedBox(height: 8),
            Text('💬 Live Chat: Available 9 AM - 6 PM'),
          ],
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

  void _navigateToHome() {
    // Navigate to home screen
    Navigator.pushReplacementNamed(context, RoutesName.bottomNavBar);
  }
}
