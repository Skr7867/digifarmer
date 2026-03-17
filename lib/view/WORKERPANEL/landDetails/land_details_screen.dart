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

  // ── Helpers ──────────────────────────────────────────────────────
  String _formatDate(String? iso) {
    if (iso == null) return '--';
    try {
      return DateFormat(
        'dd MMM yyyy, hh:mm a',
      ).format(DateTime.parse(iso).toLocal());
    } catch (_) {
      return '--';
    }
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
      default:
        return Icons.task_alt_rounded;
    }
  }

  IconData _timelineIcon(String? status) {
    switch (status?.toUpperCase()) {
      case 'COMPLETED':
        return Icons.check_circle_rounded;
      case 'IN_PROGRESS':
        return Icons.play_circle_rounded;
      case 'PENDING':
        return Icons.radio_button_unchecked_rounded;
      default:
        return Icons.circle_outlined;
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
        final taskId = state.landDetails.data?.task?.taskId ?? 'Task Details';

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
        final task = state.landDetails.data?.task;
        return FadeTransition(
          opacity: _fadeAnim,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(padding, padding, padding, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroBanner(task, isTablet),
                const SizedBox(height: 20),
                _buildQuickInfoRow(task, isTablet),
                const SizedBox(height: 20),
                _buildSectionTitle(
                  'Land Information',
                  Icons.location_on_rounded,
                ),
                const SizedBox(height: 12),
                _buildLandCard(task?.landId, isTablet),
                const SizedBox(height: 20),
                _buildSectionTitle(
                  'Task Description',
                  Icons.description_rounded,
                ),
                const SizedBox(height: 12),
                _buildDescriptionCard(task),
                const SizedBox(height: 20),
                _buildSectionTitle('Status Timeline', Icons.timeline_rounded),
                const SizedBox(height: 12),
                _buildTimeline(task?.statusTimeline ?? [], isTablet),
                const SizedBox(height: 20),
                if (task?.updates != null && task!.updates!.isNotEmpty) ...[
                  _buildSectionTitle('Work Updates', Icons.update_rounded),
                  const SizedBox(height: 12),
                  ...task.updates!.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildUpdateCard(e.value, e.key, isTablet),
                    ),
                  ),
                ],
                if (task?.completionNotes != null) ...[
                  const SizedBox(height: 4),
                  _buildSectionTitle(
                    'Completion Notes',
                    Icons.note_alt_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildCompletionNoteCard(task!),
                ],
              ],
            ),
          ),
        );
      default:
        return _buildShimmer(isTablet, padding);
    }
  }

  // ── Shimmer Loading ──────────────────────────────────────────────
  Widget _buildShimmer(bool isTablet, double padding) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(height: 200, radius: 24),
          const SizedBox(height: 16),
          Row(
            children: List.generate(
              3,
              (i) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 2 ? 12 : 0),
                  child: _shimmerBox(height: 90, radius: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _shimmerBox(height: 24, radius: 8, width: 160),
          const SizedBox(height: 12),
          _shimmerBox(height: 130, radius: 20),
          const SizedBox(height: 20),
          _shimmerBox(height: 24, radius: 8, width: 160),
          const SizedBox(height: 12),
          _shimmerBox(height: 80, radius: 20),
          const SizedBox(height: 20),
          _shimmerBox(height: 24, radius: 8, width: 160),
          const SizedBox(height: 12),
          _shimmerBox(height: 160, radius: 20),
          const SizedBox(height: 20),
          _shimmerBox(height: 24, radius: 8, width: 160),
          const SizedBox(height: 12),
          _shimmerBox(height: 140, radius: 20),
          const SizedBox(height: 12),
          _shimmerBox(height: 140, radius: 20),
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

  // ── Hero Banner ──────────────────────────────────────────────────
  Widget _buildHeroBanner(TaskDetail? task, bool isTablet) {
    final statusColor = _statusColor(task?.status);
    final priorityColor = _priorityColor(task?.priority);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 28 : 20),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _taskTypeIcon(task?.taskType),
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task?.taskType?.replaceAll('_', ' ') ?? '--',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        fontFamily: AppFonts.popins,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      task?.taskTitle ?? '--',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isTablet ? 22 : 18,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.popins,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: .center,
            children: [
              _buildBadge(
                label: task?.status?.replaceAll('_', ' ') ?? '--',
                color: statusColor,
                icon: Icons.circle,
                iconSize: 8,
              ),
              const SizedBox(width: 10),
              _buildBadge(
                label: task?.priority ?? '--',
                color: priorityColor,
                icon: Icons.flag_rounded,
                iconSize: 14,
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildDateInfo(
                    'Start Date',
                    _formatShortDate(task?.startDate),
                    Icons.play_arrow_rounded,
                  ),
                ),
                Container(height: 32, width: 1, color: Colors.white30),
                Expanded(
                  child: _buildDateInfo(
                    'Due Date',
                    _formatShortDate(task?.dueDate),
                    Icons.flag_rounded,
                  ),
                ),
                if (task?.actualHours != null) ...[
                  Container(height: 32, width: 1, color: Colors.white30),
                  Expanded(
                    child: _buildDateInfo(
                      'Actual Hrs',
                      '${task!.actualHours}h',
                      Icons.access_time_rounded,
                    ),
                  ),
                ],
              ],
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
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white30, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: iconSize),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInfo(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 10,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.popins,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ── Quick Info Row ───────────────────────────────────────────────
  Widget _buildQuickInfoRow(TaskDetail? task, bool isTablet) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoTile(
            icon: Icons.person_rounded,
            iconColor: const Color(0xff1E88E5),
            bgColor: const Color(0xff1E88E5).withOpacity(0.08),
            label: 'Assigned By',
            value: task?.assignedBy?.fullName ?? '--',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoTile(
            icon: Icons.location_on_rounded,
            iconColor: const Color(0xff2BB673),
            bgColor: const Color(0xff2BB673).withOpacity(0.08),
            label: 'Location',
            value: task?.location?.country ?? '--',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoTile(
            icon: Icons.update_rounded,
            iconColor: const Color(0xffFB8C00),
            bgColor: const Color(0xffFB8C00).withOpacity(0.08),
            label: 'Updates',
            value: '${task?.updates?.length ?? 0}',
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: iconColor,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  // ── Section Title ────────────────────────────────────────────────
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

  // ── White Card wrapper ───────────────────────────────────────────
  Widget _whiteCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  // ── Land Card ────────────────────────────────────────────────────
  Widget _buildLandCard(LandInfo? land, bool isTablet) {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xff2BB673).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.landscape_rounded,
                  color: Color(0xff2BB673),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  land?.landTitle ?? '--',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFonts.popins,
                    color: Color(0xff1A1A2E),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              _buildLandMeta(
                Icons.straighten_rounded,
                'Size',
                '${land?.totalSize} ${land?.areaUnit}',
              ),
              _buildLandMeta(
                Icons.location_city_rounded,
                'City',
                land?.city ?? '--',
              ),
              _buildLandMeta(Icons.map_rounded, 'State', land?.state ?? '--'),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xffF4F6F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.pin_drop_rounded,
                  color: Color(0xff1E88E5),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    land?.address ?? '--',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff555555),
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandMeta(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff1E88E5).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xff1E88E5)),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.grey,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff1A1A2E),
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Description Card ─────────────────────────────────────────────
  Widget _buildDescriptionCard(TaskDetail? task) {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task?.taskDescription ?? 'No description provided.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              fontFamily: AppFonts.popins,
              height: 1.6,
            ),
          ),
          if (task?.completedAt != null) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Color(0xff2BB673),
                  size: 16,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Completed on ${_formatDate(task?.completedAt)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff2BB673),
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ── Timeline ─────────────────────────────────────────────────────
  Widget _buildTimeline(List<StatusTimeline> timeline, bool isTablet) {
    return _whiteCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: timeline.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          final isLast = i == timeline.length - 1;
          final color = _statusColor(item.status);

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 36,
                  child: Column(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: color, width: 2),
                        ),
                        child: Icon(
                          _timelineIcon(item.status),
                          color: color,
                          size: 16,
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            color: Colors.grey[200],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                item.status?.replaceAll('_', ' ') ?? '--',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _formatShortDate(item.updatedAt),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontFamily: AppFonts.popins,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.note ?? '--',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Update Card ──────────────────────────────────────────────────
  Widget _buildUpdateCard(TaskUpdate update, int index, bool isTablet) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOut,
      builder: (_, val, child) => Opacity(
        opacity: val,
        child: Transform.translate(
          offset: Offset(0, 15 * (1 - val)),
          child: child,
        ),
      ),
      child: _whiteCard(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xff1E88E5).withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                border: const Border(
                  left: BorderSide(color: Color(0xff1E88E5), width: 4),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xff1E88E5).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit_note_rounded,
                      color: Color(0xff1E88E5),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Update #${index + 1}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppFonts.popins,
                            color: Color(0xff1A1A2E),
                          ),
                        ),
                        Text(
                          _formatDate(update.submittedAt),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (update.approved == true)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff2BB673).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xff2BB673).withOpacity(0.3),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_rounded,
                            color: Color(0xff2BB673),
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Approved',
                            style: TextStyle(
                              color: Color(0xff2BB673),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    update.workDone ?? '--',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      fontFamily: AppFonts.popins,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffFB8C00).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              color: Color(0xffFB8C00),
                              size: 14,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${update.hoursWorked}h worked',
                              style: const TextStyle(
                                color: Color(0xffFB8C00),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppFonts.popins,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (update.photos != null && update.photos!.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    const Text(
                      'Photos',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1A1A2E),
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: update.photos!.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, pi) {
                          final photo = update.photos![pi];
                          return Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[200],
                                  child: photo.url != null
                                      ? Image.network(
                                          photo.url!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(
                                                Icons.broken_image_rounded,
                                                color: Colors.grey,
                                                size: 28,
                                              ),
                                        )
                                      : const Icon(
                                          Icons.image_rounded,
                                          color: Colors.grey,
                                          size: 28,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 60,
                                child: Text(
                                  photo.caption ?? '',
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Colors.grey,
                                    fontFamily: AppFonts.popins,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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

  // ── Completion Note Card ─────────────────────────────────────────
  Widget _buildCompletionNoteCard(TaskDetail task) {
    return _whiteCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: _gradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Final Notes',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff1A1A2E),
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task.completionNotes ?? '--',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.popins,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
