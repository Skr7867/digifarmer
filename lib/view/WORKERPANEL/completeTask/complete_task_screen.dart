// lib/screens/WORKERPANEL/completeTask/worker_complete_task_screen.dart

import 'dart:developer';
import 'dart:io';

import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../blocs/WORKERPANEL/completeTask/complete_task_bloc.dart';
import '../../../main.dart'; // For getIt
import '../../../repository/WORKERPANEL/completeTask/complete_task_repository.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/enums.dart';
import '../../../utils/flush_bar_helper.dart';

class WorkerCompleteTaskScreen extends StatefulWidget {
  final String taskId;
  final String taskTitle;

  const WorkerCompleteTaskScreen({
    super.key,
    required this.taskId,
    required this.taskTitle,
  });

  @override
  State<WorkerCompleteTaskScreen> createState() =>
      _WorkerCompleteTaskScreenState();
}

class _WorkerCompleteTaskScreenState extends State<WorkerCompleteTaskScreen> {
  // Controllers for text fields
  final TextEditingController _workDoneController = TextEditingController();
  final TextEditingController _hoursWorkedController = TextEditingController();
  final TextEditingController _completionNotesController =
      TextEditingController();

  // Image picker
  final ImagePicker _imagePicker = ImagePicker();

  // BLoC instance
  late final CompleteTaskBloc _completeTaskBloc;

  @override
  void initState() {
    super.initState();
    // Initialize BLoC with repository from GetIt
    _completeTaskBloc = CompleteTaskBloc(
      completeTaskRepository: getIt<CompleteTaskRepository>(),
    );
    _setupControllers();
  }

  void _setupControllers() {
    // Listen to controller changes and dispatch events
    _workDoneController.addListener(() {
      _completeTaskBloc.add(WorkDoneChanged(_workDoneController.text));
    });

    _hoursWorkedController.addListener(() {
      final text = _hoursWorkedController.text;
      if (text.isNotEmpty) {
        final hours = int.tryParse(text) ?? 0;
        _completeTaskBloc.add(HoursWorkedChanged(hours));
      } else {
        _completeTaskBloc.add(HoursWorkedChanged(0));
      }
    });

    _completionNotesController.addListener(() {
      _completeTaskBloc.add(
        CompletionNotesChanged(_completionNotesController.text),
      );
    });
  }

