import 'package:digifarmer/view/home/home_screen.dart';
import 'package:digifarmer/view/portfolio/portfolio_screen.dart';
import 'package:flutter/material.dart';

import '../explore/explore_screen.dart';
import '../profile/profile_screen.dart';
import '../wallet/wallet_screen.dart';
import 'custom_nav_bar.dart';

class BottomnavBar extends StatefulWidget {
  const BottomnavBar({super.key});

  @override
  State<BottomnavBar> createState() => _BottomnavBarState();
}

class _BottomnavBarState extends State<BottomnavBar> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    ExploreScreen(),
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
        bottomNavigationBar: CustomBottomNavBar(
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
