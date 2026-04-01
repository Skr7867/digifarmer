import 'package:digifarmer/blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import 'package:digifarmer/blocs/WORKERPANEL/workerdashboard/worker_dashboard_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/model/WORKERPANEL/dashboard/worker_dashboard_model.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
  late UserProfileBloc userProfileBloc;

  @override
  void initState() {
    super.initState();
    dashboardBloc = getIt<DashboardBloc>();
    userProfileBloc = getIt<UserProfileBloc>();
  }

  Future<void> _onRefresh() async {
    dashboardBloc.add(DashboardFetched());
    userProfileBloc.add(UserProfileFetched());

    await Future.wait([
      dashboardBloc.stream.firstWhere(
        (s) => s.workerDashboard.status != Status.loading,
      ),
      userProfileBloc.stream.firstWhere(
        (s) => s.userProfile.status != Status.loading,
      ),
    ]);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F9),
      body: BlocProvider<StartTaskBloc>(
        create: (_) => getIt<StartTaskBloc>(),
        child: BlocListener<StartTaskBloc, StartTaskState>(
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
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              switch (state.workerDashboard.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());

                case Status.error:
                  if (state.workerDashboard.message ==
                      'No Internet Connection') {
                    return Center(
                      child: InternetException(
                        onPress: () => dashboardBloc.add(DashboardFetched()),
                      ),
                    );
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        textAlign: TextAlign.center,
                        state.workerDashboard.message.toString(),
                        style: const TextStyle(fontFamily: AppFonts.popins, color: Colors.redAccent, fontSize: 20),
                      ),
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
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: const Color(0xff2BB673),
                    child: _buildDashboardContent(
                      context,
                      state.workerDashboard.data!,
                    ),
                  );

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

  // ✅ Combine inProgress + pending into one list for "Today's Tasks"
  final allInProgressTasks = taskStatus?.inProgress ?? [];
  final allPendingTasks = taskStatus?.pending ?? [];
  final allActiveTasks = [...allInProgressTasks, ...allPendingTasks];
  final allCompletedTasks = taskStatus?.completed ?? [];
  final allAssignedLeads = dashboard?.assignedLeads ?? [];

  // Show only first 2 tasks for each category
  final activeTasks = allActiveTasks.length > 2
      ? allActiveTasks.sublist(0, 2)
      : allActiveTasks;

  final completedTasks = allCompletedTasks.length > 2
      ? allCompletedTasks.sublist(0, 2)
      : allCompletedTasks;

  final assignedLeads = allAssignedLeads.length > 2
      ? allAssignedLeads.sublist(0, 2)
      : allAssignedLeads;

  int totalTasksToday = taskCounts?.total ?? 0;
  int completedCount = taskCounts?.completed ?? 0;
  int inProgressCount = taskCounts?.inProgress ?? 0;

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              profileState.userProfile.data?.user?.profileImage,
            );
          },
        ),
        const SizedBox(height: 20),
        _buildTodayTasksSection(
          context,
          activeTasks,      // ✅ combined inProgress + pending
          completedTasks,
          allActiveTasks.length,
          allCompletedTasks.length,
        ),
        const SizedBox(height: 20),
        _buildAssignedLandsSection(context, assignedLeads, allAssignedLeads.length),
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
    String? profileImage,
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.workerProfileScreen);
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  backgroundImage:
                      (profileImage != null && profileImage.isNotEmpty)
                      ? NetworkImage(profileImage)
                      : null,
                  child: (profileImage != null && profileImage.isNotEmpty)
                      ? null
                      : Text(
                          userInitials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: AppFonts.popinsBold,
                          ),
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
    List<Pending> inProgressTasks,
    List<Completed> completedTasks,
    int totalInProgressCount,
    int totalCompletedCount,
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
                Text(
                  "In Progress",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const Spacer(),
                if (inProgressTasks.isNotEmpty)
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
          if (totalInProgressCount > 2) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.allTaskScreen);
                },
                child: const Text(
                  'View All Tasks..',
                  style: TextStyle(
                    color: Color(0xff2BB673),
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),
            ),
          ],
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
                Text(
                  "Completed",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const Spacer(),
                if (completedTasks.isNotEmpty)
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
          if (totalCompletedCount > 2) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.allTaskScreen);
                },
                child: const Text(
                  'View All Completed Tasks',
                  style: TextStyle(
                    color: Color(0xff2BB673),
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),
            ),
          ],
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

  Widget _buildInProgressTaskCard(BuildContext context, Pending task) {
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

  // ✅ Determine button behavior from status
  final isInProgress = task.status == 'IN_PROGRESS';

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
              style: const TextStyle(fontSize: 13, fontFamily: AppFonts.popins),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.agriculture, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              _getAreaFromTask(task),
              style: const TextStyle(fontSize: 13, fontFamily: AppFonts.popins),
            ),
          ],
        ),
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
              if (isInProgress) {
                // ✅ Continue → go directly to task details
                Navigator.pushNamed(
                  context,
                  RoutesName.workerTaskDetails,
                  arguments: {'leadId': task.id},
                );
              } else {
                // ✅ Pending → show confirm dialog then call Start Task API
                _showStartTaskConfirmDialog(context, task.id ?? '');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isInProgress ? Colors.orange : Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isInProgress ? Icons.play_arrow : Icons.rocket_launch,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  isInProgress ? 'Continue' : 'Start Task',
                  style: const TextStyle(
                    fontFamily: AppFonts.popins,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

  void _showStartTaskConfirmDialog(BuildContext context, String taskId) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Row(
        children: [
          Icon(Icons.play_circle_outline, color: Colors.green),
          SizedBox(width: 8),
          Text(
            'Start Task',
            style: TextStyle(
              fontFamily: AppFonts.popins,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: const Text(
        'Are you sure you want to start this task?',
        style: TextStyle(fontFamily: AppFonts.popins),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontFamily: AppFonts.popins,
              color: Colors.grey,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(dialogContext); // close dialog first
            context.read<StartTaskBloc>().add(StartTaskPressed( taskId));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Yes, Start',
            style: TextStyle(
              fontFamily: AppFonts.popins,
              color: Colors.white,
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
    int totalAssignedCount,
  ) {
    final uniqueLands = <String, Map<String, dynamic>>{};
    for (var lead in assignedLeads) {
      if (lead.land != null && lead.land!.id != null) {
        final landId = lead.land!.id;
        if (!uniqueLands.containsKey(landId)) {
          uniqueLands[landId.toString()] = {'land': lead.land!, 'taskCount': 1};
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
              Text(
                "Assigned Lands",
                style: const TextStyle(
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
              (lead) => lead.land?.id == land.id,
              // orElse: () => AssignedLeads(),
            );
            // ignore: unused_local_variable
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
                        arguments: land.id,
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        if (totalAssignedCount > 2) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextButton(
              onPressed: () {
                // Navigate to all assigned lands screen
                Navigator.pushNamed(context, RoutesName.allLandsScreen);
              },
              child: const Text(
                'View All Assigned Lands',
                style: TextStyle(
                  color: Color(0xff2BB673),
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
          ),
        ],
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
            crossAxisCount: 3,
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
                title: "Contact Support",
                icon: Icons.support_agent,
                onTap: () {
                  _makePhoneCall('9266157828');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Helper methods ──────────────────────────────────────────────────────────
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

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

  String _getAreaFromTask(Pending task) => '3.8 Acres';

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
                fontSize: 12,
                fontFamily: AppFonts.popins,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
