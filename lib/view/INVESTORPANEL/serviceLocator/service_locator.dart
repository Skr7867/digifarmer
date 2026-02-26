import 'package:digifarmer/repository/invesmentPlan/all_investment_http_repository.dart';
import 'package:digifarmer/repository/invesmentPlan/all_investment_plan_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:digifarmer/blocs/appTheme/theme_bloc.dart';
import 'package:digifarmer/repository/chooseRole/choose_role_http_repository.dart';
import 'package:digifarmer/repository/chooseRole/choose_role_repository.dart';
import 'package:digifarmer/repository/loginOtpVerify/login_otp_verify_http_repository.dart';
import 'package:digifarmer/repository/loginOtpVerify/login_otp_verify_repository.dart';
import 'package:digifarmer/repository/personalInfo/personal_info_http_repository.dart';
import 'package:digifarmer/repository/personalInfo/personal_info_repository.dart';
import 'package:digifarmer/repository/register/user_register_http_api_repository.dart';
import 'package:digifarmer/repository/register/user_register_repository.dart';
import 'package:digifarmer/repository/userLogin/user_login_http_repository.dart';
import 'package:digifarmer/repository/userLogin/user_login_repository.dart';
import 'package:digifarmer/repository/verifyOtp/verify_otp_http_repository.dart';
import 'package:digifarmer/repository/verifyOtp/verify_otp_repository.dart';

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
}
