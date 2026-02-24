import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/assets/image_assets.dart';
import 'package:digifarmer/res/customeWidgets/custom_paddings.dart';
import 'package:digifarmer/res/customeWidgets/custom_textfield.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../res/color/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: ResponsivePadding.symmetricPadding(context, horizontal: 4),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Section with subtle animation
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeOutBack,
                    builder: (context, double value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(
                        ImageAssets.splashLogo,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Welcome Text with improved styling
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: AppFonts.popinsBold,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Login or create an account to continue',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppFonts.popins,
                      color: Colors.grey[600],
                    ),
                  ),

                  SizedBox(height: 40),

                  // Mobile Number Section - Labels now at start
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _label('Mobile Number', Colors.black87),
                  ),

                  SizedBox(height: 8),

                  CustomTextField(
                    maxLength: 10,
                    controller: _mobileController,
                    fillColor: Colors.grey.shade50,
                    prefixIcon: Icons.phone_outlined,
                    hintText: 'Enter your mobile number',
                    keyboardType: TextInputType.phone,
                    borderColor: Colors.grey.shade300,
                  ),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.grey.shade400,
                                Colors.grey.shade400,
                                Colors.transparent,
                              ],
                              stops: [0.0, 0.2, 0.8, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: AppFonts.popinsBold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.grey.shade400,
                                Colors.grey.shade400,
                                Colors.transparent,
                              ],
                              stops: [0.0, 0.2, 0.8, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Email Address Section - Labels now at start
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _label('Email Address', Colors.black87),
                  ),

                  SizedBox(height: 8),

                  CustomTextField(
                    controller: _emailController,
                    fillColor: Colors.grey.shade50,
                    prefixIcon: Icons.email_outlined,
                    hintText: 'Enter your email address',
                    keyboardType: TextInputType.emailAddress,
                    borderColor: Colors.grey.shade300,
                  ),

                  SizedBox(height: 40),

                  // Send OTP Button with improved styling
                  RoundButton(
                    width: double.infinity,
                    height: 46,
                    buttonColor: AppColors.greenColor,
                    title: 'Send OTP',

                    onPress: () {
                      Navigator.pushNamed(context, RoutesName.otpVerifyScreen);
                    },
                  ),

                  SizedBox(height: 30),

                  // Terms and Conditions
                  Column(
                    children: [
                      Text(
                        'By continuing, you agree to our',
                        style: TextStyle(
                          color: Color(0xffBFC9D6),
                          fontSize: 12,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      SizedBox(height: 4),
                      InkWell(
                        onTap: () {
                          // Navigate to terms of service
                        },
                        child: Text(
                          "Terms of Service & Privacy Policy",
                          style: TextStyle(
                            color: Color(0xff0D47A1),
                            fontSize: 13,
                            fontFamily: AppFonts.popinsBold,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xff0D47A1).withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 14,
        fontFamily: AppFonts.popinsBold,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
