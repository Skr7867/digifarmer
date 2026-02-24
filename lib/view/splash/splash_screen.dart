import 'dart:async';

import 'package:flutter/material.dart';

import '../../config/routes/routes_name.dart';
import '../../res/assets/image_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, RoutesName.userRegisterScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImageAssets.splashLogo, height: 70, width: 70),
      ),
    );
  }
}
