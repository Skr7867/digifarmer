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
import '../../../res/customeWidgets/custom_app_bar.dart';

class AllLandScreen extends StatefulWidget {
  const AllLandScreen({super.key});

  @override
  State<AllLandScreen> createState() => _AllLandScreenState();
}

class _AllLandScreenState extends State<AllLandScreen> {
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
        title: 'All Lands',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),),
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

    final assignedLeads = dashboard?.assignedLeads ?? [];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildAssignedLandsSection(context, assignedLeads),
          const SizedBox(height: 20),
          _buildQuickActionsSection(),
          const SizedBox(height: 20),
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

  String _getLandLocation(Land land) => 'Nashik, Maharashtra';
}

// ── Small reusable widgets ───────────────────────────────────────────────────

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
