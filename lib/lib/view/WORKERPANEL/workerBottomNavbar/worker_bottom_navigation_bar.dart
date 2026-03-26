import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import '../../../repository/INVESTORPANEL/userProfile/user_profile_http_repository.dart';
import '../allLands/all_land_screen.dart';
import '../allTask/all_task_screen.dart';
import '../profile/worker_profile_screen.dart';
import '../workerHomeScreen/worker_home_screen.dart';
import 'worker_custom_nav_bar.dart';

class WorkerBottomNavigationBar extends StatefulWidget {
  const WorkerBottomNavigationBar({super.key});

  @override
  State<WorkerBottomNavigationBar> createState() =>
      _WorkerBottomNavigationBarState();
}

class _WorkerBottomNavigationBarState extends State<WorkerBottomNavigationBar> {
  int currentIndex = 0;

  final List<Widget> screens = [
    WorkerHomeScreen(),
    AllTaskScreen(),
    AllLandScreen(),
    WorkerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserProfileBloc(
            userProfileRepository: UserProfileHttpRepository(),
          ),
        ),
        // add your other blocs here if needed
      ],
      child: WillPopScope(
        onWillPop: () async {
          if (currentIndex != 0) {
            setState(() {
              currentIndex = 0;
            });
            return false;
          }
          return true;
        },
        child: Scaffold(
          body: IndexedStack(index: currentIndex, children: screens),
          bottomNavigationBar: WorkerCustomNavBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
