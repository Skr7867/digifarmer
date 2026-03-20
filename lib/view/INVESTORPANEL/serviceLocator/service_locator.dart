import 'package:digifarmer/repository/INVESTORPANEL/planPurchased/plan_purchased_http_repository.dart';
import 'package:digifarmer/repository/INVESTORPANEL/planPurchased/plan_purchased_repository.dart';
import 'package:digifarmer/repository/INVESTORPANEL/userProfile/user_profile_http_repository.dart';
import 'package:digifarmer/repository/INVESTORPANEL/userProfile/user_profile_repository.dart';
import 'package:digifarmer/repository/LANDOWNERPANEL/landImage/land_image_http_repository.dart';
import 'package:digifarmer/repository/LANDOWNERPANEL/landLocation/land_location_http_repository.dart';
import 'package:digifarmer/repository/LANDOWNERPANEL/landLocation/land_location_repository.dart';
import 'package:digifarmer/repository/LANDOWNERPANEL/landStatus/land_status_http_repository.dart';
import 'package:digifarmer/repository/LANDOWNERPANEL/landStatus/land_status_repository.dart';
import 'package:digifarmer/repository/LANDOWNERPANEL/saveBasicInfo/save_basic_info_http_repository.dart';
import 'package:digifarmer/repository/LANDOWNERPANEL/saveBasicInfo/save_basic_info_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/completeTask/complete_task_http_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/completeTask/complete_task_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/startTask/start_task_http_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/startTask/start_task_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/taskDetails/task_details_http_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/taskDetails/task_details_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/taskUpdate/task_update_http_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/taskUpdate/task_update_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/workerdashboard/worker_dashboard_http_repository.dart';
import 'package:digifarmer/repository/WORKERPANEL/workerdashboard/worker_dashboard_repository.dart';
import 'package:get_it/get_it.dart';

