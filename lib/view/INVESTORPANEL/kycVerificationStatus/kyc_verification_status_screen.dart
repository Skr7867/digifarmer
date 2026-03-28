import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:digifarmer/blocs/INVESTORPANEL/kycStatus/kyc_status_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/repository/INVESTORPANEL/kycStatus/kyc_status_http_repository.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';

import '../../../model/INVESTORPANEL/kycStatus/kyc_status_model.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';

class KYCVerificationStatusScreen extends StatefulWidget {
  const KYCVerificationStatusScreen({super.key});

  @override
  State<KYCVerificationStatusScreen> createState() =>
      _KYCVerificationStatusScreenState();
}

class _KYCVerificationStatusScreenState
    extends State<KYCVerificationStatusScreen> {
  late KycStatusBloc kycStatusBloc;

  @override
  void initState() {
    super.initState();
    kycStatusBloc = KycStatusBloc(
      kycStatusRepository: KycStatusHttpRepository(),
    )..add(KycStatusFetched());
  }

  @override
  void dispose() {
    kycStatusBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
            title: 'Verification Status ',
            automaticallyImplyLeading: true,
            gradient: const LinearGradient(
              colors: [Color(0xff34A853), Color(0xff0D47A1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),),
      body: BlocProvider(
        create: (_) => kycStatusBloc,
        child: BlocListener<KycStatusBloc, KycStatusState>(
          listener: (context, state) {
            if (state.kycStatus.status == Status.error) {
              FlushBarHelper.flushBarErrorMessage(
                state.kycStatus.message ?? 'Error fetching KYC status',
                context,
              );
            }
          },
          child: BlocBuilder<KycStatusBloc, KycStatusState>(
            builder: (context, state) {
              switch (state.kycStatus.status) {
                case Status.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.error:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.kycStatus.message ?? 'Failed to load KYC status',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            context.read<KycStatusBloc>().add(KycStatusFetched());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                case Status.completed:
                  if (state.kycStatus.data == null) {
                    return const Center(
                      child: Text('No KYC data found'),
                    );
                  }
                  final kycStatusModel = state.kycStatus.data!;
                  final data = kycStatusModel.data;
                  
                  if (data == null) {
                    return const Center(
                      child: Text('No KYC data found'),
                    );
                  }
                  
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status Card
                          _buildStatusCard(data),
                          const SizedBox(height: 24),

                          // Verification Steps
                          if (data.verificationSteps != null && data.verificationSteps!.isNotEmpty)
                            _buildVerificationSteps(data.verificationSteps!),
                          const SizedBox(height: 24),

                          // Submitted Documents
                          _buildSubmittedDocuments(data),
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
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(Data data) {
    final kycStatus = data.kycStatus ?? 'NOT_STARTED';
    final submittedAt = data.submittedAt != null
        ? DateTime.parse(data.submittedAt!)
        : DateTime.now();

    // Determine status color and icon
    Color statusColor;
    IconData statusIcon;
    String statusText;
    String statusSubtext;

    switch (kycStatus) {
      case 'UNDER_REVIEW':
        statusColor = Colors.orange;
        statusIcon = Icons.pending_actions;
        statusText = 'Under Review';
        statusSubtext = 'Verification in Progress';
        break;
      case 'VERIFIED':
      case 'COMPLETED':
        statusColor = Colors.green;
        statusIcon = Icons.verified;
        statusText = 'Verified';
        statusSubtext = 'KYC Verification Completed';
        break;
      case 'REJECTED':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        statusText = 'Rejected';
        statusSubtext = 'Verification Failed';
        break;
      case 'NOT_STARTED':
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.error_outline;
        statusText = 'Not Started';
        statusSubtext = 'Please submit your documents';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [statusColor.withOpacity(0.1), statusColor.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
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
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    statusIcon,
                    color: statusColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      Text(
                        statusSubtext,
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
                    kycStatus == 'UNDER_REVIEW'
                        ? 'Your documents are being reviewed by our verification team. This usually takes 24-48 hours.'
                        : kycStatus == 'VERIFIED'
                        ? 'Congratulations! Your KYC verification has been completed successfully.'
                        : kycStatus == 'REJECTED'
                        ? 'Your KYC verification was rejected. Please contact support for more information.'
                        : 'Please complete your KYC verification to start investing.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade800,
                      height: 1.4,
                    ),
                  ),
                  if (data.submittedAt != null) ...[
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
                          DateFormat('MMM dd, yyyy').format(submittedAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'at ${DateFormat('h:mm a').format(submittedAt)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationSteps(List<VerificationSteps> steps) {
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
            ...steps.map((step) {
              final isCompleted = step.status == 'COMPLETED';
              final isInProgress = step.status == 'IN_PROGRESS';
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildStepItem(
                  title: step.name ?? '',
                  status: _getStepStatusMessage(step.name ?? '', step.status ?? ''),
                  isCompleted: isCompleted,
                  isInProgress: isInProgress,
                  completedAt: step.completedAt,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getStepStatusMessage(String stepName, String status) {
    switch (status) {
      case 'COMPLETED':
        return 'Completed successfully';
      case 'IN_PROGRESS':
        if (stepName == 'Document Verification') {
          return 'Our team is reviewing your documents';
        } else if (stepName == 'Identity Verification') {
          return 'Verifying identity details with authorities';
        }
        return 'In progress';
      case 'PENDING':
        if (stepName == 'Approved') {
          return 'Final approval and account activation';
        }
        return 'Waiting to start';
      default:
        return 'Pending';
    }
  }

  Widget _buildStepItem({
    required String title,
    required String status,
    required bool isCompleted,
    required bool isInProgress,
    String? completedAt,
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
              if (completedAt != null && isCompleted) ...[
                const SizedBox(height: 4),
                Text(
                  'Completed: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(completedAt))}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.green.shade600,
                  ),
                ),
              ],
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

  Widget _buildSubmittedDocuments(Data data) {
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
            if (data.panCard != null)
              _buildDocumentItem(
                title: 'PAN Card',
                detail: _getDocumentStatus(data.panCard!.uploaded ?? false),
                isUploaded: data.panCard!.uploaded ?? false,
                isVerified: data.panCard!.verified ?? false,
                icon: Icons.credit_card,
                iconColor: Colors.orange,
                documentUrl: data.panCard!.url,
              ),
            if (data.aadhaarCard != null) ...[
              const SizedBox(height: 16),
              _buildDocumentItem(
                title: 'Aadhaar Card',
                detail: _getDocumentStatus(data.aadhaarCard!.uploaded ?? false),
                isUploaded: data.aadhaarCard!.uploaded ?? false,
                isVerified: data.aadhaarCard!.verified ?? false,
                icon: Icons.credit_card,
                iconColor: Colors.blue,
                documentUrl: data.aadhaarCard!.frontUrl,
              ),
            ],
            if (data.selfie != null) ...[
              const SizedBox(height: 16),
              _buildDocumentItem(
                title: 'Selfie',
                detail: _getDocumentStatus(data.selfie!.uploaded ?? false),
                isUploaded: data.selfie!.uploaded ?? false,
                isVerified: data.selfie!.verified ?? false,
                icon: Icons.photo_camera,
                iconColor: Colors.purple,
                documentUrl: data.selfie!.url,
              ),
            ],
            if (data.bankDetails != null) ...[
              const SizedBox(height: 16),
              _buildDocumentItem(
                title: 'Bank Details',
                detail: data.bankDetails!.provided == true
                    ? '${data.bankDetails!.bankName ?? ''} - Account ending in ${_getLastDigits(data.bankDetails!.accountNumber ?? '')}'
                    : 'Not provided',
                isUploaded: data.bankDetails!.provided ?? false,
                isVerified: data.bankDetails!.verified ?? false,
                icon: Icons.account_balance,
                iconColor: Colors.green,
                documentUrl: null,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getDocumentStatus(bool isUploaded) {
    return isUploaded ? 'Tap to view document' : 'Not uploaded';
  }

  String _getLastDigits(String accountNumber) {
    if (accountNumber.isNotEmpty && accountNumber.length >= 4) {
      return accountNumber.substring(accountNumber.length - 4);
    }
    return accountNumber;
  }

  Widget _buildDocumentItem({
    required String title,
    required String detail,
    required bool isUploaded,
    required bool isVerified,
    required IconData icon,
    required Color iconColor,
    String? documentUrl,
  }) {
    return GestureDetector(
      onTap: () {
        if (isUploaded && documentUrl != null && documentUrl.isNotEmpty) {
          _showDocumentPreview(documentUrl, title);
        } else if (isUploaded) {
          _showDocumentInfo(title);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isUploaded ? Colors.grey.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isUploaded ? Colors.grey.shade200 : Colors.grey.shade100,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
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
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isVerified)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Text(
                              'Verified',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade700,
                              ),
                            ),
                          )
                        else if (isUploaded)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.orange.shade700,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          isUploaded ? Icons.visibility : Icons.info_outline,
                          size: 12,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            detail,
                            style: TextStyle(
                              fontSize: 12,
                              color: isUploaded 
                                  ? Colors.blue.shade700 
                                  : Colors.grey.shade500,
                              fontWeight: isUploaded 
                                  ? FontWeight.w500 
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isUploaded && documentUrl != null)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey.shade400,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDocumentPreview(String imageUrl, String title) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Loading image...',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Failed to load image',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
            ],
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
              : documentType == 'Selfie'
              ? 'A clear selfie photo for identity verification.'
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
            Text('📧 Email: info@digifarmer.in'),
            SizedBox(height: 8),
            Text('📞 Phone: +91 9266157828'),
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
    Navigator.pushReplacementNamed(context, RoutesName.bottomNavBar);
  }
}