  @override
  void dispose() {
    _workDoneController.dispose();
    _hoursWorkedController.dispose();
    _completionNotesController.dispose();
    _completeTaskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return BlocProvider<CompleteTaskBloc>.value(
      value: _completeTaskBloc,
      child: BlocListener<CompleteTaskBloc, CompleteTaskState>(
        listener: (context, state) {
          if (state.postApiStatus == PostApiStatus.success) {
            FlushBarHelper.flushBarSuccessMessage(
              state.message.isNotEmpty
                  ? state.message
                  : 'Task completed successfully!',
              context,
            );
            Future.delayed(const Duration(seconds: 2), () {
              // if (mounted) Navigator.pop(context);
              Navigator.pushNamed(context, RoutesName.workerBottomNavBar);
            });
          } else if (state.postApiStatus == PostApiStatus.error) {
            FlushBarHelper.flushBarErrorMessage(
              state.message.isNotEmpty
                  ? state.message
                  : 'Failed to complete task',
              context,
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xffF4F6F8),
          appBar: CustomAppBar(
            title: "Complete Task",
            gradient: const LinearGradient(
              colors: [Color(0xff34A853), Color(0xff0D47A1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            automaticallyImplyLeading: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(isTablet ? 24 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Celebration Header
                _buildCelebrationHeader(size),

                const SizedBox(height: 24),

                // Task Summary Card
                _buildTaskSummaryCard(size),

                const SizedBox(height: 24),

                // Completion Form
                _buildCompletionForm(size),

                const SizedBox(height: 32),

                // Submit Button with BlocBuilder
                BlocBuilder<CompleteTaskBloc, CompleteTaskState>(
                  builder: (context, state) {
                    return _buildSubmitButton(
                      size,
                      isLoading: state.postApiStatus == PostApiStatus.loading,
                    );
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Celebration Header
  Widget _buildCelebrationHeader(Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Animated Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAnimatedIcon(Icons.emoji_events, Colors.amber, 0),
              _buildAnimatedIcon(Icons.star, Colors.yellow, 0.2),
              _buildAnimatedIcon(Icons.celebration, Colors.orange, 0.4),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            "Great Work!",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppFonts.popins,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "You're about to complete this task",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
              fontFamily: AppFonts.popins,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Confetti Effect (simulated with dots)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(20, (index) {
              return Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: [
                    Colors.red,
                    Colors.blue,
                    Colors.yellow,
                    Colors.green,
                    Colors.purple,
                  ][index % 5],
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  /// Animated Icon Helper
  Widget _buildAnimatedIcon(IconData icon, Color color, double delay) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.elasticOut,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 30),
          ),
        );
      },
    );
  }

  /// Task Summary Card
  Widget _buildTaskSummaryCard(Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.task_alt, color: Color(0xff34A853), size: 24),
              SizedBox(width: 8),
              Text(
                "Task Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSummaryRow(
                  "Task ID",
                  widget.taskId,
                  Icons.confirmation_number,
                ),
                const Divider(height: 16),
                _buildSummaryRow("Task Title", widget.taskTitle, Icons.title),
                const Divider(height: 16),
                BlocBuilder<CompleteTaskBloc, CompleteTaskState>(
                  builder: (context, state) {
                    return _buildSummaryRow(
                      "Status",
                      state.postApiStatus == PostApiStatus.loading
                          ? "Submitting..."
                          : "In Progress",
                      Icons.pending_actions,
                      valueColor: state.postApiStatus == PostApiStatus.loading
                          ? Colors.blue
                          : Colors.orange,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Summary Row Helper
  Widget _buildSummaryRow(
    String label,
    String value,
    IconData icon, {
    Color valueColor = Colors.black87,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontFamily: AppFonts.popins,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: valueColor,
              fontFamily: AppFonts.popins,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Completion Form
  Widget _buildCompletionForm(Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form Header
          const Row(
            children: [
              Icon(Icons.edit_document, color: Color(0xff0D47A1), size: 24),
              SizedBox(width: 8),
              Text(
                "Completion Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            "All fields are optional. Fill in what you'd like to report.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontFamily: AppFonts.popins,
              fontStyle: FontStyle.italic,
            ),
          ),

          const SizedBox(height: 20),

          // Work Done Field
          _buildWorkDoneField(),

          const SizedBox(height: 16),

          // Hours Worked Field
          _buildHoursWorkedField(),

          const SizedBox(height: 16),

          // Completion Notes Field
          _buildCompletionNotesField(),

          const SizedBox(height: 20),

          // Photos Section
          _buildPhotosSection(size),
        ],
      ),
    );
  }

  /// Work Done Field
  Widget _buildWorkDoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Work Done",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: _cardDecoration(),
          child: TextFormField(
            controller: _workDoneController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  'e.g., Harvesting completed for all 5 acres of wheat field',
              hintStyle: TextStyle(
                fontFamily: AppFonts.popins,
                fontSize: 12,
                color: Colors.grey[400],
              ),
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(Colors.green),
              prefixIcon: const Icon(
                Icons.work_outline,
                color: Colors.green,
                size: 20,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  /// Hours Worked Field
  Widget _buildHoursWorkedField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hours Worked",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: _cardDecoration(),
          child: TextFormField(
            controller: _hoursWorkedController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'e.g., 8',
              hintStyle: TextStyle(
                fontFamily: AppFonts.popins,
                fontSize: 12,
                color: Colors.grey[400],
              ),
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(Colors.green),
              prefixIcon: const Icon(
                Icons.access_time,
                color: Colors.green,
                size: 20,
              ),
              suffixText: 'hours',
              suffixStyle: const TextStyle(fontFamily: AppFonts.popins),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  /// Completion Notes Field
  Widget _buildCompletionNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Completion Notes",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: _cardDecoration(),
          child: TextFormField(
            controller: _completionNotesController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  'e.g., All crops harvested successfully. Yield is good.',
              hintStyle: TextStyle(
                fontFamily: AppFonts.popins,
                fontSize: 12,
                color: Colors.grey[400],
              ),
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(Colors.green),
              prefixIcon: const Icon(
                Icons.note_alt,
                color: Colors.green,
                size: 20,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  /// Photos Section with BlocBuilder
  Widget _buildPhotosSection(Size size) {
    return BlocBuilder<CompleteTaskBloc, CompleteTaskState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Completion Photos",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.popins,
              ),
            ),

            const SizedBox(height: 8),

            // Add Photo Button
            GestureDetector(
              onTap: _showImageSourceDialog,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.3),
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.add_a_photo, color: Colors.green[700], size: 40),
                    const SizedBox(height: 8),
                    Text(
                      'Add Completion Photos',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Show your completed work',
                      style: TextStyle(
                        color: Colors.green[600],
                        fontSize: 12,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Photos Grid
            if (state.photos.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 600 ? 4 : 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  return _buildPhotoItem(index, size, state.photos[index]);
                },
              ),
          ],
        );
      },
    );
  }

  /// Photo Item
  Widget _buildPhotoItem(int index, Size size, Map<String, dynamic> photo) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: photo['file'] != null
                  ? FileImage(photo['file'])
                  : NetworkImage(photo['url'] ?? '') as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Remove Button
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              _completeTaskBloc.add(PhotoRemoved(index));
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 14),
            ),
          ),
        ),

        // Caption Overlay
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: TextFormField(
              initialValue: photo['caption'] ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 10),
              decoration: InputDecoration(
                hintText: 'Add caption',
                hintStyle: const TextStyle(color: Colors.white70, fontSize: 10),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                _completeTaskBloc.add(
                  PhotoCaptionChanged(index: index, caption: value),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Submit Button
  Widget _buildSubmitButton(Size size, {required bool isLoading}) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : _submitTaskCompletion,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Submitting...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.popins,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Complete Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.popins,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// Helper Methods
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text(
                  'Choose from Gallery',
                  style: TextStyle(fontFamily: AppFonts.popins),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.green),
                title: const Text(
                  'Take a Photo',
                  style: TextStyle(fontFamily: AppFonts.popins),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        // Create photo data with file reference and placeholder URL
        final Map<String, dynamic> photoData = {
          'file': File(pickedFile.path),
          'caption': '',
          'url':
              'https://example.com/placeholder.jpg', // Will be replaced by backend
        };

        // Add to BLoC state using the bloc instance
        _completeTaskBloc.add(PhotoAdded(photoData));

        log('Photo added: ${pickedFile.path}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error picking image: $e',
            style: const TextStyle(fontFamily: AppFonts.popins),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _submitTaskCompletion() {
    log('Submitting task completion for task ID: ${widget.taskId}');
    _completeTaskBloc.add(SubmitCompleteTask(taskId: widget.taskId));
  }

  /// Common Card Decoration
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          blurRadius: 5,
          color: Colors.grey.withOpacity(0.1),
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// Input Border
  OutlineInputBorder _inputBorder([Color color = Colors.grey]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color.withOpacity(0.3)),
    );
  }
}
