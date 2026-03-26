import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import '../../../blocs/WORKERPANEL/startTask/start_task_bloc.dart';
import '../../../blocs/WORKERPANEL/workerdashboard/worker_dashboard_bloc.dart';
import '../../../config/component/internet_exception.dart';
import '../../../config/routes/routes_name.dart';
import '../../../main.dart';
import '../../../model/WORKERPANEL/dashboard/worker_dashboard_model.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/enums.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
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
      appBar: CustomAppBar(
        title: 'All Task',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
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
    final inProgressTasks = taskStatus?.pending ?? [];
    final completedTasks = taskStatus?.completed ?? [];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Pass profile state into header via BlocBuilder
          const SizedBox(height: 20),
          _buildTodayTasksSection(context, inProgressTasks, completedTasks),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Extract initials from full name
}

Widget _buildTodayTasksSection(
  BuildContext context,
  List<Pending> inProgressTasks,
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
        ...completedTasks.map((task) => _buildCompletedTaskCard(context, task)),
      ],

      if (inProgressTasks.isEmpty && completedTasks.isEmpty) ...[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Center(
            child: Text(
              "No tasks for today",
              style: TextStyle(color: Colors.grey, fontFamily: AppFonts.popins),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              style: const TextStyle(fontSize: 13, fontFamily: AppFonts.popins),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.agriculture, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              _getAreaFromCompletedTask(task),
              style: const TextStyle(fontSize: 13, fontFamily: AppFonts.popins),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
String _getLocationFromTask(dynamic task) => 'Nashik, Maharashtra';
String _getAreaFromCompletedTask(Completed task) => '3.8 Acres';


// ── Small reusable widgets ───────────────────────────────────────────────────




