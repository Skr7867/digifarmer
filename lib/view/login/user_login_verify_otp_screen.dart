// user_login_verify_otp_screen.dart
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/repository/loginOtpVerify/login_otp_verify_repository.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/loginOtpVerify/login_otp_verify_bloc.dart';
import '../../res/assets/image_assets.dart';
import '../../res/color/app_colors.dart';
import '../../res/fonts/app_fonts.dart';

class UserLoginVerifyOtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String uniqueKey;
  final String otp;

  const UserLoginVerifyOtpScreen({
    super.key,
    required this.mobileNumber,
    required this.uniqueKey,
    required this.otp,
  });

  @override
  State<UserLoginVerifyOtpScreen> createState() =>
      _UserLoginVerifyOtpScreenState();
}

class _UserLoginVerifyOtpScreenState extends State<UserLoginVerifyOtpScreen>
    with TickerProviderStateMixin {
  late final LoginVerifyOtpBloc _bloc;

  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _bloc = LoginVerifyOtpBloc(getIt<LoginOtpVerifyRepository>());

    /// Set unique key once
    _bloc.add(SetUniqueKey(widget.uniqueKey));

    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    _animationController.dispose();
    _bloc.close();
    super.dispose();
  }

  String get _enteredOtp => _otpControllers.map((e) => e.text).join();

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }

    _bloc.add(OtpChanged(_enteredOtp));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: CustomAppBar(
          title: 'Verify OTP',
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: BlocListener<LoginVerifyOtpBloc, LoginVerifyOtpState>(
          listenWhen: (current, previous) =>
              current.postApiStatus != previous.postApiStatus ||
              current.resendPostApiStatus != previous.resendPostApiStatus,
          listener: (context, state) {
            // Handle OTP verification
            if (state.postApiStatus == PostApiStatus.error) {
              FlushBarHelper.flushBarErrorMessage(state.message, context);
            }

            if (state.postApiStatus == PostApiStatus.success) {
              FlushBarHelper.flushBarSuccessMessage(state.message, context);

              /// Navigate to home
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.bottomNavBar,
                (route) => false,
              );
            }

            // Handle Resend OTP
            if (state.resendPostApiStatus == ResendPostApiStatus.error) {
              FlushBarHelper.flushBarErrorMessage(state.message, context);
            }

            if (state.resendPostApiStatus == ResendPostApiStatus.success) {
              FlushBarHelper.flushBarSuccessMessage(
                'OTP resent successfully!',
                context,
              );

              // Clear OTP fields after resend
              for (var controller in _otpControllers) {
                controller.clear();
              }
              _otpFocusNodes[0].requestFocus();
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildHeader(size),
                      const SizedBox(height: 40),
                      _buildOtpInput(isSmallScreen),
                      const SizedBox(height: 30),
                      _buildTimerSection(),
                      const SizedBox(height: 40),
                      _buildVerifyButton(),
                      const SizedBox(height: 16),
                      _buildResendButton(),
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

  Widget _buildHeader(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              ImageAssets.splashLogo,
              height: size.width * 0.15,
              width: size.width * 0.15,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Verify Your\nMobile Number',
          style: TextStyle(
            fontSize: size.width * 0.08,
            fontFamily: AppFonts.popinsBold,
            fontWeight: FontWeight.bold,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Your OTP is : ${widget.otp}',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              fontFamily: AppFonts.popins,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
            children: [
              const TextSpan(text: 'We have sent a verification code to\n'),
              TextSpan(
                text: '+91 ${widget.mobileNumber}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpInput(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter OTP',
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.popinsBold,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return Container(
              width: isSmallScreen ? 45 : 45,
              height: isSmallScreen ? 55 : 55,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.grey.shade50],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                controller: _otpControllers[index],
                focusNode: _otpFocusNodes[index],
                onChanged: (value) => _onOtpChanged(index, value),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 20,
                  fontFamily: AppFonts.popinsBold,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.greenColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTimerSection() {
    return BlocBuilder<LoginVerifyOtpBloc, LoginVerifyOtpState>(
      buildWhen: (current, previous) =>
          current.remainingSeconds != previous.remainingSeconds ||
          current.isResendEnabled != previous.isResendEnabled,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.shade100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.timer_outlined, color: AppColors.greenColor),
                  const SizedBox(width: 8),
                  Text(
                    'Time remaining',
                    style: TextStyle(
                      color: AppColors.greenColor,
                      fontFamily: AppFonts.popins,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Text(
                  '00:${state.remainingSeconds.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: state.remainingSeconds < 10
                        ? Colors.red.shade700
                        : AppColors.greenColor,
                    fontFamily: AppFonts.popinsBold,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVerifyButton() {
    return BlocBuilder<LoginVerifyOtpBloc, LoginVerifyOtpState>(
      buildWhen: (current, previous) =>
          current.postApiStatus != previous.postApiStatus,
      builder: (context, state) {
        final isLoading = state.postApiStatus == PostApiStatus.loading;

        return Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                AppColors.greenColor.withValues(alpha: 0.8),
                AppColors.greenColor,
                AppColors.greenColor.withValues(alpha: 0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.greenColor.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isLoading || _enteredOtp.length != 6
                ? null
                : () {
                    _bloc.add(SubmitLoginOtp());
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Verify OTP',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: AppFonts.popinsBold,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildResendButton() {
    return BlocBuilder<LoginVerifyOtpBloc, LoginVerifyOtpState>(
      buildWhen: (current, previous) =>
          current.isResendEnabled != previous.isResendEnabled ||
          current.resendPostApiStatus != previous.resendPostApiStatus,
      builder: (context, state) {
        // FIXED: Use ResendPostApiStatus instead of PostApiStatus
        final isLoading =
            state.resendPostApiStatus == ResendPostApiStatus.loading;
        final isEnabled = state.isResendEnabled && !isLoading;

        return Center(
          child: Column(
            children: [
              if (!state.isResendEnabled)
                Text(
                  "Didn't receive the code?",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: AppFonts.popins,
                    fontSize: 14,
                  ),
                ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: isEnabled
                    ? () {
                        _bloc.add(ResendOtpEvent(widget.mobileNumber));
                      }
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? AppColors.greenColor.withValues(alpha: 0.1)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isEnabled
                          ? AppColors.greenColor
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLoading)
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.greenColor,
                            ),
                          ),
                        )
                      else
                        Icon(
                          Icons.refresh,
                          size: 18,
                          color: isEnabled
                              ? AppColors.greenColor
                              : Colors.grey.shade400,
                        ),
                      const SizedBox(width: 8),
                      Text(
                        isLoading ? 'Resending...' : 'Resend OTP',
                        style: TextStyle(
                          color: isEnabled
                              ? AppColors.greenColor
                              : Colors.grey.shade400,
                          fontFamily: AppFonts.popinsBold,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
