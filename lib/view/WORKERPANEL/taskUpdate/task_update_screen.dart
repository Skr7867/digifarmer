import 'dart:developer';
import 'dart:io';

import 'package:digifarmer/blocs/WORKERPANEL/taskUpdate/task_update_bloc.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class WorkerTaskUpdateScreen extends StatefulWidget {
  final String taskId;
  const WorkerTaskUpdateScreen({super.key, required this.taskId});

  @override
  State<WorkerTaskUpdateScreen> createState() => _WorkerTaskUpdateScreenState();
}

class _WorkerTaskUpdateScreenState extends State<WorkerTaskUpdateScreen> {
  // Form keys
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _workDoneController = TextEditingController();
  final TextEditingController _hoursWorkedController = TextEditingController();

  // Image picker
  final ImagePicker _imagePicker = ImagePicker();

  // Severity options
  final List<String> _severityOptions = ['LOW', 'MEDIUM', 'HIGH', 'URGENT'];

  // Unit options
  final List<String> _unitOptions = [
    'liters',
    'kg',
    'units',
    'hours',
    'pieces',
  ];

  late final TaskUpdateBloc _taskUpdateBloc;

  @override
  void initState() {
    super.initState();
    _taskUpdateBloc = TaskUpdateBloc(taskUpdateRepository: getIt());
  }

