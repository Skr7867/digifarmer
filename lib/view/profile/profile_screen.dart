import 'package:digifarmer/blocs/appTheme/theme_bloc.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes/routes_name.dart';
import '../../res/color/app_colors.dart';
import '../../service/storage/local_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',

        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  LocalStorage localStorage = LocalStorage();
                  localStorage.clearValue('token').then((value) {
                    localStorage.clearValue('isLogin').then((value) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, RoutesName.userLoginScreen);
                    });
                  });
                },
                icon: Icon(Icons.logout, color: AppColors.redColor),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(
              icon: Icon(
                context.watch<ThemeBloc>().state.isDark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
            ),

            Text('Profile'),
          ],
        ),
      ),
    );
  }
}
