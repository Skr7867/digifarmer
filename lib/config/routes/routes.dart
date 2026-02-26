import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/view/LANDOWNERPANEL/LbottomNavBar/land_owner_bottom_navigation_bar.dart';
import 'package:digifarmer/view/WORKERPANEL/workerBottomNavbar/worker_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../view/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.userRegisterScreen:
        return MaterialPageRoute(builder: (context) => UserRegisterScreen());
      case RoutesName.otpVerifyScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            uniqueKey: args['uniqueKey'] ?? '',
            otp: args['otp'] ?? '',
          ),
        );
      case RoutesName.chooseRoleScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ChooseRoleScreen(uniqueKey: args?['uniqueKey'] ?? ''),
        );
      case RoutesName.personalInfoScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) =>
              PersonalInfoScreen(uniqueKey: args?['uniqueKey'] ?? ''),
        );
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutesName.bottomNavBar:
        return MaterialPageRoute(builder: (context) => BottomnavBar());
      case RoutesName.newInvestmentScreen:
        return MaterialPageRoute(builder: (context) => NewInvestmentScreen());
      case RoutesName.portFolioScreen:
        return MaterialPageRoute(builder: (context) => PortfolioScreen());
      case RoutesName.proceedPaymentScreen:
        return MaterialPageRoute(
          builder: (context) => ProceedToPaymentScreen(),
        );
      case RoutesName.paymentScreen:
        return MaterialPageRoute(builder: (context) => PaymentScreen());
      case RoutesName.userLoginScreen:
        return MaterialPageRoute(builder: (context) => UserLoginScreen());
      case RoutesName.loginOtpVerifyScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => UserLoginVerifyOtpScreen(
            mobileNumber: args['mobileNumber'] ?? '',
            uniqueKey: args['uniqueKey'] ?? '',
            otp: args['otp'] ?? '',
          ),
        );

      //**********************************************LAND OWNERS SCREEN FROM HERE **************************/

      case RoutesName.landOwnerBottomNavBar:
        return MaterialPageRoute(
          builder: (context) => LandOwnerBottomNavigationBar(),
        );

      //*************************************************WORKER PANEL SCREENS STARTED FROM HERE ************************************/

      case RoutesName.workerBottomNavBar:
        return MaterialPageRoute(
          builder: (context) => WorkerBottomNavigationBar(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(child: Text('No route generate')),
            );
          },
        );
    }
  }
}
