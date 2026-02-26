import 'dart:developer';

import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/repository/userLogin/user_login_repository.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/login/user_login_bloc.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/color/app_colors.dart';
import '../../../res/customeWidgets/custom_textfield.dart';
import '../../../res/customeWidgets/round_button.dart';
import '../../../res/fonts/app_fonts.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();

  late final LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(getIt<UserLoginRepository>());
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _loginBloc,
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
            listenWhen: (current, previous) =>
                current.postApiStatus != previous.postApiStatus,
            listener: (context, state) {
              if (state.postApiStatus == PostApiStatus.error) {
                FlushBarHelper.flushBarErrorMessage(state.message, context);
              }

              if (state.postApiStatus == PostApiStatus.success) {
                log('OTP from state: ${state.otp}');
                FlushBarHelper.flushBarSuccessMessage(state.message, context);

                Navigator.pushNamed(
                  context,
                  RoutesName.loginOtpVerifyScreen,
                  arguments: {
                    "uniqueKey": state.uniqueKey,
                    "mobileNumber": state.mobileNumber,
                    "otp": state.otp,
                  },
                );
              }
            },
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _LoginHeader(),
                      const SizedBox(height: 40),

                      /// FORM
                      _buildLoginForm(),

                      const SizedBox(height: 38),

                      /// FOOTER
                      _buildFooter(),
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

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FormLabel('Mobile Number'),
        const SizedBox(height: 8),
        CustomTextField(
          controller: _mobileController,
          maxLength: 10,
          fillColor: Colors.grey.shade50,
          prefixIcon: Icons.phone_outlined,
          hintText: 'Enter your mobile number',
          keyboardType: TextInputType.phone,
          borderColor: Colors.grey.shade300,
          validator: _validateMobileNumber,
          onChanged: (value) {
            _loginBloc.add(MobileNumberChanged(value));
          },
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        BlocBuilder<LoginBloc, LoginState>(
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
              onPress: state.postApiStatus == PostApiStatus.loading
                  ? null
                  : () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _loginBloc.add(SubmitLogin());
                      }
                    },
            );
          },
        ),
        const SizedBox(height: 8),
        _CreateAccountButton(),
      ],
    );
  }

  String? _validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    return null;
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutBack,
          builder: (context, double value, child) {
            return Transform.scale(scale: value, child: child);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.asset(ImageAssets.splashLogo, height: 100, width: 100),
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
      ],
    );
  }
}

class _FormLabel extends StatelessWidget {
  final String text;
  const _FormLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontFamily: AppFonts.popinsBold,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, RoutesName.userRegisterScreen);
      },
      child: Text(
        "Don't have an Account? Create one",
        style: TextStyle(
          color: AppColors.greenColor,
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.popins,
        ),
      ),
    );
  }
}
