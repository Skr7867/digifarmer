import 'package:digifarmer/view/WORKERPANEL/workerHomeScreen/worker_home_screen.dart';
import 'package:digifarmer/view/portfolio/portfolio_screen.dart';
import 'package:digifarmer/view/profile/profile_screen.dart';
import 'package:digifarmer/view/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
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
    PortfolioScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
    );
  }
}
