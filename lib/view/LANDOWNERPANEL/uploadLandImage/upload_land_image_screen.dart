import 'dart:developer';
import 'dart:io';

import 'package:digifarmer/main.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../blocs/LANDOWNERPANEL/landImage/land_image_bloc.dart';
import '../../../model/LANDOWNERSPANEL/preSignedUrlRequest/confirm_upload_response.dart';
import '../../../repository/LANDOWNERPANEL/landImage/land_image_repository.dart';

class UploadLandImagesScreen extends StatefulWidget {
  final String tempId;

  const UploadLandImagesScreen({super.key, required this.tempId});

  @override
  State<UploadLandImagesScreen> createState() => _UploadLandImagesScreenState();
}

class _UploadLandImagesScreenState extends State<UploadLandImagesScreen> {
  late final LandImagesBloc _landImagesBloc;
  final ImagePicker _picker = ImagePicker();
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    log("📸 UploadLandImagesScreen - TEMP ID: ${widget.tempId}");
    _landImagesBloc = LandImagesBloc(getIt<LandImagesRepository>());
    _landImagesBloc.add(SetTempId(widget.tempId));
  }

  @override
  void dispose() {
    _landImagesBloc.close();
    super.dispose();
  }

  Future<void> _pickImage(int index) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);

        _landImagesBloc.add(
          AddLandImage(
            index: index,
            imageFile: imageFile,
            imageType: _getImageTypeFromIndex(index),
            description: _getDescriptionFromIndex(index),
          ),
        );
      }
    } catch (e) {
      FlushBarHelper.flushBarErrorMessage("Error picking image: $e", context);
    }
  }

  ImageType _getImageTypeFromIndex(int index) {
    switch (index) {
      case 0:
        return ImageType.FRONT_VIEW;
      case 1:
        return ImageType.LANDSCAPE;
      case 2:
        return ImageType.ROAD_ACCESS;
      case 3:
        return ImageType.SOIL_QUALITY;
      case 4:
        return ImageType.WATER_SOURCE;
      case 5:
        return ImageType.BOUNDARY;
      default:
        return ImageType.FRONT_VIEW;
    }
  }

  String _getDescriptionFromIndex(int index) {
    const descriptions = [
      'Front view of land',
      'Landscape view',
      'Road access point',
      'Soil quality',
      'Water source',
      'Boundary markers',
      'Front view of land',
    ];
    return index < descriptions.length ? descriptions[index] : 'Land image';
  }

  Future<void> _submitLand() async {
    // Step 1: Generate presigned URLs
    _landImagesBloc.add(GeneratePresignedUrls());
  }

  void _showImagePickerDialog(int index) {
    setState(() {
      selectedIndex = index;
    });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  try {
                    final XFile? pickedFile = await _picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                      maxWidth: 1080,
                      maxHeight: 1080,
                    );
                    if (pickedFile != null) {
                      final imageFile = File(pickedFile.path);
                      _landImagesBloc.add(
                        AddLandImage(
                          index: index,
                          imageFile: imageFile,
                          imageType: _getImageTypeFromIndex(index),
                          description: _getDescriptionFromIndex(index),
                        ),
                      );
                    }
                  } catch (e) {
                    FlushBarHelper.flushBarErrorMessage(
                      "Error taking photo: $e",
                      context,
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _landImagesBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Upload Land Images',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Registration Progress',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Step 3 of 3',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 1.0,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF00A86B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        body: BlocListener<LandImagesBloc, LandImagesState>(
          listenWhen: (previous, current) =>
              previous.postApiStatus != current.postApiStatus,
          listener: (context, state) {
            if (state.postApiStatus == PostApiStatus.error) {
              FlushBarHelper.flushBarErrorMessage(state.message, context);
            }

            if (state.postApiStatus == PostApiStatus.success) {
              if (state.presignedData.isNotEmpty &&
                  state.postApiStatus == PostApiStatus.success &&
                  !state.allUploadsComplete) {
                // After getting presigned URLs, start uploading
                _landImagesBloc.add(UploadFilesToS3());
              } else if (state.allUploadsComplete &&
                  state.confirmResponse == null) {
                // After all uploads complete, confirm
                _landImagesBloc.add(ConfirmUpload());
              } else if (state.confirmResponse != null) {
                // Final success - navigate or show success
                FlushBarHelper.flushBarSuccessMessage(state.message, context);

                // Navigate to success screen or home
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                });
              }
            }
          },
          child: BlocBuilder<LandImagesBloc, LandImagesState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Upload Photos Section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Upload Land Photos',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Add clear photos of your land for verification.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Photo Guidelines
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Photo Guidelines:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildGuidelineItem(
                                    '• Take photos from different angles',
                                  ),
                                  _buildGuidelineItem(
                                    '• Include boundary markers if available',
                                  ),
                                  _buildGuidelineItem(
                                    '• Ensure good lighting and clarity',
                                  ),
                                  _buildGuidelineItem(
                                    '• Maximum 8 photos allowed',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Image Gallery Section
                      const Text(
                        'Image Gallery',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Gallery Grid
                      // Gallery Grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.2,
                        children: List.generate(8, (index) {
                          final imageFile = state.landImages[index];
                          final uploadStatus = state.uploadStatus[index];

                          return GestureDetector(
                            onTap: () => _showImagePickerDialog(index),
                            child: _buildGalleryItem(
                              '${index + 1}',
                              _getTitleFromIndex(index),
                              imageFile: imageFile
                                  ?.file, // ✅ Correct: access the file property
                              isUploaded: uploadStatus == true,
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 24),

                      // Upload Summary
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Upload Summary',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Size:',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${state.totalUploadedCount}/8 Photos',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Status:',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  state.allUploadsComplete
                                      ? 'Upload Complete'
                                      : '${state.totalUploadedCount * 100 ~/ 8}%',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF00A86B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Pro Tips
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF00A86B).withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pro Tips',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF00A86B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildTipItem(
                              '• Photos help investors make better decisions',
                            ),
                            _buildTipItem(
                              '• Clear images increase approval chances',
                            ),
                            _buildTipItem(
                              '• You can edit photos after submission',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                // Skip for now - maybe navigate to home
                                Navigator.popUntil(
                                  context,
                                  (route) => route.isFirst,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey[400]!),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Skip for Now',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed:
                                  state.postApiStatus == PostApiStatus.loading
                                  ? null
                                  : _submitLand,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00A86B),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child:
                                  state.postApiStatus == PostApiStatus.loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Submit Land',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getTitleFromIndex(int index) {
    const titles = [
      'Front View',
      'Landscape',
      'Road Access',
      'Soil Quality',
      'Water Source',
      'Boundaries',
      'Additional',
      'Extra',
    ];
    return titles[index];
  }

  Widget _buildGuidelineItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
      ),
    );
  }

  Widget _buildGalleryItem(
    String number,
    String title, {
    File? imageFile,
    bool isUploaded = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isUploaded ? const Color(0xFF00A86B) : Colors.grey[300]!,
          width: isUploaded ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: imageFile != null
          ? Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.file(imageFile, fit: BoxFit.cover),
                ),
                if (isUploaded)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFF00A86B),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$number. ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap to add',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                ),
              ],
            ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, color: Colors.grey[800]),
      ),
    );
  }
}
