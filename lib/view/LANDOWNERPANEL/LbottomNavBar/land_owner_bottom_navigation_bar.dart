import 'package:flutter/material.dart';
import '../../INVESTORPANEL/portfolio/portfolio_screen.dart';
import '../../INVESTORPANEL/profile/profile_screen.dart';
import '../../INVESTORPANEL/wallet/wallet_screen.dart';
import '../homeScreen/land_owner_home_screen.dart';
import 'land_owner_custom_nav_bar.dart';

class LandOwnerBottomNavigationBar extends StatefulWidget {
  const LandOwnerBottomNavigationBar({super.key});

  @override
  State<LandOwnerBottomNavigationBar> createState() =>
      _LandOwnerBottomNavigationBarState();
}

class _LandOwnerBottomNavigationBarState
    extends State<LandOwnerBottomNavigationBar> {
  int currentIndex = 0;

  final List<Widget> screens = [
    LandOwnerHomeScreen(),
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
        bottomNavigationBar: LandOwnerCustomNavBar(
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
