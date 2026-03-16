import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/WORKERPANEL/attendanceHistory/attendance_history_bloc.dart';
import '../../../model/WORKERPANEL/attendanceHistory/attendence_history_model.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({super.key});

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // ── Gradient used throughout ────────────────────────────────────
  static const _gradient = LinearGradient(
    colors: [Color(0xff1E88E5), Color(0xff2BB673)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();

    // Trigger fetch
    context.read<AttendanceHistoryBloc>().add(
      const FetchAttendanceHistoryEvent(),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  // ── Date / time helpers ─────────────────────────────────────────
  String _formatDisplayDate(String? isoDate) {
    if (isoDate == null) return '--';
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      return DateFormat('EEE, dd MMM yyyy').format(dt);
    } catch (_) {
      return '--';
    }
  }

  String _formatDisplayTime(String? isoDate) {
    if (isoDate == null) return '--:--';
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      return DateFormat('hh:mm a').format(dt);
    } catch (_) {
      return '--:--';
    }
  }

  String _formatHours(double? hours) {
    if (hours == null) return '--';
    final h = hours.floor();
    final m = ((hours - h) * 60).round();
    if (h == 0) return '${m}m';
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }

  Color _statusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'PRESENT':
        return const Color(0xff2BB673);
      case 'ABSENT':
        return const Color(0xffE53935);
      case 'HALF_DAY':
      case 'HALF DAY':
        return const Color(0xffFB8C00);
      default:
        return const Color(0xff1E88E5);
    }
  }

  String _statusLabel(String? status) {
    switch (status?.toUpperCase()) {
      case 'PRESENT':
        return 'Present';
      case 'ABSENT':
        return 'Absent';
      case 'HALF_DAY':
      case 'HALF DAY':
        return 'Half Day';
      default:
        return status ?? '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xffF4F6F9),
      appBar: CustomAppBar(
        title: 'Attendance History',
        gradient: _gradient,
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<AttendanceHistoryBloc, AttendanceHistoryState>(
        builder: (context, state) {
          if (state is AttendanceHistoryLoading) {
            return _buildShimmer(isTablet);
          }
          if (state is AttendanceHistoryFailure) {
            return _buildError(state.errorMessage);
          }
          if (state is AttendanceHistorySuccess) {
            return _buildContent(state.historyModel, isTablet);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // ── Main content ────────────────────────────────────────────────
  Widget _buildContent(AttendanceHistoryModel model, bool isTablet) {
    final summary = model.summary;
    final records = model.attendance ?? [];
    final padding = isTablet ? 24.0 : 16.0;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: RefreshIndicator(
        color: const Color(0xff1E88E5),
        onRefresh: () async {
          context.read<AttendanceHistoryBloc>().add(
            const FetchAttendanceHistoryEvent(),
          );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(padding, padding, padding, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Summary Banner ──────────────────────────────────
              _buildSummaryBanner(summary, isTablet),

              const SizedBox(height: 24),

              // ── Stats Row ───────────────────────────────────────
              _buildStatsRow(summary, isTablet),

              const SizedBox(height: 28),

              // ── Section Header ──────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Attendance Records',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppFonts.popins,
                      color: Color(0xff1A1A2E),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff1E88E5).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${model.total ?? records.length} Records',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1E88E5),
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ── Attendance Cards ────────────────────────────────
              if (records.isEmpty)
                _buildEmptyState()
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: records.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _buildAttendanceCard(records[index], index, isTablet),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Summary Banner ──────────────────────────────────────────────
  Widget _buildSummaryBanner(Summary? summary, bool isTablet) {
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monthly Overview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  Text(
                    'Your attendance summary',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Earnings highlight
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                summary?.totalEarnings != null
                    ? '₹${summary!.totalEarnings!.toStringAsFixed(2)}'
                    : '₹0.00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 36 : 30,
                  fontWeight: FontWeight.w800,
                  fontFamily: AppFonts.popins,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  'Total Earned',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Progress bar — present vs total
          if (summary != null && (summary.totalDays ?? 0) > 0) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (summary.presentDays ?? 0) / (summary.totalDays ?? 1),
                backgroundColor: Colors.white.withOpacity(0.25),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${summary.presentDays} of ${summary.totalDays} days present  •  ${_formatHours(summary.totalHours)} worked',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontFamily: AppFonts.popins,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Stats Row ───────────────────────────────────────────────────
  Widget _buildStatsRow(Summary? summary, bool isTablet) {
    return Row(
      children: [
        Expanded(
          child: _buildStatTile(
            icon: Icons.calendar_today_rounded,
            iconColor: const Color(0xff1E88E5),
            bgColor: const Color(0xff1E88E5).withOpacity(0.08),
            label: 'Total Days',
            value: '${summary?.totalDays ?? 0}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatTile(
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xff2BB673),
            bgColor: const Color(0xff2BB673).withOpacity(0.08),
            label: 'Present',
            value: '${summary?.presentDays ?? 0}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatTile(
            icon: Icons.cancel_rounded,
            iconColor: const Color(0xffE53935),
            bgColor: const Color(0xffE53935).withOpacity(0.08),
            label: 'Absent',
            value: '${summary?.absentDays ?? 0}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatTile(
            icon: Icons.access_time_rounded,
            iconColor: const Color(0xffFB8C00),
            bgColor: const Color(0xffFB8C00).withOpacity(0.08),
            label: 'Hours',
            value: _formatHours(summary?.totalHours),
          ),
        ),
      ],
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
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

  // ── Attendance Card ─────────────────────────────────────────────
  Widget _buildAttendanceCard(
    AttendanceRecord record,
    int index,
    bool isTablet,
  ) {
    final statusColor = _statusColor(record.status);
    final isOngoing = !record.isCheckedOut;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 80)),
      curve: Curves.easeOut,
      builder: (context, val, child) => Opacity(
        opacity: val,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - val)),
          child: child,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Card Header ─────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 20 : 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                border: Border(left: BorderSide(color: statusColor, width: 4)),
              ),
              child: Row(
                children: [
                  // Date icon block
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [statusColor, statusColor.withOpacity(0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          record.dateTime != null
                              ? '${record.dateTime!.day}'
                              : '--',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                        Text(
                          record.dateTime != null
                              ? DateFormat('MMM').format(record.dateTime!)
                              : '--',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatDisplayDate(record.date),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppFonts.popins,
                            color: Color(0xff1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 3),
                        if (isOngoing)
                          Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Color(0xff2BB673),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Currently working',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff2BB673),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            record.totalHours != null
                                ? '${_formatHours(record.totalHours)} worked'
                                : 'No duration recorded',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: statusColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _statusLabel(record.status),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Card Body ───────────────────────────────────────
            Padding(
              padding: EdgeInsets.all(isTablet ? 20 : 14),
              child: Row(
                children: [
                  // Check In
                  Expanded(
                    child: _buildTimeChip(
                      label: 'Check In',
                      time: _formatDisplayTime(record.checkIn),
                      icon: Icons.login_rounded,
                      color: const Color(0xff2BB673),
                    ),
                  ),

                  // Arrow
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.grey[300],
                      size: 18,
                    ),
                  ),

                  // Check Out
                  Expanded(
                    child: _buildTimeChip(
                      label: 'Check Out',
                      time: isOngoing
                          ? 'In Progress'
                          : _formatDisplayTime(record.checkOut),
                      icon: isOngoing
                          ? Icons.hourglass_top_rounded
                          : Icons.logout_rounded,
                      color: isOngoing
                          ? const Color(0xffFB8C00)
                          : const Color(0xffE53935),
                      isOngoing: isOngoing,
                    ),
                  ),

                  // Earnings (only if checked out)
                  if (!isOngoing && record.amountEarned != null) ...[
                    const SizedBox(width: 8),
                    _buildEarningsChip(record.amountEarned!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip({
    required String label,
    required String time,
    required IconData icon,
    required Color color,
    bool isOngoing = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
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
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isOngoing ? color : const Color(0xff1A1A2E),
                    fontFamily: AppFonts.popins,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsChip(double amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff1E88E5), Color(0xff2BB673)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Earned',
            style: TextStyle(
              fontSize: 10,
              color: Colors.white70,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  // ── Shimmer Loading ─────────────────────────────────────────────
  Widget _buildShimmer(bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      child: Column(
        children: [
          _shimmerBox(height: 160, radius: 24),
          const SizedBox(height: 16),
          Row(
            children: List.generate(
              4,
              (i) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 3 ? 12 : 0),
                  child: _shimmerBox(height: 90, radius: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate(4, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _shimmerBox(height: 120, radius: 20),
            );
          }),
        ],
      ),
    );
  }

  Widget _shimmerBox({required double height, double radius = 8}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.4, end: 1.0),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      builder: (_, val, __) => Opacity(
        opacity: val,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }

  // ── Error State ─────────────────────────────────────────────────
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
              onPressed: () => context.read<AttendanceHistoryBloc>().add(
                const FetchAttendanceHistoryEvent(),
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

  // ── Empty State ─────────────────────────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff1E88E5).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.event_busy_rounded,
                size: 48,
                color: Color(0xff1E88E5),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No attendance records found',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.popins,
                color: Color(0xff1A1A2E),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Your attendance history will appear here',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[500],
                fontFamily: AppFonts.popins,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
