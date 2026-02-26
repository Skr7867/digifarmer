import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../res/color/app_colors.dart';
import '../../../res/fonts/app_fonts.dart';

class WorkerCustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const WorkerCustomNavBar({
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
          selectedItemColor: AppColors.buttonColor,
          unselectedItemColor: Theme.of(context).textTheme.bodyLarge?.color,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          unselectedFontSize: 13,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(PhosphorIconsRegular.house),
              activeIcon: Icon(PhosphorIconsFill.house),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(PhosphorIconsRegular.filePdf),
              activeIcon: Icon(PhosphorIconsFill.filePdf),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIconsRegular.crop),
              activeIcon: Icon(PhosphorIconsFill.crop),
              label: 'Lands',
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIconsRegular.person),
              activeIcon: Icon(PhosphorIconsFill.person),
              label: 'profile',
            ),
          ],
        ),
      ),
    );
  }
}
