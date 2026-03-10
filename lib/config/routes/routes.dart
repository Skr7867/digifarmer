import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/view/LANDOWNERPANEL/uploadLandImage/upload_land_image_screen.dart';
import 'package:digifarmer/view/WORKERPANEL/notification/worker_notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/INVESTORPANEL/planPurchase/plan_purchase_bloc.dart';
import '../../model/INVESTORPANEL/investmentPlan/investment_select_model.dart';
import '../../repository/INVESTORPANEL/planPurchased/plan_purchased_repository.dart';
import '../../view/LANDOWNERPANEL/landStatus/land_status_screen.dart';
import '../../view/WORKERPANEL/profile/worker_profile_screen.dart';
import '../../view/WORKERPANEL/submitTask/submit_task_screen.dart';
import '../../view/WORKERPANEL/taskDetails/worker_task_details_screen.dart';
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
        final investment = settings.arguments as InvestmentSelectionModel;

        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) =>
                PurchasePlanBloc(repository: getIt<PlanPurchasedRepository>()),
            child: ProceedToPaymentScreen(investment: investment),
          ),
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
      case RoutesName.addNewLandScreen:
        return MaterialPageRoute(builder: (context) => AddNewLandScreen());
      case RoutesName.locationScreen:
        final tempId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => LocationScreen(tempId: tempId),
        );
      case RoutesName.uploadLandImageScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        final tempId = args?['tempId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => UploadLandImagesScreen(tempId: tempId),
        );

      case RoutesName.landStatusScreen:
        return MaterialPageRoute(builder: (context) => LandStatusScreen());
      //*************************************************WORKER PANEL SCREENS STARTED FROM HERE ************************************/

      case RoutesName.workerBottomNavBar:
        return MaterialPageRoute(
          builder: (context) => WorkerBottomNavigationBar(),
        );
      case RoutesName.workerTaskDetails:
        return MaterialPageRoute(
          builder: (context) => WorkerTaskDetailsScreen(),
        );
      case RoutesName.workerTaskSubmit:
        return MaterialPageRoute(
          builder: (context) => WorkerTaskSubmitScreen(),
        );
      case RoutesName.workerNotification:
        return MaterialPageRoute(
          builder: (context) => WorkerNotificationScreen(),
        );
      case RoutesName.workerProfileScreen:
        return MaterialPageRoute(builder: (context) => WorkerProfileScreen());
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