import '../../../blocs/INVESTORPANEL/appTheme/theme_bloc.dart';
import '../../../blocs/WORKERPANEL/attendanceHistory/attendance_history_bloc.dart';
import '../../../blocs/WORKERPANEL/landDetails/land_details_bloc.dart';
import '../../../blocs/WORKERPANEL/markAttendance/attendance_bloc.dart';
import '../../../repository/INVESTORPANEL/chooseRole/choose_role_http_repository.dart';
import '../../../repository/INVESTORPANEL/chooseRole/choose_role_repository.dart';
import '../../../repository/INVESTORPANEL/invesmentPlan/all_investment_http_repository.dart';
import '../../../repository/INVESTORPANEL/invesmentPlan/all_investment_plan_repository.dart';
import '../../../repository/INVESTORPANEL/loginOtpVerify/login_otp_verify_http_repository.dart';
import '../../../repository/INVESTORPANEL/loginOtpVerify/login_otp_verify_repository.dart';
import '../../../repository/INVESTORPANEL/personalInfo/personal_info_http_repository.dart';
import '../../../repository/INVESTORPANEL/personalInfo/personal_info_repository.dart';
import '../../../repository/INVESTORPANEL/register/user_register_http_api_repository.dart';
import '../../../repository/INVESTORPANEL/register/user_register_repository.dart';
import '../../../repository/INVESTORPANEL/userLogin/user_login_http_repository.dart';
import '../../../repository/INVESTORPANEL/userLogin/user_login_repository.dart';
import '../../../repository/INVESTORPANEL/verifyOtp/verify_otp_http_repository.dart';
import '../../../repository/INVESTORPANEL/verifyOtp/verify_otp_repository.dart';
import '../../../repository/LANDOWNERPANEL/landImage/land_image_repository.dart';
import '../../../repository/WORKERPANEL/attendance/workerCheckIn/worker_check_in_http_repository.dart';
import '../../../repository/WORKERPANEL/attendance/workerCheckIn/worker_check_in_repository.dart';
import '../../../repository/WORKERPANEL/attendance/workerCheckOut/worker_check_out_http_repository.dart';
import '../../../repository/WORKERPANEL/attendance/workerCheckOut/worker_check_out_repository.dart';
import '../../../repository/WORKERPANEL/attendanceHistory/attendance_history_http_repository.dart';
import '../../../repository/WORKERPANEL/attendanceHistory/attendance_history_repository.dart';
import '../../../repository/WORKERPANEL/landDetails/land_details_http_repository.dart';
import '../../../repository/WORKERPANEL/landDetails/land_details_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  /// BLOCS
  getIt.registerLazySingleton<ThemeBloc>(
    () => ThemeBloc()..add(LoadThemeEvent()),
  );

  /// REPOSITORIES
  getIt.registerLazySingleton<UserRegisterRepository>(
    () => UserRegisterHttpApiRepository(),
  );

  getIt.registerLazySingleton<VerifyOtpRepository>(
    () => VerifyOtpHttpRepository(),
  );

  getIt.registerLazySingleton<ChooseRoleRepository>(
    () => ChooseRoleHttpRepository(),
  );

  getIt.registerLazySingleton<PersonalInfoRepository>(
    () => PersonalInfoHttpRepository(),
  );

  getIt.registerLazySingleton<UserLoginRepository>(
    () => UserLoginHttpRepository(),
  );

  getIt.registerLazySingleton<LoginOtpVerifyRepository>(
    () => LoginOtpVerifyHttpRepository(),
  );
  getIt.registerLazySingleton<AllInvestmentPlanRepository>(
    () => AllInvestmentHttpRepository(),
  );
  getIt.registerLazySingleton<SaveBasicInfoRepository>(
    () => SaveBasicInfoHttpRepository(),
  );
  getIt.registerLazySingleton<LandLocationRepository>(
    () => LandLocationHttpRepository(),
  );
  getIt.registerLazySingleton<LandImagesRepository>(
    () => LandImagesHttpRepository(),
  );
  getIt.registerLazySingleton<LandStatusRepository>(
    () => LandStatusHttpRepository(),
  );
  getIt.registerLazySingleton<PlanPurchasedRepository>(
    () => PlanPurchasedHttpRepository(),
  );
  getIt.registerLazySingleton<WorkerDashboardRepository>(
    () => WorkerDashboardHttpRepository(),
  );
  getIt.registerLazySingleton<TaskDetailsRepository>(
    () => TaskDetailsHttpRepository(),
  );
  getIt.registerLazySingleton<StartTaskRepository>(
    () => StartTaskHttpRepository(),
  );
  getIt.registerLazySingleton<TaskUpdateRepository>(
    () => TaskUpdateHttpRepository(),
  );
  getIt.registerLazySingleton<CompleteTaskRepository>(
    () => CompleteTaskHttpRepository(),
  );

  getIt.registerLazySingleton<WorkerCheckInRepository>(
    () => WorkerCheckInHttpRepository(),
  );

  getIt.registerLazySingleton<WorkerCheckOutRepository>(
    () => WorkerCheckOutHttpRepository(),
  );

  getIt.registerFactory<WorkerAttendanceBloc>(
    () => WorkerAttendanceBloc(
      checkInRepository: getIt<WorkerCheckInHttpRepository>(),
      checkOutRepository: getIt<WorkerCheckOutHttpRepository>(),
    ),
  );

  getIt.registerLazySingleton<AttendanceHistoryRepository>(
    () => AttendanceHistoryHttpRepository(),
  );

  getIt.registerLazySingleton<UserProfileRepository>(
    () => UserProfileHttpRepository(),
  );

  getIt.registerFactory<AttendanceHistoryBloc>(
    () =>
        AttendanceHistoryBloc(repository: getIt<AttendanceHistoryRepository>()),
  );

  getIt.registerLazySingleton<LandDetailsRepository>(
    () => LandDetailsHttpRepository(),
  );

  getIt.registerFactory<LandDetailsBloc>(
    () =>
        LandDetailsBloc(landDetailsRepository: getIt<LandDetailsRepository>()),
  );
}