  @override
  void dispose() {
    _workDoneController.dispose();
    _hoursWorkedController.dispose();
    _taskUpdateBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _taskUpdateBloc,
      child: Scaffold(
        backgroundColor: const Color(0xffF4F6F8),
        appBar: CustomAppBar(
          title: "Update Task",
          gradient: const LinearGradient(
            colors: [Color(0xff34A853), Color(0xff0D47A1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          automaticallyImplyLeading: true,
        ),
        body: BlocListener<TaskUpdateBloc, TaskUpdateState>(
          listenWhen: (current, previous) =>
              current.postApiStatus != previous.postApiStatus,
          listener: (context, state) {
            if (state.postApiStatus == PostApiStatus.error) {
              FlushBarHelper.flushBarErrorMessage(state.message, context);
            }

            if (state.postApiStatus == PostApiStatus.success) {
              log('Task update successful: ${state.message}');
              FlushBarHelper.flushBarSuccessMessage(
                state.message.isNotEmpty
                    ? state.message
                    : 'Task updated successfully!',
                context,
              );

              // Navigate back after successful submission
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context, true);
              });
            }
          },
          child: BlocBuilder<TaskUpdateBloc, TaskUpdateState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(size.width * 0.04),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Task ID Info Card
                          _buildTaskInfoCard(size),

                          const SizedBox(height: 16),

                          // Required Fields Section
                          _buildSectionHeader(
                            icon: Icons.edit_note,
                            title: "Work Details",
                            subtitle: "Required Information",
                            color: Colors.blue,
                          ),

                          const SizedBox(height: 12),

                          // Work Done Field
                          _buildWorkDoneField(context),

                          const SizedBox(height: 16),

                          // Hours Worked Field
                          _buildHoursWorkedField(context),

                          const SizedBox(height: 24),

                          // Photos Section (Optional)
                          _buildSectionHeader(
                            icon: Icons.photo_library,
                            title: "Work Photos",
                            subtitle: "Add photos of your work (Optional)",
                            color: Colors.purple,
                          ),

                          const SizedBox(height: 12),

                          _buildPhotosSection(context, size),

                          const SizedBox(height: 24),

                          // Issues Section (Optional)
                          _buildSectionHeader(
                            icon: Icons.warning_amber_rounded,
                            title: "Issues Faced",
                            subtitle: "Report any problems (Optional)",
                            color: Colors.orange,
                          ),

                          const SizedBox(height: 12),

                          _buildIssuesSection(context, size),

                          const SizedBox(height: 24),

                          // Resources Section (Optional)
                          _buildSectionHeader(
                            icon: Icons.inventory,
                            title: "Resources Used",
                            subtitle: "Add resources utilized (Optional)",
                            color: Colors.green,
                          ),

                          const SizedBox(height: 12),

                          _buildResourcesSection(context, size),

                          const SizedBox(height: 32),

                          // Submit Button
                          _buildSubmitButton(context, size, state),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  // Loading Overlay
                  if (state.postApiStatus == PostApiStatus.loading)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Task Info Card
  Widget _buildTaskInfoCard(Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
              Icon(Icons.task_alt, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                "Task Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Task ID: ${widget.taskId}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: AppFonts.popins,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Complete the task details below. Fields marked with * are required.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Header
  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Work Done Field (Required)
  Widget _buildWorkDoneField(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: TextFormField(
        controller: _workDoneController,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: 'What work was done? *',
          hintText: 'e.g., Plowed 2 acres of land using tractor',
          labelStyle: const TextStyle(
            fontFamily: AppFonts.popins,
            fontSize: 14,
          ),
          hintStyle: TextStyle(
            fontFamily: AppFonts.popins,
            fontSize: 12,
            color: Colors.grey[400],
          ),
          border: _inputBorder(),
          enabledBorder: _inputBorder(),
          focusedBorder: _inputBorder(Colors.blue),
          prefixIcon: const Icon(Icons.work_outline, size: 20),
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please describe the work done';
          }
          return null;
        },
        onChanged: (value) {
          context.read<TaskUpdateBloc>().add(WorkDoneChanged(value));
        },
      ),
    );
  }

  /// Hours Worked Field (Required)
  Widget _buildHoursWorkedField(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: TextFormField(
        controller: _hoursWorkedController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Hours Worked *',
          hintText: 'e.g., 4',
          labelStyle: const TextStyle(
            fontFamily: AppFonts.popins,
            fontSize: 14,
          ),
          hintStyle: TextStyle(
            fontFamily: AppFonts.popins,
            fontSize: 12,
            color: Colors.grey[400],
          ),
          border: _inputBorder(),
          enabledBorder: _inputBorder(),
          focusedBorder: _inputBorder(Colors.blue),
          prefixIcon: const Icon(Icons.access_time, size: 20),
          suffixText: 'hours',
          suffixStyle: const TextStyle(fontFamily: AppFonts.popins),
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter hours worked';
          }
          if (int.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
        onChanged: (value) {
          final hours = int.tryParse(value) ?? 0;
          context.read<TaskUpdateBloc>().add(HoursWorkedChanged(hours));
        },
      ),
    );
  }

  /// Photos Section
  Widget _buildPhotosSection(BuildContext context, Size size) {
    return BlocBuilder<TaskUpdateBloc, TaskUpdateState>(
      buildWhen: (previous, current) => previous.photos != current.photos,
      builder: (context, state) {
        return Column(
          children: [
            // Add Photo Button
            GestureDetector(
              onTap: () => _showImageSourceDialog(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.purple.withOpacity(0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      color: Colors.purple[400],
                      size: 30,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add Photos',
                      style: TextStyle(
                        color: Colors.purple[700],
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Photos List
            if (state.photos.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  return _buildPhotoItem(context, index, size);
                },
              ),
          ],
        );
      },
    );
  }

  /// Photo Item
  Widget _buildPhotoItem(BuildContext context, int index, Size size) {
    return BlocBuilder<TaskUpdateBloc, TaskUpdateState>(
      builder: (context, state) {
        final photo = state.photos[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              // Image Preview
              if (photo['file'] != null)
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: FileImage(photo['file']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            context.read<TaskUpdateBloc>().add(
                              PhotoRemoved(index),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Caption Field
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  initialValue: photo['caption'] ?? '',
                  decoration: InputDecoration(
                    labelText: 'Caption (Optional)',
                    hintText: 'e.g., Before plowing',
                    labelStyle: const TextStyle(
                      fontFamily: AppFonts.popins,
                      fontSize: 12,
                    ),
                    border: _inputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  onChanged: (value) {
                    context.read<TaskUpdateBloc>().add(
                      PhotoCaptionChanged(index: index, caption: value),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Issues Section
  Widget _buildIssuesSection(BuildContext context, Size size) {
    return BlocBuilder<TaskUpdateBloc, TaskUpdateState>(
      buildWhen: (previous, current) => previous.issues != current.issues,
      builder: (context, state) {
        return Column(
          children: [
            // Add Issue Button
            GestureDetector(
              onTap: () {
                context.read<TaskUpdateBloc>().add(
                  IssueAdded({
                    'type': '',
                    'description': '',
                    'severity': 'MEDIUM',
                  }),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.orange.withOpacity(0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.add_alert, color: Colors.orange[700], size: 30),
                    const SizedBox(height: 8),
                    Text(
                      'Report an Issue',
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Issues List
            if (state.issues.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.issues.length,
                itemBuilder: (context, index) {
                  return _buildIssueItem(context, index, size);
                },
              ),
          ],
        );
      },
    );
  }

  /// Issue Item
  Widget _buildIssueItem(BuildContext context, int index, Size size) {
    return BlocBuilder<TaskUpdateBloc, TaskUpdateState>(
      builder: (context, state) {
        final issue = state.issues[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              // Header with Remove Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Issue #${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<TaskUpdateBloc>().add(IssueRemoved(index));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Issue Type
              DropdownButtonFormField<String>(
                initialValue: issue['type']?.isNotEmpty == true ? issue['type'] : null,
                hint: const Text(
                  'Select Issue Type *',
                  style: TextStyle(fontFamily: AppFonts.popins, fontSize: 12),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'EQUIPMENT_FAILURE',
                    child: Text('Equipment Failure'),
                  ),
                  DropdownMenuItem(
                    value: 'MATERIAL_SHORTAGE',
                    child: Text('Material Shortage'),
                  ),
                  DropdownMenuItem(
                    value: 'WEATHER',
                    child: Text('Weather Issue'),
                  ),
                  DropdownMenuItem(value: 'LABOR', child: Text('Labor Issue')),
                  DropdownMenuItem(value: 'OTHER', child: Text('Other')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.read<TaskUpdateBloc>().add(
                      IssueTypeChanged(index: index, type: value),
                    );
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Issue Type *',
                  border: _inputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select issue type';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // Description
              TextFormField(
                initialValue: issue['description'] ?? '',
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Describe the issue',
                  border: _inputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onChanged: (value) {
                  context.read<TaskUpdateBloc>().add(
                    IssueDescriptionChanged(index: index, description: value),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Severity
              DropdownButtonFormField<String>(
                initialValue: issue['severity'],
                items: _severityOptions.map((severity) {
                  return DropdownMenuItem(
                    value: severity,
                    child: Text(severity),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<TaskUpdateBloc>().add(
                      IssueSeverityChanged(index: index, severity: value),
                    );
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Severity',
                  border: _inputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Resources Section
  Widget _buildResourcesSection(BuildContext context, Size size) {
    return BlocBuilder<TaskUpdateBloc, TaskUpdateState>(
      buildWhen: (previous, current) => previous.resources != current.resources,
      builder: (context, state) {
        return Column(
          children: [
            // Add Resource Button
            GestureDetector(
              onTap: () {
                context.read<TaskUpdateBloc>().add(
                  ResourceAdded({'name': '', 'quantity': 1, 'unit': 'units'}),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.add_box, color: Colors.green[700], size: 30),
                    const SizedBox(height: 8),
                    Text(
                      'Add Resource Used',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Resources List
            if (state.resources.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.resources.length,
                itemBuilder: (context, index) {
                  return _buildResourceItem(context, index, size);
                },
              ),
          ],
        );
      },
    );
  }

  /// Resource Item
  Widget _buildResourceItem(BuildContext context, int index, Size size) {
    return BlocBuilder<TaskUpdateBloc, TaskUpdateState>(
      builder: (context, state) {
        final resource = state.resources[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              // Header with Remove Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Resource #${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<TaskUpdateBloc>().add(
                        ResourceRemoved(index),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Resource Name
              TextFormField(
                initialValue: resource['name'],
                decoration: InputDecoration(
                  labelText: 'Resource Name *',
                  hintText: 'e.g., Diesel, Tractor',
                  border: _inputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onChanged: (value) {
                  context.read<TaskUpdateBloc>().add(
                    ResourceNameChanged(index: index, name: value),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Quantity and Unit Row
              Row(
                children: [
                  // Quantity
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      initialValue: resource['quantity'].toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Qty *',
                        border: _inputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      onChanged: (value) {
                        final quantity = int.tryParse(value) ?? 1;
                        context.read<TaskUpdateBloc>().add(
                          ResourceQuantityChanged(
                            index: index,
                            quantity: quantity,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Unit
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      initialValue: resource['unit'],
                      items: _unitOptions.map((unit) {
                        return DropdownMenuItem(value: unit, child: Text(unit));
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context.read<TaskUpdateBloc>().add(
                            ResourceUnitChanged(index: index, unit: value),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Unit *',
                        border: _inputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Submit Button
  Widget _buildSubmitButton(
    BuildContext context,
    Size size,
    TaskUpdateState state,
  ) {
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
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: state.postApiStatus == PostApiStatus.loading
            ? null
            : () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<TaskUpdateBloc>().add(
                    SubmitTaskUpdate(taskId: widget.taskId),
                  );
                  
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: state.postApiStatus == PostApiStatus.loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Submit Task Update',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.popins,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  /// Helper Methods
  void _showImageSourceDialog(BuildContext context) {
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

 // Change the method signature - remove BuildContext parameter
Future<void> _pickImage(ImageSource source) async {
  try {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: source,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 80,
    );

    if (!mounted) return;  // ✅ uses State.mounted, no context needed

    if (pickedFile != null) {
      _taskUpdateBloc.add(          // ✅ use bloc directly, not context.read
        PhotoAdded({
          'file': File(pickedFile.path),
          'caption': '',
          'url': null,
        }),
      );
    }
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(  // ✅ uses State.context, always valid
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
