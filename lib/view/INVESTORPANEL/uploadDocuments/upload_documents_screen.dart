import 'dart:io';

import 'package:digifarmer/blocs/INVESTORPANEL/documentUpload/document_upload_bloc.dart';
import 'package:digifarmer/blocs/INVESTORPANEL/submitKycDocuments/submit_kyc_documents_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/repository/INVESTORPANEL/documentUpload/document_upload_http_repository.dart';
import 'package:digifarmer/repository/INVESTORPANEL/submitKycDocuments/submit_kyc_documents_http_repository.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../utils/enums.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  State<UploadDocumentsScreen> createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  File? _panCardFile;
  File? _aadhaarFrontFile;
  File? _aadhaarBackFile;
  File? _selfieFile;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              DocumentUploadBloc(repository: DocumentUploadHttpRepository()),
        ),
        BlocProvider(
          create: (_) =>
              SubmitKycDocumentsBloc(SubmitKycDocumentsHttpRepository()),
        ),
      ],
      child: Builder(
        builder: (blocContext) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: 'Upload Documents',
              automaticallyImplyLeading: true,
              gradient: const LinearGradient(
                colors: [Color(0xff34A853), Color(0xff0D47A1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            body: BlocListener<SubmitKycDocumentsBloc, SubmitKycDocumentsState>(
              listener: (listenerContext, submitState) {
                if (submitState.postApiStatus == PostApiStatus.success) {
                  FlushBarHelper.flushBarSuccessMessage(
                    submitState.messages,
                    listenerContext,
                  );
                  Navigator.pushReplacementNamed(
                    listenerContext,
                    RoutesName.kycVerificationStatusScreen,
                  );
                } else if (submitState.postApiStatus == PostApiStatus.error) {
                  FlushBarHelper.flushBarErrorMessage(
                    submitState.messages,
                    listenerContext,
                  );
                }
              },
              child: BlocBuilder<DocumentUploadBloc, DocumentUploadState>(
                builder: (builderContext, state) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Upload clear photos of your PAN, Aadhaar, and Selfie for verification',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 32),

                          _buildUploadGuidelines(),
                          const SizedBox(height: 32),

                          _buildDocumentUploadCard(
                            context: builderContext,
                            title: 'PAN Card *',
                            icon: Icons.credit_card,
                            iconColor: Colors.orange,
                            file: _panCardFile,
                            status: state.panStatus,
                            onUpload: () => _pickImage(
                              ImageSource.gallery,
                              'pan',
                              builderContext,
                            ),
                            onCamera: () => _pickImage(
                              ImageSource.camera,
                              'pan',
                              builderContext,
                            ),
                            onRemove: () =>
                                _removeDocument('pan', builderContext),
                          ),
                          const SizedBox(height: 20),

                          _buildAadhaarSection(state, builderContext),
                          const SizedBox(height: 20),

                          _buildDocumentUploadCard(
                            context: builderContext,
                            title: 'Selfie *',
                            icon: Icons.photo_camera,
                            iconColor: Colors.purple,
                            file: _selfieFile,
                            status: state.selfieStatus,
                            onUpload: () => _pickImage(
                              ImageSource.gallery,
                              'selfie',
                              builderContext,
                            ),
                            onCamera: () => _pickImage(
                              ImageSource.camera,
                              'selfie',
                              builderContext,
                            ),
                            onRemove: () =>
                                _removeDocument('selfie', builderContext),
                          ),
                          const SizedBox(height: 20),

                          _buildSecureStorageNote(),
                          const SizedBox(height: 32),

                          // Submit Button
                          _buildSubmitButton(state, builderContext),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Aadhaar Section

  Widget _buildAadhaarSection(DocumentUploadState state, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.credit_card,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Aadhaar Card *',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Upload both front and back sides',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            _buildDocumentUploadItem(
              label: 'Front Side *',
              file: _aadhaarFrontFile,
              status: state.aadhaarFrontStatus,
              onUpload: () =>
                  _pickImage(ImageSource.gallery, 'aadhaar_front', context),
              onCamera: () =>
                  _pickImage(ImageSource.camera, 'aadhaar_front', context),
              onRemove: () => _removeDocument('aadhaar_front', context),
            ),
            const SizedBox(height: 16),

            _buildDocumentUploadItem(
              label: 'Back Side *',
              file: _aadhaarBackFile,
              status: state.aadhaarBackStatus,
              onUpload: () =>
                  _pickImage(ImageSource.gallery, 'aadhaar_back', context),
              onCamera: () =>
                  _pickImage(ImageSource.camera, 'aadhaar_back', context),
              onRemove: () => _removeDocument('aadhaar_back', context),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Document Upload Card
  // ─────────────────────────────────────────────────────────────

  Widget _buildDocumentUploadCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color iconColor,
    required File? file,
    required UploadStatus status,
    required VoidCallback onUpload,
    required VoidCallback onCamera,
    required VoidCallback onRemove,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDocumentUploadItem(
              label: 'Upload $title',
              file: file,
              status: status,
              onUpload: onUpload,
              onCamera: onCamera,
              onRemove: onRemove,
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Document Upload Item (shared UI for each slot)
  // ─────────────────────────────────────────────────────────────

  Widget _buildDocumentUploadItem({
    required String label,
    required File? file,
    required UploadStatus status,
    required VoidCallback onUpload,
    required VoidCallback onCamera,
    required VoidCallback onRemove,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),

        // ── Completed ──
        if (file != null && status == UploadStatus.completed) ...[
          Container(
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade600,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'File uploaded successfully',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.green.shade700,
                          ),
                        ),
                        Text(
                          file.path.split('/').last,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: onRemove,
                  ),
                ],
              ),
            ),
          ),

          // ── Loading ──
        ] else if (status == UploadStatus.loading) ...[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text('Uploading...'),
                ],
              ),
            ),
          ),

          // ── Error ──
        ] else if (status == UploadStatus.error) ...[
          GestureDetector(
            onTap: onUpload, // tap to retry
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red.shade700,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload failed. Tap to retry',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Initial / idle ──
        ] else ...[
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onUpload,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo_library,
                          size: 28,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: onCamera,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 28,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Guidelines
  // ─────────────────────────────────────────────────────────────

  Widget _buildUploadGuidelines() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('📂', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  'Upload Guidelines',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildGuidelineItem('Ensure documents are clearly visible'),
            _buildGuidelineItem('Avoid shadows or glare'),
            _buildGuidelineItem('Max file size: 5MB per document'),
            _buildGuidelineItem('Supported formats: JPG, PNG'),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 16, color: Colors.green.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Secure Storage Note
  // ─────────────────────────────────────────────────────────────

  Widget _buildSecureStorageNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.security, color: Colors.green.shade700, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Document Storage',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your documents are encrypted and stored securely. '
                  'We comply with all data protection regulations.',
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

  // ─────────────────────────────────────────────────────────────
  // Submit Button (Updated)
  // ─────────────────────────────────────────────────────────────

  Widget _buildSubmitButton(DocumentUploadState state, BuildContext context) {
    return BlocBuilder<SubmitKycDocumentsBloc, SubmitKycDocumentsState>(
      builder: (context, submitState) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                state.isAllDocumentsUploaded &&
                    submitState.postApiStatus != PostApiStatus.loading
                ? () => _submitKycDocuments(context)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              disabledBackgroundColor: Colors.grey.shade300,
            ),
            child: submitState.postApiStatus == PostApiStatus.loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Submit Documents',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Submit KYC Documents
  // ─────────────────────────────────────────────────────────────

  Future<void> _submitKycDocuments(BuildContext context) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Trigger the submit API call
      context.read<SubmitKycDocumentsBloc>().add(SubmitKycDocuments());

      // Note: Navigation and error handling are done in the BlocListener
      // The dialog will be dismissed when the listener handles the response
    } catch (e) {
      Navigator.pop(context); // Dismiss dialog on error
      FlushBarHelper.flushBarErrorMessage(
        'Error submitting documents: ${e.toString()}',
        context,
      );
    }
  }

  // ─────────────────────────────────────────────────────────────
  // Pick Image
  // ─────────────────────────────────────────────────────────────

  Future<void> _pickImage(
    ImageSource source,
    String documentType,
    BuildContext context,
  ) async {
    final bloc = context.read<DocumentUploadBloc>();

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 80,
      );

      if (pickedFile == null) return;

      final File file = File(pickedFile.path);

      final int fileSizeInBytes = await file.length();
      final double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 5) {
        if (mounted) {
          FlushBarHelper.flushBarErrorMessage(
            'File size exceeds 5MB limit',
            context,
          );
        }
        return;
      }

      switch (documentType) {
        case 'pan':
          if (mounted) setState(() => _panCardFile = file);
          bloc.add(UploadPanCard(file: file));
          break;
        case 'aadhaar_front':
          if (mounted) setState(() => _aadhaarFrontFile = file);
          bloc.add(UploadAadhaarFront(file: file));
          break;
        case 'aadhaar_back':
          if (mounted) setState(() => _aadhaarBackFile = file);
          bloc.add(UploadAadhaarBack(file: file));
          break;
        case 'selfie':
          if (mounted) setState(() => _selfieFile = file);
          bloc.add(UploadSelfie(file: file));
          break;
      }
    } catch (e) {
      if (mounted) {
        FlushBarHelper.flushBarErrorMessage(
          'Error picking image: ${e.toString()}',
          context,
        );
      }
    }
  }

  // ─────────────────────────────────────────────────────────────
  // Remove Document
  // ─────────────────────────────────────────────────────────────

  void _removeDocument(String documentType, BuildContext context) {
    final bloc = context.read<DocumentUploadBloc>();

    setState(() {
      switch (documentType) {
        case 'pan':
          _panCardFile = null;
          break;
        case 'aadhaar_front':
          _aadhaarFrontFile = null;
          break;
        case 'aadhaar_back':
          _aadhaarBackFile = null;
          break;
        case 'selfie':
          _selfieFile = null;
          break;
      }
    });

    bloc.add(ResetUploadStatus(documentType: documentType));
    FlushBarHelper.flushBarSuccessMessage('Document removed', context);
  }
}
