import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'blocs/appTheme/theme_bloc.dart';
import 'config/routes/routes.dart';
import 'view/serviceLocator/service_locator.dart';

GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
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
