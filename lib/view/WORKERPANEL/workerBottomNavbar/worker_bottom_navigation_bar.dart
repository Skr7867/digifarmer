import 'package:digifarmer/blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import 'package:digifarmer/view/WORKERPANEL/profile/worker_profile_screen.dart';
import 'package:digifarmer/view/WORKERPANEL/workerHomeScreen/worker_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/WORKERPANEL/workerdashboard/worker_dashboard_bloc.dart';
import '../../../main.dart';
import '../../../utils/enums.dart';
import '../allLands/all_land_screen.dart';
import '../allTask/all_task_screen.dart';
import 'worker_custom_nav_bar.dart';

class WorkerBottomNavigationBar extends StatefulWidget {
  const WorkerBottomNavigationBar({super.key});

  @override
  State<WorkerBottomNavigationBar> createState() =>
      _WorkerBottomNavigationBarState();
}

class _WorkerBottomNavigationBarState extends State<WorkerBottomNavigationBar> {
  int currentIndex = 0;
  late final List<Widget> screens; // ✅ late final

  @override
  void initState() {
    super.initState();

    // ✅ Get singleton blocs
    final userProfileBloc = getIt<UserProfileBloc>();
    final dashboardBloc = getIt<DashboardBloc>();

    // ✅ Fire only if not already loaded
    if (userProfileBloc.state.userProfile.status != Status.completed) {
      userProfileBloc.add(UserProfileFetched());
    }
    if (dashboardBloc.state.workerDashboard.status != Status.completed) {
      dashboardBloc.add(DashboardFetched());
    }
    screens = [
      MultiBlocProvider(
        providers: [
          BlocProvider<UserProfileBloc>.value(value: userProfileBloc),
          BlocProvider<DashboardBloc>.value(value: dashboardBloc),
        ],
        child: const WorkerHomeScreen(),
      ),
      BlocProvider<UserProfileBloc>.value(
        value: userProfileBloc,
        child: const AllTaskScreen(),
      ),
      BlocProvider<UserProfileBloc>.value(
        value: userProfileBloc,
        child: const AllLandScreen(),
      ),
      BlocProvider<UserProfileBloc>.value(
        value: userProfileBloc,
        child: const WorkerProfileScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          setState(() => currentIndex = 0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(index: currentIndex, children: screens),
        bottomNavigationBar: WorkerCustomNavBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
        ),
      ),
    );
  }
}
