import 'dart:io';

import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  State<UploadDocumentsScreen> createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  // Document upload states
  File? _panCardFile;
  File? _aadhaarFrontFile;
  File? _aadhaarBackFile;

  bool _isUploadingPan = false;
  bool _isUploadingAadhaarFront = false;
  bool _isUploadingAadhaarBack = false;

  final ImagePicker _picker = ImagePicker();

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
          'Upload Documents',
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
              // Title
              const Text(
                'Upload clear photos of your PAN and Aadhaar documents for verification',
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
              ),
              const SizedBox(height: 32),

              // Upload Guidelines
              _buildUploadGuidelines(),
              const SizedBox(height: 32),

              // PAN Card Upload
              _buildDocumentUploadCard(
                title: 'PAN Card *',
                icon: Icons.credit_card,
                iconColor: Colors.orange,
                file: _panCardFile,
                isUploading: _isUploadingPan,
                onUpload: () => _uploadDocument('pan'),
                onRemove: () => _removeDocument('pan'),
              ),
              const SizedBox(height: 20),

              // Aadhaar Card Section
              Container(
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

                      // Aadhaar Front Side
                      _buildDocumentUploadItem(
                        label: 'Front Side *',
                        file: _aadhaarFrontFile,
                        isUploading: _isUploadingAadhaarFront,
                        onUpload: () => _uploadDocument('aadhaar_front'),
                        onRemove: () => _removeDocument('aadhaar_front'),
                      ),
                      const SizedBox(height: 16),

                      // Aadhaar Back Side
                      _buildDocumentUploadItem(
                        label: 'Back Side *',
                        file: _aadhaarBackFile,
                        isUploading: _isUploadingAadhaarBack,
                        onUpload: () => _uploadDocument('aadhaar_back'),
                        onRemove: () => _removeDocument('aadhaar_back'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildDocumentUploadCard(
                title: 'Upload Selfie *',
                icon: Icons.photo,
                iconColor: Colors.orange,
                file: _panCardFile,
                isUploading: _isUploadingPan,
                onUpload: () => _uploadDocument('pan'),
                onRemove: () => _removeDocument('pan'),
              ),
              const SizedBox(height: 20),

              // Secure Storage Note
              _buildSecureStorageNote(),
              const SizedBox(height: 32),

              // Continue Button
              _buildContinueButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

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
                Text('📂', style: TextStyle(fontSize: 20)),
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
            _buildGuidelineItem('Supported formats: JPG, PNG, PDF'),
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

  Widget _buildDocumentUploadCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required File? file,
    required bool isUploading,
    required VoidCallback onUpload,
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
              label: 'Upload PAN Card',
              file: file,
              isUploading: isUploading,
              onUpload: onUpload,
              onRemove: onRemove,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentUploadItem({
    required String label,
    required File? file,
    required bool isUploading,
    required VoidCallback onUpload,
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
        if (file != null) ...[
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
        ] else ...[
          if (isUploading)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
            )
          else
            GestureDetector(
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
                      Icons.cloud_upload,
                      size: 32,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap to browse or take photo',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }

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
                  'Your documents are encrypted and stored securely. We comply with all data protection regulations.',
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

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isFormValid() ? _continueToBankDetails : null,
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
        child: const Text(
          'Continue to Bank Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Future<void> _uploadDocument(String documentType) async {
    try {
      // Show image picker options
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.camera, documentType);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.gallery, documentType);
                },
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      _showErrorSnackBar('Error uploading document');
    }
  }

  Future<void> _pickImage(ImageSource source, String documentType) async {
    setState(() {
      _setUploadingState(documentType, true);
    });

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final File file = File(pickedFile.path);

        // Check file size (5MB limit)
        final int fileSizeInBytes = await file.length();
        final int fileSizeInMB = fileSizeInBytes ~/ (1024 * 1024);

        if (fileSizeInMB > 5) {
          _showErrorSnackBar('File size exceeds 5MB limit');
          setState(() {
            _setUploadingState(documentType, false);
          });
          return;
        }

        // Simulate upload (replace with actual upload logic)
        await Future.delayed(const Duration(seconds: 1));

        setState(() {
          _setDocumentFile(documentType, file);
          _setUploadingState(documentType, false);
        });

        _showSuccessSnackBar('Document uploaded successfully');
      } else {
        setState(() {
          _setUploadingState(documentType, false);
        });
      }
    } catch (e) {
      setState(() {
        _setUploadingState(documentType, false);
      });
      _showErrorSnackBar('Error picking image');
    }
  }

  void _removeDocument(String documentType) {
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
      }
    });
    _showSuccessSnackBar('Document removed');
  }

  void _setDocumentFile(String documentType, File file) {
    switch (documentType) {
      case 'pan':
        _panCardFile = file;
        break;
      case 'aadhaar_front':
        _aadhaarFrontFile = file;
        break;
      case 'aadhaar_back':
        _aadhaarBackFile = file;
        break;
    }
  }

  void _setUploadingState(String documentType, bool isUploading) {
    switch (documentType) {
      case 'pan':
        _isUploadingPan = isUploading;
        break;
      case 'aadhaar_front':
        _isUploadingAadhaarFront = isUploading;
        break;
      case 'aadhaar_back':
        _isUploadingAadhaarBack = isUploading;
        break;
    }
  }

  bool _isFormValid() {
    return _panCardFile != null &&
        _aadhaarFrontFile != null &&
        _aadhaarBackFile != null;
  }

  void _continueToBankDetails() {
    Navigator.pushNamed(context, RoutesName.kycVerificationStatusScreen);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Documents uploaded successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
