import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/repository/register/user_register_http_api_repository.dart';
import 'package:digifarmer/repository/register/user_register_repository.dart';
import 'package:digifarmer/repository/verifyOtp/verify_otp_http_repository.dart';
import 'package:digifarmer/repository/verifyOtp/verify_otp_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'config/routes/routes.dart';

GetIt getIt = GetIt.instance;
void main() {
  serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

void serviceLocator() {
  getIt.registerLazySingleton<UserRegisterRepository>(
    () => UserRegisterHttpApiRepository(),
  );
  getIt.registerLazySingleton<VerifyOtpRepository>(
    () => VerifyOtpHttpRepository(),
  );
}
