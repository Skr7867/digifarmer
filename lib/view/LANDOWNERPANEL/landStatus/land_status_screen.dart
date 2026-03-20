import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/LANDOWNERPANEL/landStatus/land_status_bloc.dart';
import '../../../main.dart';
import '../../../model/LANDOWNERSPANEL/landOwnerTimeLine/land_owner_timeline_model.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/enums.dart';

class LandStatusScreen extends StatefulWidget {
  const LandStatusScreen({super.key});

  @override
  State<LandStatusScreen> createState() => _LandStatusScreenState();
}

class _LandStatusScreenState extends State<LandStatusScreen> {
  late LandStatusBloc _landStatusBloc;
  LandOwnerTimelineLand? selectedLand;

  @override
  void initState() {
    super.initState();
    _landStatusBloc = LandStatusBloc(landStatusRepository: getIt());
    _landStatusBloc.add(const LandStatusFetched());
  }

  @override
  void dispose() {
    _landStatusBloc.close();
    super.dispose();
  }

  String getStepStatus(int stepIndex, int currentStep, String stepStatus) {
    if (stepIndex < currentStep) return 'Completed';
    if (stepIndex == currentStep) return stepStatus;
    return 'Pending';
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF10B981);
      case 'in progress':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF94A3B8);
    }
  }

  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle;
      case 'in progress':
        return Icons.autorenew;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  List<Map<String, String>> getTimelineSteps(LandOwnerTimelineLand land) {
    return [
      {
        'title': 'Application Submitted',
        'date': _formatDateTime(land.submittedAt),
        'description': 'Land details and documents uploaded successfully',
      },
      {
        'title': 'Document Verification',
        'date':
            'Expected: ${_formatDate(land.submittedAt.add(const Duration(days: 1)))}',
        'description': 'All documents verified and approved',
      },
      {
        'title': 'Field Verification',
        'date':
            'Expected: ${_formatDate(land.submittedAt.add(const Duration(days: 3)))}',
        'description':
            'Our team will visit your land for physical verification',
      },
      {
        'title': 'Final Approval',
        'date':
            'Expected: ${_formatDate(land.submittedAt.add(const Duration(days: 5)))}',
        'description': 'Land will be listed for investment opportunities',
      },
      {
        'title': 'Go Live',
        'date':
            'Expected: ${_formatDate(land.submittedAt.add(const Duration(days: 8)))}',
        'description': 'Your land will be available for investments',
      },
    ];
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_getMonth(dateTime.month)} ${dateTime.day}, ${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}';
  }

  String _formatDate(DateTime dateTime) {
    return '${_getMonth(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,
        title: 'Land Status',
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      backgroundColor: const Color(0xFFF3F5F8),
      body: BlocProvider(
        create: (_) => _landStatusBloc,
        child: BlocBuilder<LandStatusBloc, LandStatusState>(
          builder: (context, state) {
            switch (state.landStatus.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 60,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.landStatus.message ?? 'Something went wrong',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: AppFonts.popins,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () =>
                              _landStatusBloc.add(const LandStatusFetched()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Retry',
                            style: TextStyle(
                              fontFamily: AppFonts.popins,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

              case Status.completed:
                final timelineData = state.landStatus.data;
                if (timelineData == null || timelineData.data.lands.isEmpty) {
                  return const Center(
                    child: Text(
                      'No land records found',
                      style: TextStyle(
                        fontFamily: AppFonts.popins,
                        fontSize: 18,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  );
                }

                // Select first land if none selected
                if (selectedLand == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      selectedLand = timelineData.data.lands.first;
                    });
                  });
                  selectedLand = timelineData.data.lands.first;
                }

                return SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Land selector if multiple lands
                            if (timelineData.data.lands.length > 1)
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),

                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    _buildLandSelector(timelineData.data.lands),
                                    _HeaderSection(land: selectedLand!),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 24),
                            _ReviewTimeline(
                              land: selectedLand!,
                              getStepStatus: getStepStatus,
                              getStatusColor: getStatusColor,
                              getStatusIcon: getStatusIcon,
                              getTimelineSteps: getTimelineSteps,
                            ),
                            const SizedBox(height: 24),
                            _CurrentStatusCard(
                              land: selectedLand!,
                              getStepStatus: getStepStatus,
                              getStatusColor: getStatusColor,
                            ),
                            const SizedBox(height: 24),
                            const _ActionButtonsRow(),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                );

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLandSelector(List<LandOwnerTimelineLand> lands) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Land',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: lands.map((land) {
                final isSelected = selectedLand?.id == land.id;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLand = land;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2563EB)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2563EB)
                            : const Color(0xFFCBD5E1),
                      ),
                    ),
                    child: Text(
                      land.title,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF1E293B),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final LandOwnerTimelineLand land;

  const _HeaderSection({required this.land});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First row with title and ID
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Land Status',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                      color: Color(0xFF111111),
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Wrap for land name and badge
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      Text(
                        land.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E293B),
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusBadgeColor(land.status),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _getStatusBorderColor(land.status),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          land.status,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _getStatusTextColor(land.status),
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                      ),
                      if (land.isLive)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF4ADE80),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'LIVE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF166534),
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ID: ${land.landId}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF475569),
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Location and submitted date
        if (isSmallScreen)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${land.area} • ${land.location}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontFamily: AppFonts.popins,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Submitted on: ',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontFamily: AppFonts.popins,
                  ),

                  children: [
                    TextSpan(
                      text: _formatDate(land.submittedAt),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        else
          Row(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${land.area} • ${land.location}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: 'Submitted on: ',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontFamily: AppFonts.popins,
                  ),
                  children: [
                    TextSpan(
                      text: _formatDate(land.submittedAt),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  Color _getStatusBadgeColor(String status) {
    switch (status.toLowerCase()) {
      case 'under review':
        return const Color(0xFFFEF3C7);
      case 'approved':
        return const Color(0xFFDCFCE7);
      case 'rejected':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color _getStatusBorderColor(String status) {
    switch (status.toLowerCase()) {
      case 'under review':
        return const Color(0xFFFBBF24);
      case 'approved':
        return const Color(0xFF4ADE80);
      case 'rejected':
        return const Color(0xFFF87171);
      default:
        return const Color(0xFFCBD5E1);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'under review':
        return const Color(0xFF92400E);
      case 'approved':
        return const Color(0xFF166534);
      case 'rejected':
        return const Color(0xFF991B1B);
      default:
        return const Color(0xFF475569);
    }
  }

  String _formatDate(DateTime dateTime) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  }
}

class _ReviewTimeline extends StatelessWidget {
  final LandOwnerTimelineLand land;
  final String Function(int, int, String) getStepStatus;
  final Color Function(String) getStatusColor;
  final IconData Function(String) getStatusIcon;
  final List<Map<String, String>> Function(LandOwnerTimelineLand)
  getTimelineSteps;

  const _ReviewTimeline({
    required this.land,
    required this.getStepStatus,
    required this.getStatusColor,
    required this.getStatusIcon,
    required this.getTimelineSteps,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 500;
    final steps = getTimelineSteps(land);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Review Timeline',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Track your land registration progress',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 20),
        ...List.generate(steps.length, (index) {
          final step = steps[index];
          final stepStatus = getStepStatus(
            index,
            land.currentStep,
            land.stepStatus,
          );
          final isCompleted = stepStatus == 'Completed';
          final isInProgress = stepStatus == 'In Progress';
          final isLast = index == steps.length - 1;

          return _TimelineItem(
            title: step['title']!,
            status: stepStatus,
            date: step['date']!,
            description: step['description']!,
            isCompleted: isCompleted,
            isInProgress: isInProgress,
            isLast: isLast,
            isSmallScreen: isSmallScreen,
            statusColor: getStatusColor(stepStatus),
            statusIcon: getStatusIcon(stepStatus),
          );
        }),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String status;
  final String date;
  final String description;
  final bool isCompleted;
  final bool isInProgress;
  final bool isLast;
  final bool isSmallScreen;
  final Color statusColor;
  final IconData statusIcon;

  const _TimelineItem({
    required this.title,
    required this.status,
    required this.date,
    required this.description,
    required this.isCompleted,
    required this.isInProgress,
    required this.isLast,
    required this.isSmallScreen,
    required this.statusColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline icon and line
        SizedBox(
          width: 36,
          child: Column(
            children: [
              Icon(statusIcon, color: statusColor, size: 22),
              if (!isLast)
                Container(
                  width: 2,
                  height: isSmallScreen ? 80 : 60,
                  color: Colors.grey[300],
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and status badge
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Date
              Text(
                date,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF475569),
                  fontFamily: AppFonts.popins,
                ),
              ),
              const SizedBox(height: 4),
              // Description
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  fontFamily: AppFonts.popins,
                ),
                maxLines: isSmallScreen ? 3 : 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class _CurrentStatusCard extends StatelessWidget {
  final LandOwnerTimelineLand land;
  final String Function(int, int, String) getStepStatus;
  final Color Function(String) getStatusColor;

  const _CurrentStatusCard({
    required this.land,
    required this.getStepStatus,
    required this.getStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 500;
    final currentStepStatus = getStepStatus(
      land.currentStep,
      land.currentStep,
      land.stepStatus,
    );
    final statusColor = getStatusColor(currentStepStatus);

    String getStepTitle() {
      switch (land.currentStep) {
        case 0:
          return 'Application Submission';
        case 1:
          return 'Document Verification';
        case 2:
          return 'Field Verification';
        case 3:
          return 'Final Approval';
        case 4:
          return 'Go Live';
        default:
          return 'Field Verification';
      }
    }

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          if (isSmallScreen)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.timelapse,
                        size: 18,
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Current Status: ${getStepTitle()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 42),
                  child: Text(
                    'Estimated completion: 2–3 business days',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.timelapse, size: 20, color: statusColor),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Status: Field Verification',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Estimated completion: 2–3 business days',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          // Description
          const Text(
            'Our verification team will visit your land to confirm location, boundaries, and soil quality. You will receive a call 24 hours before the visit to schedule a convenient time.',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF334155),
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  const _ActionButtonsRow();

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 700;
    final isVerySmallScreen = MediaQuery.of(context).size.width < 500;

    if (isVerySmallScreen) {
      return Column(
        children: [
          _buildNeedHelpCard(context, isSmallScreen),
          const SizedBox(height: 12),
        ],
      );
    }

    if (isSmallScreen) {
      return Column(
        children: [
          _buildNeedHelpCard(context, isSmallScreen),
          const SizedBox(height: 12),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: _buildNeedHelpCard(context, isSmallScreen)),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildNeedHelpCard(BuildContext context, bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.headset_mic,
              size: 18,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Need Help?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Contact our support team',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 11 : 12,
                    color: const Color(0xFF64748B),
                    fontFamily: AppFonts.popins,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
            ),
            child: const Text(
              'Call Support',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2563EB),
                fontFamily: AppFonts.popins,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
