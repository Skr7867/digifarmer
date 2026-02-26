import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/res/assets/image_assets.dart';
import 'package:digifarmer/res/customeWidgets/custom_paddings.dart';
import 'package:digifarmer/res/customeWidgets/custom_textfield.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/register/user_register_bloc.dart';
import '../../../repository/register/user_register_repository.dart';
import '../../../res/color/app_colors.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserRegisterBloc(getIt<UserRegisterRepository>()),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: BlocListener<UserRegisterBloc, UserRegisterState>(
            listenWhen: (current, previous) =>
                current.postApiStatus != previous.postApiStatus,

            listener: (context, state) {
              if (state.postApiStatus == PostApiStatus.error) {
                FlushBarHelper.flushBarErrorMessage(state.message, context);
              }

              if (state.postApiStatus == PostApiStatus.success) {
                FlushBarHelper.flushBarSuccessMessage(state.message, context);

                Navigator.pushNamed(
                  context,
                  RoutesName.otpVerifyScreen,
                  arguments: {'uniqueKey': state.uniqueKey, 'otp': state.otp},
                );
              }
            },
            child: Center(
              child: Padding(
                padding: ResponsivePadding.symmetricPadding(
                  context,
                  horizontal: 4,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Logo Section
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutBack,
                        builder: (context, double value, child) {
                          return Transform.scale(scale: value, child: child);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            ImageAssets.splashLogo,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

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

                      const SizedBox(height: 10),

                      Text(
                        'Login or create an account to continue',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppFonts.popins,
                          color: Colors.grey[600],
                        ),
                      ),

                      const SizedBox(height: 40),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: _label('Mobile Number', Colors.black87),
                      ),

                      const SizedBox(height: 8),

                      /// MOBILE FIELD
                      BlocBuilder<UserRegisterBloc, UserRegisterState>(
                        buildWhen: (current, previous) =>
                            current.mobile != previous.mobile,
                        builder: (context, state) {
                          return CustomTextField(
                            maxLength: 10,
                            fillColor: Colors.grey.shade50,
                            prefixIcon: Icons.phone_outlined,
                            hintText: 'Enter your mobile number',
                            keyboardType: TextInputType.phone,
                            borderColor: Colors.grey.shade300,
                            onChanged: (value) {
                              context.read<UserRegisterBloc>().add(
                                MobileNumber(mobile: value),
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your mobile number ';
                              }
                              return null;
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 20),

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
                                  stops: const [0.0, 0.2, 0.8, 1.0],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
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
                                  stops: const [0.0, 0.2, 0.8, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: _label('Email Address', Colors.black87),
                      ),

                      const SizedBox(height: 8),

                      BlocBuilder<UserRegisterBloc, UserRegisterState>(
                        buildWhen: (current, previous) =>
                            current.email != previous.email,
                        builder: (context, state) {
                          return CustomTextField(
                            fillColor: Colors.grey.shade50,
                            prefixIcon: Icons.email_outlined,
                            hintText: 'Enter your email address',
                            keyboardType: TextInputType.emailAddress,
                            borderColor: Colors.grey.shade300,
                            onChanged: (value) {
                              context.read<UserRegisterBloc>().add(
                                EmailChanged(email: value),
                              );
                            },
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Enter email address';
                            //   }
                            //   if (!value.contains('@')) {
                            //     return 'Enter valid email';
                            //   }
                            //   return null;
                            // },
                          );
                        },
                      ),

                      const SizedBox(height: 40),

                      /// SEND OTP BUTTON
                      BlocBuilder<UserRegisterBloc, UserRegisterState>(
                        buildWhen: (current, previous) =>
                            current.postApiStatus != previous.postApiStatus,
                        builder: (context, state) {
                          return RoundButton(
                            width: double.infinity,
                            height: 46,
                            buttonColor: AppColors.greenColor,
                            title: state.postApiStatus == PostApiStatus.loading
                                ? 'Please wait...'
                                : 'Send OTP',
                            onPress: () {
                              context.read<UserRegisterBloc>().add(SendOtp());
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 30),

                      Column(
                        children: [
                          Text(
                            'By continuing, you agree to our',
                            style: TextStyle(
                              color: const Color(0xffBFC9D6),
                              fontSize: 12,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Terms of Service & Privacy Policy",
                              style: TextStyle(
                                color: const Color(0xff0D47A1),
                                fontSize: 13,
                                fontFamily: AppFonts.popinsBold,
                                decoration: TextDecoration.underline,
                                decorationColor: const Color(
                                  0xff0D47A1,
                                ).withOpacity(0.3),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
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
