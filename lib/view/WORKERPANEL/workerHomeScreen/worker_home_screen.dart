import 'package:digifarmer/blocs/WORKERPANEL/workerdashboard/worker_dashboard_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/model/WORKERPANEL/dashboard/worker_dashboard_model.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/WORKERPANEL/startTask/start_task_bloc.dart';
import '../../../config/component/internet_exception.dart';
import '../../../main.dart';

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
            /// ⭐ Start Task Listener
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
                  Navigator.pop(context); // close loader

                  final taskId = startState.startTaskResponse.data?.task?.id;

                  /// ⭐ refresh dashboard
                  dashboardBloc.add(DashboardFetched());

                  /// ⭐ navigate to task details
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
                /// ================= DASHBOARD LOADING =================
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());

                /// ================= DASHBOARD ERROR =================
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

                /// ================= DASHBOARD COMPLETED =================
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

                /// ================= DEFAULT =================
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

    // Get tasks from taskStatus (matches your screenshot structure)
    final inProgressTasks = taskStatus?.inProgressList ?? [];
    final completedTasks = taskStatus?.completedList ?? [];

    // Get assigned lands
    final assignedLeads = dashboard?.assignedLeads ?? [];

    // Calculate stats
    int totalTasksToday = taskCounts?.totalCount ?? 0;
    int completedCount = taskCounts?.completedCount ?? 0;
    int inProgressCount = taskCounts?.inProgressCount ?? 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= HEADER =================
          _buildHeader(
            context,
            dashboard?.today?.status ?? 'NOT_MARKED',
            totalTasksToday,
            completedCount,
            inProgressCount,
          ),

          const SizedBox(height: 20),

          /// ================= TODAY'S TASKS SECTION =================
          _buildTodayTasksSection(context, inProgressTasks, completedTasks),

          const SizedBox(height: 20),

          /// ================= ASSIGNED LANDS =================
          _buildAssignedLandsSection(context, assignedLeads),

          const SizedBox(height: 20),

          /// ================= QUICK ACTIONS =================
          _buildQuickActionsSection(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String status,
    int totalTasks,
    int completedTasks,
    int inProgressTasks,
  ) {
    // Format status for display
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
          /// Top Row with Profile and Notification
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
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
          const Text(
            "Rajesh Kumar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: AppFonts.popins,
            ),
          ),

          const SizedBox(height: 20),

          /// Stats from API
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
    // Get today's date
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

        /// In Progress Section
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

          ...inProgressTasks.map((task) {
            return _buildInProgressTaskCard(context, task);
          }),
        ],

        const SizedBox(height: 16),

        /// Completed Section
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

          ...completedTasks.map((task) {
            return _buildCompletedTaskCard(context, task);
          }),
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
    // Format time range
    String timeRange = _formatTimeRange(task.workday ?? 'Daily');

    // Format due date if available
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

          /// Time and Area Row
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

          /// Started Time
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

          /// Due Date
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

          /// Continue Button
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
    // Format time range
    String timeRange = _formatTimeRange(task.workday ?? 'Daily');

    // Format completed time
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

          /// Time and Area Row
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

          /// Completed Time
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

          /// View Button
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
    // Get unique lands from assigned leads
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

        if (uniqueLands.isEmpty) ...[
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
          ),
        ] else ...[
          ...uniqueLands.values.map((landData) {
            final land = landData['land'] as Land;
            final taskCount = landData['taskCount'] as int;

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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.workerTaskDetails,
                          arguments: {'landId': land.sId},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2BB673),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "View Land Details",
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
          }).toList(),
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
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.2,
            children: const [
              _QuickAction(title: "Mark Attendance", icon: Icons.check_circle),
              _QuickAction(title: "Upload Photo", icon: Icons.photo_camera),
              _QuickAction(title: "Daily Report", icon: Icons.description),
              _QuickAction(title: "Contact Support", icon: Icons.support_agent),
            ],
          ),
        ),
      ],
    );
  }

  // Helper methods
  // Helper methods - add all of these to your _WorkerHomeScreenState class

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
    // This is a simplified version - you might want to get actual start/end times from API
    if (workday.toLowerCase() == 'daily') {
      return '6:00 AM - 2:00 PM'; // Default timing
    }
    return workday;
  }

  String _formatStartTime(InProgress task) {
    // This would come from actual task start time in API
    // For now, return a formatted time based on task ID or current time
    return '9:15 AM';
  }

  String _formatTime(DateTime time) {
    String minute = time.minute.toString().padLeft(2, '0');
    String period = time.hour >= 12 ? 'PM' : 'AM';
    int hourIn12 = time.hour > 12
        ? time.hour - 12
        : (time.hour == 0 ? 12 : time.hour);
    return '$hourIn12:$minute $period';
  }

  String _getLocationFromLand(Land? land) {
    // This would come from API if available
    return 'Nashik, Maharashtra';
  }

  String _getLandLocation(Land land) {
    // Return location for the land
    // You can customize this based on your data structure
    return 'Nashik, Maharashtra';
  }

  String _getLocationFromTask(dynamic task) {
    // This would come from API if available
    return 'Nashik, Maharashtra';
  }

  String _getAreaFromTask(InProgress task) {
    // This would come from API if available
    return '5.2 Acres';
  }

  String _getAreaFromCompletedTask(Completed task) {
    // This would come from API if available
    return '3.8 Acres';
  }
}

/// ================= SMALL WIDGETS =================

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

  const _QuickAction({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
