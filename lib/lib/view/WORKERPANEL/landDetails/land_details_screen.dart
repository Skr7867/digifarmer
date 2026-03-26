import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/WORKERPANEL/landDetails/land_details_bloc.dart';
import '../../../model/WORKERPANEL/landDetails/land_details_model.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/enums.dart';

class LandDetailsScreen extends StatefulWidget {
  final String taskId;

  const LandDetailsScreen({super.key, required this.taskId});

  @override
  State<LandDetailsScreen> createState() => _LandDetailsScreenState();
}

class _LandDetailsScreenState extends State<LandDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  static const _gradient = LinearGradient(
    colors: [Color(0xff1E88E5), Color(0xff2BB673)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();

    // ── Trigger BLoC fetch ──────────────────────────────────────
    context.read<LandDetailsBloc>().add(LandDetailsFetched(widget.taskId));
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  

  String _formatShortDate(String? iso) {
    if (iso == null) return '--';
    try {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(iso).toLocal());
    } catch (_) {
      return '--';
    }
  }

  Color _statusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'COMPLETED':
        return const Color(0xff2BB673);
      case 'IN_PROGRESS':
        return const Color(0xff1E88E5);
      case 'PENDING':
        return const Color(0xffFB8C00);
      case 'CANCELLED':
        return const Color(0xffE53935);
      default:
        return const Color(0xff9E9E9E);
    }
  }

  Color _priorityColor(String? priority) {
    switch (priority?.toUpperCase()) {
      case 'URGENT':
        return const Color(0xffE53935);
      case 'HIGH':
        return const Color(0xffFB8C00);
      case 'MEDIUM':
        return const Color(0xff1E88E5);
      case 'LOW':
        return const Color(0xff2BB673);
      default:
        return const Color(0xff9E9E9E);
    }
  }

  IconData _taskTypeIcon(String? type) {
    switch (type?.toUpperCase()) {
      case 'FERTILIZER':
        return Icons.grass_rounded;
      case 'IRRIGATION':
        return Icons.water_drop_rounded;
      case 'HARVESTING':
        return Icons.agriculture_rounded;
      case 'PLOWING':
        return Icons.construction_rounded;
      case 'PEST_CONTROL':
        return Icons.bug_report_rounded;
      case 'PLANTING':
        return Icons.eco_rounded;
      case 'GENERAL':
        return Icons.task_alt_rounded;
      default:
        return Icons.task_alt_rounded;
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final padding = isTablet ? 24.0 : 16.0;

    return BlocBuilder<LandDetailsBloc, LandDetailsState>(
      builder: (context, state) {
        // ── Derive task title for AppBar dynamically ────────────
        final taskId = state.landDetails.data?.tasks?.isNotEmpty == true
            ? state.landDetails.data!.tasks!.first.taskId ?? 'Land Details'
            : 'Land Details';

        return Scaffold(
          backgroundColor: const Color(0xffF4F6F9),
          appBar: CustomAppBar(
            title: taskId,
            gradient: _gradient,
            automaticallyImplyLeading: true,
          ),
          body: _buildBody(state, isTablet, padding),
        );
      },
    );
  }

  // ── Body switcher based on ApiResponse status ────────────────────
  Widget _buildBody(LandDetailsState state, bool isTablet, double padding) {
    switch (state.landDetails.status) {
      case Status.loading:
        return _buildShimmer(isTablet, padding);

      case Status.error:
        return _buildError(state.landDetails.message ?? 'Something went wrong');

      case Status.completed:
        final tasks = state.landDetails.data?.tasks ?? [];
        final stats = state.landDetails.data?.stats;
        
        if (tasks.isEmpty) {
          return _buildNoTasksFound();
        }
        
        return FadeTransition(
          opacity: _fadeAnim,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(padding, padding, padding, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatsOverview(stats, isTablet),
                const SizedBox(height: 20),
                _buildSectionTitle(
                  'All Tasks (${tasks.length})',
                  Icons.task_alt_rounded,
                ),
                const SizedBox(height: 12),
                ...tasks.map((task) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildTaskCard(task, isTablet),
                )),
                if (stats != null && stats.totalHours != null && stats.totalHours! > 0) ...[
                  const SizedBox(height: 8),
                  _buildTotalHoursCard(stats),
                ],
              ],
            ),
          ),
        );
        
      default:
        return _buildShimmer(isTablet, padding);
    }
  }

  Widget _buildNoTasksFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt_rounded,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview(Stats? stats, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        gradient: _gradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1E88E5).withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Task Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatItem('Total', stats?.total ?? 0, Icons.task_alt_rounded),
              _buildStatItem('Completed', stats?.completed ?? 0, Icons.check_circle_rounded),
              _buildStatItem('Pending', stats?.pending ?? 0, Icons.pending_rounded),
              _buildStatItem('In Progress', stats?.inProgress ?? 0, Icons.play_circle_rounded),
            ],
          ),
          if (stats?.totalHours != null && stats!.totalHours! > 0) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.access_time_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Total Hours: ${stats.totalHours} hrs',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Tasks task, bool isTablet) {
    final statusColor = _statusColor(task.status);
    final priorityColor = _priorityColor(task.priority);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with task type and status
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [statusColor.withOpacity(0.1), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _taskTypeIcon(task.taskType),
                    color: statusColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.taskId ?? '--',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      Text(
                        task.taskTitle ?? '--',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFonts.popins,
                          color: Color(0xff1A1A2E),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Task details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status and Priority badges
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildBadge(
                      label: task.status?.replaceAll('_', ' ') ?? '--',
                      color: statusColor,
                      icon: Icons.circle,
                      iconSize: 8,
                    ),
                    _buildBadge(
                      label: task.priority ?? '--',
                      color: priorityColor,
                      icon: Icons.flag_rounded,
                      iconSize: 14,
                    ),
                    _buildBadge(
                      label: task.taskType?.replaceAll('_', ' ') ?? '--',
                      color: const Color(0xff9E9E9E),
                      icon: _taskTypeIcon(task.taskType),
                      iconSize: 14,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Description
                if (task.taskDescription != null && task.taskDescription!.isNotEmpty) ...[
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.taskDescription!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      fontFamily: AppFonts.popins,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Land Information
                if (task.land != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xffF4F6F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.landscape_rounded,
                              size: 18,
                              color: Color(0xff2BB673),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                task.land!.landTitle ?? '--',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            _buildLandDetail(
                              Icons.straighten_rounded,
                              'Size',
                              '${task.land!.totalSize ?? 0} ${task.land!.areaUnit ?? ''}',
                            ),
                            _buildLandDetail(
                              Icons.location_city_rounded,
                              'City',
                              task.land!.city ?? '--',
                            ),
                            _buildLandDetail(
                              Icons.map_rounded,
                              'State',
                              task.land!.state ?? '--',
                            ),
                          ],
                        ),
                        if (task.land!.address != null && task.land!.address!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.pin_drop_rounded,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  task.land!.address!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                    fontFamily: AppFonts.popins,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 12),

                // Date information
                Row(
                  children: [
                    Expanded(
                      child: _buildDateInfoRow(
                        'Start Date',
                        _formatShortDate(task.startDate),
                        Icons.play_arrow_rounded,
                        const Color(0xff1E88E5),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDateInfoRow(
                        'Due Date',
                        _formatShortDate(task.dueDate),
                        Icons.flag_rounded,
                        _getDueDateColor(task.dueDate),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getDueDateColor(String? dueDate) {
    if (dueDate == null) return Colors.grey;
    final dueDateTime = DateTime.parse(dueDate);
    final now = DateTime.now();
    if (dueDateTime.isBefore(now)) {
      return const Color(0xffE53935);
    }
    if (dueDateTime.difference(now).inDays <= 2) {
      return const Color(0xffFB8C00);
    }
    return const Color(0xff2BB673);
  }

  Widget _buildLandDetail(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInfoRow(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalHoursCard(Stats stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xffFB8C00).withOpacity(0.1), const Color(0xff1E88E5).withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffFB8C00).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xffFB8C00).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.access_time_filled_rounded,
              color: Color(0xffFB8C00),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Work Hours',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                Text(
                  '${stats.totalHours} hours',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.popins,
                    color: Color(0xff1A1A2E),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xff2BB673).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${stats.completed}/${stats.total} Tasks',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff2BB673),
                fontFamily: AppFonts.popins,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({
    required String label,
    required Color color,
    required IconData icon,
    double iconSize = 14,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: iconSize),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            gradient: _gradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.popins,
            color: Color(0xff1A1A2E),
          ),
        ),
      ],
    );
  }

  // ── Shimmer Loading ──────────────────────────────────────────────
  Widget _buildShimmer(bool isTablet, double padding) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(height: 140, radius: 24),
          const SizedBox(height: 20),
          _shimmerBox(height: 24, radius: 8, width: 160),
          const SizedBox(height: 12),
          _shimmerBox(height: 200, radius: 20),
          const SizedBox(height: 16),
          _shimmerBox(height: 200, radius: 20),
          const SizedBox(height: 16),
          _shimmerBox(height: 200, radius: 20),
        ],
      ),
    );
  }

  Widget _shimmerBox({
    required double height,
    double radius = 8,
    double? width,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 0.8),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      builder: (_, val, __) => Opacity(
        opacity: val,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }

  // ── Error State ──────────────────────────────────────────────────
  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xffE53935).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 48,
                color: Color(0xffE53935),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: AppFonts.popins,
                color: Color(0xff1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontFamily: AppFonts.popins,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.read<LandDetailsBloc>().add(
                LandDetailsFetched(widget.taskId),
              ),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text(
                'Try Again',
                style: TextStyle(fontFamily: AppFonts.popins),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1E88E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}