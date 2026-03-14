import 'package:digifarmer/blocs/WORKERPANEL/workerdashboard/worker_dashboard_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/model/WORKERPANEL/dashboard/worker_dashboard_model.dart';
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
                    child: Text(state.workerDashboard.message.toString()),
                  );

                /// ================= DASHBOARD COMPLETED =================
                case Status.completed:
                  if (state.workerDashboard.data == null) {
                    return const Center(child: Text('No data Found'));
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
    WorkerDashboardModel dashboardData,
  ) {
    final dashboard = dashboardData.dashboard;

    // Calculate stats from actual data
    int totalTasksToday = dashboard?.assignedLeads?.length ?? 0;
    int completedTasks = dashboard?.completed?.length ?? 0;
    int pendingTasks =
        dashboard?.assignedLeads
            ?.where((lead) => lead.status == 'PENDING')
            .length ??
        0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= HEADER =================
          _buildHeader(
            context,
            dashboard?.today?.status ?? 'PRESENT',
            totalTasksToday,
            completedTasks,
            pendingTasks,
          ),

          const SizedBox(height: 20),

          /// ================= TODAY'S TASKS =================
          _buildTodayTasksSection(context, dashboard?.assignedLeads ?? []),

          const SizedBox(height: 20),

          /// ================= ASSIGNED LANDS =================
          _buildAssignedLandsSection(context, dashboard?.assignedLeads ?? []),

          const SizedBox(height: 10),

          /// ================= QUICK ACTIONS =================
          _buildQuickActionsSection(),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String status,
    int totalTasks,
    int completedTasks,
    int pendingTasks,
  ) {
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
          /// Top Row
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
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const Text(
            "Rajesh Kumar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 20),

          /// Stats from API
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TopStat(title: "Tasks Today", value: totalTasks.toString()),
              _TopStat(title: "Completed", value: completedTasks.toString()),
              _TopStat(title: "Pending", value: pendingTasks.toString()),
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
                "Today's Status: $status",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTodayTasksSection(
    BuildContext context,
    List<AssignedLeads> assignedLeads,
  ) {
    // Get today's date
    String todayDate = _getFormattedDate();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Today's Tasks", todayDate),

        if (assignedLeads.isEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "No tasks assigned for today",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ] else ...[
          ...assignedLeads.map((lead) {
            // Determine status color and text
            Color statusColor = _getStatusColor(lead.status ?? 'PENDING');
            String statusText = lead.status ?? 'PENDING';
            String buttonText = _getButtonText(lead.status ?? 'PENDING');
            Color buttonColor = _getButtonColor(lead.status ?? 'PENDING');

            return _taskCard(
              statusColor: statusColor,
              statusText: statusText,
              title: lead.taskTitle ?? 'No Title',
              plot: lead.land?.landTitle ?? 'No Land Assigned',
              area: "Area not specified", // Default if not in API
              time: lead.workday ?? 'Daily', // Using workday as rtime reference
              buttonText: buttonText,
              buttonColor: buttonColor,
              onTap: () {
                /// ⭐ If task is pending → ask confirmation then start API
                if ((lead.status ?? '').toUpperCase() == 'PENDING') {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Start Task"),
                      content: const Text(
                        "Are you sure you want to start this task?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);

                            context.read<StartTaskBloc>().add(
                              StartTaskPressed(lead.id!),
                            );
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    RoutesName.workerTaskDetails,
                    arguments: {'leadId': lead.id},
                  );
                }
              },
            );
          }),
        ],
      ],
    );
  }

  Widget _buildAssignedLandsSection(
    BuildContext context,
    List<AssignedLeads> assignedLeads,
  ) {
    // Get unique lands from assigned leads
    final uniqueLands = <String, Land>{};
    for (var lead in assignedLeads) {
      if (lead.land != null && lead.land!.id != null) {
        uniqueLands[lead.land!.id!] = lead.land!;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Assigned Lands", "${uniqueLands.length} Active"),

        if (uniqueLands.isEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "No lands assigned",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ] else ...[
          ...uniqueLands.values.map((land) {
            // Count tasks for this land
            int taskCount = assignedLeads
                .where((lead) => lead.land?.id == land.id)
                .length;

            return _assignedLandCard(
              title: land.landTitle ?? 'Unknown Land',
              location: "Location not specified", // Default if not in API
              crop: "$taskCount Task${taskCount > 1 ? 's' : ''}",
              cropColor: taskCount > 0 ? Colors.green : Colors.grey,
              landId: land.id,
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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Quick Actions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
            childAspectRatio: 1.5,
            children: const [
              _QuickAction(title: "Mark Attendance"),
              _QuickAction(title: "Upload Photo"),
              _QuickAction(title: "Daily Report"),
              _QuickAction(title: "Contact Support"),
            ],
          ),
        ),
      ],
    );
  }

  // Helper methods
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

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return Colors.green;
      case 'IN_PROGRESS':
        return Colors.orange;
      case 'PENDING':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getButtonText(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return 'View';
      case 'IN_PROGRESS':
        return 'Continue';
      case 'PENDING':
        return 'Start Task';
      default:
        return 'View Details';
    }
  }

  Color _getButtonColor(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return Colors.green;
      case 'IN_PROGRESS':
        return Colors.orange;
      case 'PENDING':
        return Colors.blue;
      default:
        return const Color(0xff2BB673);
    }
  }

  // ================= WIDGETS (Unchanged from your original) =================

  static Widget _sectionTitle(String title, String trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            trailing,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  static Widget _taskCard({
    required Color statusColor,
    required String statusText,
    required String title,
    required String plot,
    required String area,
    required String time,
    required String buttonText,
    required Color buttonColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(color: statusColor, fontSize: 11),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Priority: High",
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(plot, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.timer, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(time, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onTap,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _assignedLandCard({
    required String title,
    required String location,
    required String crop,
    required Color cropColor,
    String? landId,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            location,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: cropColor.withOpacity(.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(crop, style: TextStyle(color: cropColor, fontSize: 12)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2BB673),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Navigate to land details
                Navigator.pushNamed(
                  context,
                  RoutesName.workerTaskDetails,
                  arguments: {'landId': landId},
                );
              },
              child: const Text("View Land Details"),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= SMALL WIDGETS (Unchanged) =================

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
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String title;

  const _QuickAction({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
