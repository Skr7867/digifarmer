import 'package:digifarmer/config/routes/routes_name.dart';
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
        return MaterialPageRoute(builder: (context) => ChooseRoleScreen());
      case RoutesName.personalInfoScreen:
        return MaterialPageRoute(builder: (context) => PersonalInfoScreen());
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
