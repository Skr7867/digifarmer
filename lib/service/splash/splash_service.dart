import 'dart:async';

import 'package:flutter/material.dart';

import '../../config/routes/routes_name.dart';
import '../sessionManager/session_controller.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    SessionController().getUserFromPreference().then((value) {
      final session = SessionController();

      if (session.isLogin) {
        final role = session.user?.role;
        Timer(const Duration(seconds: 2), () {
          if (role == "INVESTOR") {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.bottomNavBar,
              (route) => false,
            );
          } else if (role == "LAND_OWNER") {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.landOwnerBottomNavBar,
              (route) => false,
            );
          } else if (role == "WORKER") {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.workerBottomNavBar,
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.userLoginScreen,
              (route) => false,
            );
          }
        });
      } else {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.userLoginScreen,
            (route) => false,
          ),
        );
      }
    });
  }
}
