import 'package:digifarmer/lib/config/routes/routes_name.dart';
import 'package:digifarmer/lib/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/INVESTORPANEL/planPurchase/plan_purchase_bloc.dart';
import '../../blocs/WORKERPANEL/attendanceHistory/attendance_history_bloc.dart';
import '../../blocs/WORKERPANEL/landDetails/land_details_bloc.dart';
import '../../model/INVESTORPANEL/investmentPlan/investment_select_model.dart';
import '../../repository/INVESTORPANEL/planPurchased/plan_purchased_repository.dart';
import '../../view/INVESTORPANEL/activeInvestment/active_investment_screen.dart';
import '../../view/INVESTORPANEL/contractSign/contract_sign_screen.dart';
import '../../view/INVESTORPANEL/investmentDetails/investment_details_screen.dart';
import '../../view/INVESTORPANEL/paymentSuccess/payment_sucess_screen.dart';
import '../../view/INVESTORPANEL/profile/profile_screen.dart';
import '../../view/INVESTORPANEL/withdrawStatus/withdraw_status_screen.dart';
import '../../view/LANDOWNERPANEL/landStatus/land_status_screen.dart';
import '../../view/LANDOWNERPANEL/uploadLandImage/upload_land_image_screen.dart';
import '../../view/WORKERPANEL/allLands/all_land_screen.dart';
import '../../view/WORKERPANEL/allTask/all_task_screen.dart';
import '../../view/WORKERPANEL/attendanceHistory/attendance_history_screen.dart';
import '../../view/WORKERPANEL/completeTask/complete_task_screen.dart';
import '../../view/WORKERPANEL/helpAndSupport/help_and_support_screen.dart';
import '../../view/WORKERPANEL/landDetails/land_details_screen.dart';
import '../../view/WORKERPANEL/markAttendance/mark_attendance_screen.dart';
import '../../view/WORKERPANEL/notification/worker_notification_screen.dart';
import '../../view/WORKERPANEL/profile/worker_profile_screen.dart';
import '../../view/WORKERPANEL/setting/worker_setting_screen.dart';
import '../../view/WORKERPANEL/submitTask/submit_task_screen.dart';
import '../../view/WORKERPANEL/taskDetails/worker_task_details_screen.dart';
import '../../view/WORKERPANEL/taskUpdate/task_update_screen.dart';
import '../../view/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.userRegisterScreen:
        return MaterialPageRoute(builder: (context) => UserRegisterScreen());
      case RoutesName.userProfileScreen:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case RoutesName.activeInvestmentScreen:
        return MaterialPageRoute(
          builder: (context) => ActiveInvestmentScreen(),
        );
      case RoutesName.withdrawScreen:
        return MaterialPageRoute(
          builder: (context) => WithdrawalStatusScreen(),
        );
      case RoutesName.investmentDetailsScreen:
        final investmentId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) =>
              InvestmentDetailsScreen(investmentId: investmentId),
        );
      case RoutesName.allTaskScreen:
        return MaterialPageRoute(builder: (context) => AllTaskScreen());
      case RoutesName.allLandsScreen:
        return MaterialPageRoute(builder: (context) => AllLandScreen());
      case RoutesName.contractSignScreen:
        return MaterialPageRoute(builder: (context) => ContractSignScreen());

      case RoutesName.paymentSucessScreen:
        return MaterialPageRoute(builder: (context) => PaymentSuccessScreen());
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
        final args = settings.arguments as Map<String, dynamic>;
        final String taskId = args['leadId'];
        return MaterialPageRoute(
          builder: (context) => WorkerTaskDetailsScreen(taskId: taskId),
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
      case RoutesName.workerSettingScreen:
        return MaterialPageRoute(builder: (context) => WorkerSettingScreen());
      case RoutesName.workerHelpSupportScreen:
        return MaterialPageRoute(
          builder: (context) => WorkerHelpAndSupportScreen(),
        );
      case RoutesName.workerTaskUpdateScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => WorkerTaskUpdateScreen(taskId: args?['taskId'] ?? ''),
        );
      case RoutesName.completeTaskScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => WorkerCompleteTaskScreen(
            taskId: args?['taskId'] ?? '',
            taskTitle: args?['taskTitle'] ?? '',
          ),
        );
      case RoutesName.markAttendaceScreen:
        return MaterialPageRoute(builder: (context) => MarkAttendanceScreen());
      case RoutesName.attendanceHistoryScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AttendanceHistoryBloc>(
            create: (_) => getIt<AttendanceHistoryBloc>(),
            child: const AttendanceHistory(),
          ),
        );

      case RoutesName.landDetailScreen:
        return MaterialPageRoute(
          builder: (context) {
            final taskId = settings.arguments as String;
            return BlocProvider<LandDetailsBloc>(
              create: (_) => getIt<LandDetailsBloc>(),
              child: LandDetailsScreen(taskId: taskId),
            );
          },
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
