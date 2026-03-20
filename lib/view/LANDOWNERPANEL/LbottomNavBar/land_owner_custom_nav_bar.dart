import 'package:flutter/material.dart';

import '../../../res/color/app_colors.dart';
import '../../../res/fonts/app_fonts.dart';

class LandOwnerCustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const LandOwnerCustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, -3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          selectedLabelStyle: TextStyle(fontFamily: AppFonts.popins),
          unselectedLabelStyle: TextStyle(fontFamily: AppFonts.popins),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.greenColor,
          unselectedItemColor: Theme.of(context).textTheme.bodyLarge?.color,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          unselectedFontSize: 13,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.yard),
              activeIcon: Icon(Icons.yard),
              label: 'My Lands',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sensors),
              activeIcon: Icon(Icons.sensors),
              label: 'Status',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              activeIcon: Icon(Icons.account_circle),
              label: 'profile',
            ),
          ],
        ),
      ),
    );
  }
}
