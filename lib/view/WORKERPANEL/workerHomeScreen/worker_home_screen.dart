import 'package:digifarmer/blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import 'package:digifarmer/blocs/WORKERPANEL/workerdashboard/worker_dashboard_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/model/WORKERPANEL/dashboard/worker_dashboard_model.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/WORKERPANEL/startTask/start_task_bloc.dart';
import '../../../config/component/internet_exception.dart';
import '../../../main.dart';
import '../../../res/color/app_colors.dart';

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  late DashboardBloc dashboardBloc;

  @override
  void initState() {
    super.initState();
    dashboardBloc = DashboardBloc(workerDashboardRepository: getIt());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProfileBloc>().add(UserProfileFetched());
    });
  }

  @override
  void dispose() {
    dashboardBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F9),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => dashboardBloc..add(DashboardFetched())),
          BlocProvider(create: (context) => StartTaskBloc(repository: getIt())),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<StartTaskBloc, StartTaskState>(
              listener: (context, startState) {
                if (startState.startTaskResponse.status == Status.loading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                }

                if (startState.startTaskResponse.status == Status.completed) {
                  Navigator.pop(context);
                  final taskId = startState.startTaskResponse.data?.task?.id;
                  dashboardBloc.add(DashboardFetched());
                  Navigator.pushNamed(
                    context,
                    RoutesName.workerTaskDetails,
                    arguments: {'leadId': taskId},
                  );
                }

                if (startState.startTaskResponse.status == Status.error) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        startState.startTaskResponse.message.toString(),
                        style: const TextStyle(fontFamily: AppFonts.popins),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (BuildContext context, state) {
              switch (state.workerDashboard.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());

                case Status.error:
                  if (state.workerDashboard.message ==
                      'No Internet Connection') {
                    return Center(
                      child: InternetException(
                        onPress: () {
                          dashboardBloc.add(DashboardFetched());
                        },
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      state.workerDashboard.message.toString(),
                      style: const TextStyle(fontFamily: AppFonts.popins),
                    ),
                  );

                case Status.completed:
                  if (state.workerDashboard.data == null) {
                    return const Center(
                      child: Text(
                        'No data Found',
                        style: TextStyle(fontFamily: AppFonts.popins),
                      ),
                    );
                  }
                  final dashboardData = state.workerDashboard.data!;
                  return _buildDashboardContent(context, dashboardData);

                case Status.initial:
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    WorkerDashBoardModel dashboardData,
  ) {
    final dashboard = dashboardData.dashboard;
    final taskStatus = dashboard?.taskStatus;
    final taskCounts = dashboard?.taskCounts;

    final inProgressTasks = taskStatus?.inProgressList ?? [];
    final completedTasks = taskStatus?.completedList ?? [];
    final assignedLeads = dashboard?.assignedLeads ?? [];

    int totalTasksToday = taskCounts?.totalCount ?? 0;
    int completedCount = taskCounts?.completedCount ?? 0;
    int inProgressCount = taskCounts?.inProgressCount ?? 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Pass profile state into header via BlocBuilder
          BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, profileState) {
              final userName =
                  profileState.userProfile.data?.user?.fullName ?? '';
              final userInitials = _getInitials(userName);

              return _buildHeader(
                context,
                dashboard?.today?.status ?? 'NOT_MARKED',
                totalTasksToday,
                completedCount,
                inProgressCount,
                userName,
                userInitials,
              );
            },
          ),

          const SizedBox(height: 20),
          _buildTodayTasksSection(context, inProgressTasks, completedTasks),
          const SizedBox(height: 20),
          _buildAssignedLandsSection(context, assignedLeads),
          const SizedBox(height: 20),
          _buildQuickActionsSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Extract initials from full name
  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    final parts = trimmed.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return trimmed.length >= 2
        ? trimmed.substring(0, 2).toUpperCase()
        : trimmed.toUpperCase();
  }

  Widget _buildHeader(
    BuildContext context,
    String status,
    int totalTasks,
    int completedTasks,
    int inProgressTasks,
    String userName,
    String userInitials,
  ) {
    String displayStatus = status.replaceAll('_', ' ').toLowerCase();
    displayStatus =
        displayStatus.substring(0, 1).toUpperCase() +
        displayStatus.substring(1);

    return Container(
      padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1E88E5), Color(0xff2BB673)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row with Avatar and Notification
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Avatar: show initials while loading, real avatar when ready
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                child: Text(
                  userInitials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: AppFonts.popinsBold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.workerNotification);
                },
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          const Text(
            "Welcome Back!",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontFamily: AppFonts.popins,
            ),
          ),

          /// Dynamic user name — shows loading shimmer or actual name
          userName.isEmpty
              ? Container(
                  height: 22,
                  width: 120,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )
              : Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: AppFonts.popins,
                  ),
                ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TopStat(title: "Tasks Today", value: totalTasks.toString()),
              _TopStat(title: "Completed", value: completedTasks.toString()),
              _TopStat(title: "In Progress", value: inProgressTasks.toString()),
            ],
          ),

          if (status.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Today's Status: $displayStatus",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTodayTasksSection(
    BuildContext context,
    List<InProgress> inProgressTasks,
    List<Completed> completedTasks,
  ) {
    String todayDate = _getFormattedDate();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Tasks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                todayDate,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),

        if (inProgressTasks.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "In Progress",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const Spacer(),
                Text(
                  "Priority: ${inProgressTasks.first.priority ?? 'MEDIUM'}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 16, thickness: 1, indent: 16, endIndent: 16),
          ...inProgressTasks.map(
            (task) => _buildInProgressTaskCard(context, task),
          ),
        ],

        const SizedBox(height: 16),

        if (completedTasks.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Completed",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const Spacer(),
                Text(
                  "Priority: ${completedTasks.isNotEmpty ? completedTasks.first.priority ?? 'MEDIUM' : 'MEDIUM'}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 16, thickness: 1, indent: 16, endIndent: 16),
          ...completedTasks.map(
            (task) => _buildCompletedTaskCard(context, task),
          ),
        ],

        if (inProgressTasks.isEmpty && completedTasks.isEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Center(
              child: Text(
                "No tasks for today",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInProgressTaskCard(BuildContext context, InProgress task) {
    String timeRange = _formatTimeRange(task.workday ?? 'Daily');
    String dueDateText = '';
    if (task.dueDate != null) {
      final dueDate = DateTime.parse(task.dueDate!);
      final now = DateTime.now();
      final difference = dueDate.difference(now).inDays;
      if (difference > 0) {
        dueDateText = 'Due in $difference day${difference > 1 ? 's' : ''}';
      } else if (difference == 0) {
        dueDateText = 'Due today';
      } else {
        dueDateText =
            'Overdue by ${-difference} day${-difference > 1 ? 's' : ''}';
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.taskTitle ?? 'No Title',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${task.land?.landTitle ?? 'No Land'} - ${_getLocationFromLand(task.land)}",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                timeRange,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.popins,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.agriculture, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                _getAreaFromTask(task),
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
          if (task.progress != null && task.progress! > 0) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.play_circle_outline,
                  size: 16,
                  color: Colors.green,
                ),
                const SizedBox(width: 4),
                Text(
                  'Started: ${_formatStartTime(task)}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.green,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ],
          if (dueDateText.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.event,
                  size: 16,
                  color: dueDateText.contains('Overdue')
                      ? Colors.red
                      : Colors.orange,
                ),
                const SizedBox(width: 4),
                Text(
                  dueDateText,
                  style: TextStyle(
                    fontSize: 13,
                    color: dueDateText.contains('Overdue')
                        ? Colors.red
                        : Colors.orange,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutesName.workerTaskDetails,
                  arguments: {'leadId': task.id},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontFamily: AppFonts.popins,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedTaskCard(BuildContext context, Completed task) {
    String timeRange = _formatTimeRange(task.workday ?? 'Daily');
    String completedTime = '';
    if (task.completedAt != null) {
      final completedAt = DateTime.parse(task.completedAt!);
      completedTime = _formatTime(completedAt);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.taskTitle ?? 'No Title',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Plot ${task.id?.substring(0, 4) ?? 'Unknown'} - ${_getLocationFromTask(task)}",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                timeRange,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.popins,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.agriculture, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                _getAreaFromCompletedTask(task),
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
          if (completedTime.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 16,
                  color: Colors.green,
                ),
                const SizedBox(width: 4),
                Text(
                  'Completed at $completedTime',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.green,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutesName.workerTaskDetails,
                  arguments: {'leadId': task.id},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: const Text(
                'View',
                style: TextStyle(
                  fontFamily: AppFonts.popins,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedLandsSection(
    BuildContext context,
    List<AssignedLeads> assignedLeads,
  ) {
    final uniqueLands = <String, Map<String, dynamic>>{};
    for (var lead in assignedLeads) {
      if (lead.land != null && lead.land!.sId != null) {
        final landId = lead.land!.sId!;
        if (!uniqueLands.containsKey(landId)) {
          uniqueLands[landId] = {'land': lead.land!, 'taskCount': 1};
        } else {
          uniqueLands[landId]!['taskCount'] =
              uniqueLands[landId]!['taskCount'] + 1;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Assigned Lands",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                "${uniqueLands.length} Active",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),
        if (uniqueLands.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Center(
              child: Text(
                "No lands assigned",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
          )
        else
          ...uniqueLands.values.map((landData) {
            final land = landData['land'] as Land;
            final taskCount = landData['taskCount'] as int;
            final matchedLead = assignedLeads.firstWhere(
              (lead) => lead.land?.sId == land.sId,
              orElse: () => AssignedLeads(),
            );
            final taskId = matchedLead.id;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    land.landTitle ?? 'Unknown Land',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getLandLocation(land),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "$taskCount Task${taskCount > 1 ? 's' : ''}",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  RoundButton(
                    width: double.infinity,
                    buttonColor: AppColors.greenColor,
                    title: 'View Land Details',
                    onPress: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.landDetailScreen,
                        arguments: taskId,
                      );
                    },
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Quick Actions",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: AppFonts.popins,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.2,
            children: [
              _QuickAction(
                title: "Mark Attendance",
                icon: Icons.check_circle,
                onTap: () => Navigator.pushNamed(
                  context,
                  RoutesName.markAttendaceScreen,
                ),
              ),
              _QuickAction(
                title: "Attendance History",
                icon: Icons.event_available,
                onTap: () => Navigator.pushNamed(
                  context,
                  RoutesName.attendanceHistoryScreen,
                ),
              ),
              _QuickAction(
                title: "Daily Report",
                icon: Icons.description,
                onTap: () => Navigator.pushNamed(
                  context,
                  RoutesName.markAttendaceScreen,
                ),
              ),
              _QuickAction(
                title: "Contact Support",
                icon: Icons.support_agent,
                onTap: () => Navigator.pushNamed(
                  context,
                  RoutesName.markAttendaceScreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Helper methods ──────────────────────────────────────────────────────────

  String _getFormattedDate() {
    final now = DateTime.now();
    return "${_getMonthAbbr(now.month)} ${now.day}, ${now.year}";
  }

  String _getMonthAbbr(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }

  String _formatTimeRange(String workday) {
    if (workday.toLowerCase() == 'daily') return '6:00 AM - 2:00 PM';
    return workday;
  }

  String _formatStartTime(InProgress task) => '9:15 AM';

  String _formatTime(DateTime time) {
    String minute = time.minute.toString().padLeft(2, '0');
    String period = time.hour >= 12 ? 'PM' : 'AM';
    int hourIn12 = time.hour > 12
        ? time.hour - 12
        : (time.hour == 0 ? 12 : time.hour);
    return '$hourIn12:$minute $period';
  }

  String _getLocationFromLand(Land? land) => 'Nashik, Maharashtra';
  String _getLandLocation(Land land) => 'Nashik, Maharashtra';
  String _getLocationFromTask(dynamic task) => 'Nashik, Maharashtra';
  String _getAreaFromTask(InProgress task) => '5.2 Acres';
  String _getAreaFromCompletedTask(Completed task) => '3.8 Acres';
}

// ── Small reusable widgets ───────────────────────────────────────────────────

class _TopStat extends StatelessWidget {
  final String title;
  final String value;

  const _TopStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontFamily: AppFonts.popins,
          ),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickAction({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xff2BB673), size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                fontFamily: AppFonts.popins,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
