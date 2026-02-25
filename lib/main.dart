import 'package:digifarmer/config/routes/routes_name.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'blocs/appTheme/theme_bloc.dart';
import 'config/routes/routes.dart';

GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocator();

  runApp(
    BlocProvider<ThemeBloc>(
      create: (_) => getIt<ThemeBloc>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state.themeData,
          initialRoute: RoutesName.splashScreen,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}

void serviceLocator() {
  getIt.registerLazySingleton<ThemeBloc>(
    () => ThemeBloc()..add(LoadThemeEvent()),
  );
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
}
