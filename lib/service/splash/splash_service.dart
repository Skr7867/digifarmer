import 'dart:async';
import 'package:flutter/material.dart';

import '../../config/routes/routes_name.dart';
import '../sessionManager/session_controller.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    SessionController()
        .getUserFromPreference()
        .then((value) {
          debugPrint("SPLASH isLogin = ${SessionController().isLogin}");

          if (SessionController().isLogin) {
            debugPrint("GO HOME");
            Timer(
              Duration(seconds: 2),
              () => Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.bottomNavBar,
                (route) => false,
              ),
            );
          } else {
            Timer(
              Duration(seconds: 2),
              () => Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.userLoginScreen,
                (route) => false,
              ),
            );
          }
        })
        .onError((error, stacktrace) {
          Timer(
            Duration(seconds: 2),
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.userLoginScreen,
              (route) => false,
            ),
          );
        });
  }
}
