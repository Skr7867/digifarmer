import 'dart:io';

import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final Map<String, dynamic>? paymentDetails;

  const PaymentSuccessScreen({super.key, this.paymentDetails});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  final Map<String, dynamic> paymentData = {
    'amount': '25,000',
    'projectName': 'Organic Rice Farm',
    'status': 'Active',
    'transactionId': 'TXN2024010512345',
    'dateTime': DateTime.now(),
    'paymentMethod': 'UPI',
    'upiId': 'user@upi',
    'investmentAmount': '25,000',
    'processingFee': 'Free',
    'totalPaid': '25,000',
    'tenure': '3 Years',
    'interestRate': '12% p.a.',
    'maturityDate': DateTime.now().add(const Duration(days: 3 * 365)),
    'expectedMaturityValue': '35,123',
  };

  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Success Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff4CAF50), Color(0xff2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 70),
                  const SizedBox(height: 12),
                  const Text(
                    'Payment Successful!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your investment has been confirmed',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Amount Paid',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${paymentData['amount']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
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

            SizedBox(height: 30),

            // Project Info Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.eco, color: Colors.green, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paymentData['projectName'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Investment Project',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      paymentData['status'],
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Transaction Receipt Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.receipt, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Transaction Receipt',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24, thickness: 1),
                  _buildReceiptRow(
                    'Transaction ID',
                    paymentData['transactionId'],
                  ),
                  _buildReceiptRow(
                    'Date & Time',
                    DateFormat(
                      'dd MMM yyyy, hh:mm a',
                    ).format(paymentData['dateTime']),
                  ),
                  _buildReceiptRow(
                    'Payment Method',
                    paymentData['paymentMethod'],
                  ),
                  if (paymentData['paymentMethod'] == 'UPI')
                    _buildReceiptRow('UPI ID', paymentData['upiId']),
                  const Divider(height: 24, thickness: 1),
                  _buildReceiptRow(
                    'Investment Amount',
                    '₹${paymentData['investmentAmount']}',
                  ),
                  _buildReceiptRow(
                    'Processing Fee',
                    paymentData['processingFee'],
                  ),
                  _buildReceiptRow(
                    'Total Paid',
                    '₹${paymentData['totalPaid']}',
                    isBold: true,
                    valueColor: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Investment Summary Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Investment Summary',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryRow('Tenure', paymentData['tenure']),
                  _buildSummaryRow(
                    'Interest Rate',
                    paymentData['interestRate'],
                  ),
                  _buildSummaryRow(
                    'Maturity Date',
                    DateFormat(
                      'dd MMM yyyy',
                    ).format(paymentData['maturityDate']),
                  ),
                  _buildSummaryRow(
                    'Expected Maturity Value',
                    '₹${paymentData['expectedMaturityValue']}',
                    isBold: true,
                    valueColor: Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // What's Next Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "What's Next?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildNextStep(
                    icon: Icons.email_outlined,
                    title: 'Confirmation Email',
                    description:
                        'Check your email for payment confirmation and investment details',
                  ),
                  const SizedBox(height: 12),
                  _buildNextStep(
                    icon: Icons.timeline_outlined,
                    title: 'Track Investment',
                    description:
                        'Monitor your investment progress from the dashboard',
                  ),
                  const SizedBox(height: 12),
                  _buildNextStep(
                    icon: Icons.update_outlined,
                    title: 'Regular Updates',
                    description:
                        'Receive monthly updates on your investment performance',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Info Note
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: Colors.blue.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '🔒 Your investment certificate will be generated within 24 hours and sent to your registered email.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                        fontFamily: AppFonts.popins,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: isDownloading ? null : _downloadReceipt,
                      icon: isDownloading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.download_outlined),
                      label: Text(
                        isDownloading ? 'Downloading...' : 'Download Receipt',
                        style: const TextStyle(fontFamily: AppFonts.popins),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _shareLink,
                      icon: const Icon(Icons.share_outlined),
                      label: const Text(
                        'Share',
                        style: TextStyle(fontFamily: AppFonts.popins),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Go to Dashboard Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/dashboard',
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Go to Dashboard',
                    style: TextStyle(fontFamily: AppFonts.popins),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: valueColor ?? Colors.black,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: valueColor ?? Colors.black,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextStep({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blue.shade700, size: 20),
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
                  fontFamily: AppFonts.popins,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _downloadReceipt() async {
    setState(() {
      isDownloading = true;
    });

    try {
      // Create PDF document
      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (context) => [
            // Header
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Icon(
                    pw.IconData(0xe86c),
                    size: 60,
                    color: PdfColors.green,
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Payment Receipt',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'DigiFarmer Investment',
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.grey),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.SizedBox(height: 20),

            // Transaction Details
            _buildPdfRow('Transaction ID', paymentData['transactionId']),
            _buildPdfRow(
              'Date & Time',
              DateFormat(
                'dd MMM yyyy, hh:mm a',
              ).format(paymentData['dateTime']),
            ),
            _buildPdfRow('Payment Method', paymentData['paymentMethod']),
            if (paymentData['paymentMethod'] == 'UPI')
              _buildPdfRow('UPI ID', paymentData['upiId']),
            pw.SizedBox(height: 10),

            // Amount Details
            pw.Text(
              'Amount Details',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            _buildPdfRow(
              'Investment Amount',
              '₹${paymentData['investmentAmount']}',
            ),
            _buildPdfRow('Processing Fee', paymentData['processingFee']),
            _buildPdfRow(
              'Total Paid',
              '₹${paymentData['totalPaid']}',
              isBold: true,
            ),
            pw.SizedBox(height: 20),

            // Investment Details
            pw.Text(
              'Investment Details',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            _buildPdfRow('Project Name', paymentData['projectName']),
            _buildPdfRow('Tenure', paymentData['tenure']),
            _buildPdfRow('Interest Rate', paymentData['interestRate']),
            _buildPdfRow(
              'Maturity Date',
              DateFormat('dd MMM yyyy').format(paymentData['maturityDate']),
            ),
            _buildPdfRow(
              'Expected Maturity Value',
              '₹${paymentData['expectedMaturityValue']}',
            ),
            pw.SizedBox(height: 20),

            // Footer
            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Text(
              'Thank you for investing with DigiFarmer!',
              style: pw.TextStyle(fontSize: 12, color: PdfColors.grey),
              textAlign: pw.TextAlign.center,
            ),
          ],
        ),
      );

      // Save PDF to device
      final directory = await getApplicationDocumentsDirectory();
      final file = File(
        '${directory.path}/payment_receipt_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(await pdf.save());

      // Share the PDF
      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Payment Receipt - DigiFarmer Investment');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Receipt downloaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading receipt: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isDownloading = false;
        });
      }
    }
  }

  pw.Widget _buildPdfRow(String label, String value, {bool isBold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: pw.TextStyle(fontSize: 12)),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _shareLink() async {
    const shareLink = 'https://digifarmer.onrender.com/';
    const shareMessage =
        '🎉 I\'ve successfully invested in DigiFarmer! Join me in sustainable farming investments. Check it out: $shareLink';

    try {
      await Share.share(shareMessage, subject: 'DigiFarmer Investment');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
