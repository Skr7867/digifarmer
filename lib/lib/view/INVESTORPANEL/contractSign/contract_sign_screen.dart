import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import '../../../res/color/app_colors.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';

class ContractSignScreen extends StatefulWidget {
  const ContractSignScreen({super.key});

  @override
  State<ContractSignScreen> createState() => _ContractSignScreenState();
}

class _ContractSignScreenState extends State<ContractSignScreen> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  bool _isSigned = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: CustomAppBar(
        title: 'Contract Sign',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff2E7D32), Color(0xff4CAF50)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Investment Agreement',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Organic Rice Farm Project',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.picture_as_pdf,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Investment_Agreement_2024.pdf',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                              Text(
                                '12 pages • 2.4 MB • last updated: ${DateFormat('MMM dd, yyyy').format(DateTime.now())}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 11,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.download_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Agreement Content
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
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
                  const Center(
                    child: Text(
                      'INVESTMENT AGREEMENT',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.popins,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Organic Rice Farm Project',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Agreement No: AGR-2024-001234',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 1. PARTIES TO THE AGREEMENT
                  _buildSectionTitle('1. PARTIES TO THE AGREEMENT'),
                  const SizedBox(height: 12),
                  _buildPartyRow('Investor:', 'John Doe'),
                  const SizedBox(height: 8),
                  _buildPartyRow(
                    'Platform:',
                    'Agroinvest Technologies Pvt Ltd',
                  ),
                  const SizedBox(height: 8),
                  _buildPartyRow('Farm Owner:', 'Green Valley Organic Farms'),
                  const SizedBox(height: 24),

                  // 2. INVESTMENT DETAILS
                  _buildSectionTitle('2. INVESTMENT DETAILS'),
                  const SizedBox(height: 12),
                  _buildDetailRow('Investment Amount:', '₹25,000'),
                  _buildDetailRow('Tenure:', '3 Years'),
                  _buildDetailRow('Expected Returns:', '12% per annum'),
                  _buildDetailRow('Maturity Value:', '₹35,123'),
                  const SizedBox(height: 24),

                  // 3. PROJECT OVERVIEW
                  _buildSectionTitle('3. PROJECT OVERVIEW'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'This agreement governs the investment in organic rice cultivation project located in Maharashtra, India. The project focuses on sustainable farming practices and organic rice production.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.grey.shade800,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 4. TERMS AND CONDITIONS
                  _buildSectionTitle('4. TERMS AND CONDITIONS'),
                  const SizedBox(height: 12),
                  _buildTermItem('• Investment is subject to market risks'),
                  _buildTermItem('• Returns are not guaranteed'),
                  _buildTermItem('• Early withdrawal may incur penalties'),
                  _buildTermItem(
                    '• All disputes subject to Mumbai jurisdiction',
                  ),
                  const SizedBox(height: 24),

                  // Signature Section (only shown when signing)
                  if (_isSigned) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Contract Signed Successfully!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Signed on: ${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now())}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade700,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Security Badge
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified, color: Colors.blue.shade700, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Legally verified document • Secure & encrypted',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue.shade700,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isSigned ? null : _handleReject,
                      icon: const Icon(Icons.close),
                      label: const Text(
                        'Reject',
                        style: TextStyle(fontFamily: AppFonts.popins),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isSigned ? null : _handleAccept,
                      icon: const Icon(
                        Icons.edit_square,
                        color: AppColors.whiteColor,
                      ),
                      label: const Text(
                        'Accept & Sign',
                        style: TextStyle(
                          fontFamily: AppFonts.popins,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.popins,
        color: Color(0xff2E7D32),
      ),
    );
  }

  Widget _buildPartyRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
              fontFamily: AppFonts.popins,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, fontFamily: AppFonts.popins),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermItem(String term) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        term,
        style: TextStyle(
          fontSize: 13,
          height: 1.4,
          color: Colors.grey.shade800,
          fontFamily: AppFonts.popins,
        ),
      ),
    );
  }

  void _handleReject() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Reject Contract',
          style: TextStyle(fontFamily: AppFonts.popins),
        ),
        content: const Text(
          'Are you sure you want to reject this contract? This action cannot be undone.',
          style: TextStyle(fontFamily: AppFonts.popins),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(fontFamily: AppFonts.popins),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Contract rejected. You can review and sign later.',
                    style: TextStyle(fontFamily: AppFonts.popins),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
              Navigator.pop(context); // Navigate back
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Reject',
              style: TextStyle(
                color: Colors.white,
                fontFamily: AppFonts.popins,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAccept() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Handle Bar
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Sign Contract',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Please sign below to accept the contract',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Signature Pad
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade50,
                  ),
                  child: Signature(
                    controller: _signatureController,
                    backgroundColor: Colors.white,
                    width: MediaQuery.of(context).size.width - 40,
                    height: 200,
                  ),
                ),

                const SizedBox(height: 12),

                // Clear Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      setModalState(() {
                        _signatureController.clear();
                      });
                    },
                    icon: const Icon(Icons.clear, size: 16),
                    label: const Text(
                      'Clear',
                      style: TextStyle(fontFamily: AppFonts.popins),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Sign Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () => _submitSignature(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Sign Contract',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.popins,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _submitSignature(BuildContext modalContext) async {
    if (_signatureController.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isSigned = true;
          _isLoading = false;
        });

        Navigator.pop(modalContext); // Close modal

        // Show success dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Contract Signed Successfully!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your investment contract has been signed and verified.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Go back to previous screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(modalContext).showSnackBar(
        const SnackBar(
          content: Text(
            'Please sign the contract first',
            style: TextStyle(fontFamily: AppFonts.popins),
          ),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}
