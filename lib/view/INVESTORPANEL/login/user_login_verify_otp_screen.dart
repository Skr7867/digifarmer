// user_login_verify_otp_screen.dart
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../blocs/INVESTORPANEL/loginOtpVerify/login_otp_verify_bloc.dart';
import '../../../repository/INVESTORPANEL/loginOtpVerify/login_otp_verify_repository.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/color/app_colors.dart';
import '../../../res/fonts/app_fonts.dart';

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

  // Single controller for pinput
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  late AnimationController _animationController;
  late AnimationController _shakeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _bloc = LoginVerifyOtpBloc(getIt<LoginOtpVerifyRepository>());
    _bloc.add(SetUniqueKey(widget.uniqueKey));
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _shakeAnimation =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
        ]).animate(
          CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    _animationController.dispose();
    _shakeController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _triggerShake() {
    _shakeController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6FAF7),
        appBar: CustomAppBar(
          title: 'Verify OTP',
          centerTitle: true,
          automaticallyImplyLeading: true,
          gradient: const LinearGradient(
            colors: [Color(0xff34A853), Color(0xff0D47A1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        body: BlocListener<LoginVerifyOtpBloc, LoginVerifyOtpState>(
          listenWhen: (current, previous) =>
              current.postApiStatus != previous.postApiStatus ||
              current.resendPostApiStatus != previous.resendPostApiStatus,
          listener: (context, state) {
            if (state.postApiStatus == PostApiStatus.error) {
              _triggerShake();
              _pinController.clear();
              _bloc.add(OtpChanged(''));
              FlushBarHelper.flushBarErrorMessage(state.message, context);
            }

            if (state.postApiStatus == PostApiStatus.success) {
              FlushBarHelper.flushBarSuccessMessage(state.message, context);
              _navigateByRole(context, state.role);
            }

            if (state.resendPostApiStatus == ResendPostApiStatus.error) {
              FlushBarHelper.flushBarErrorMessage(state.message, context);
            }

            if (state.resendPostApiStatus == ResendPostApiStatus.success) {
              FlushBarHelper.flushBarSuccessMessage(
                'OTP resent successfully!',
                context,
              );
              _pinController.clear();
              _bloc.add(OtpChanged(''));
              _pinFocusNode.requestFocus();
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildHeader(size),
                      const SizedBox(height: 40),
                      _buildOtpSection(),
                      const SizedBox(height: 28),
                      _buildTimerSection(),
                      const SizedBox(height: 36),
                      _buildVerifyButton(),
                      const SizedBox(height: 20),
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

  void _navigateByRole(BuildContext context, String role) {
    switch (role) {
      case "INVESTOR":
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.bottomNavBar,
          (route) => false,
        );
        break;
      case "LAND_OWNER":
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.landOwnerBottomNavBar,
          (route) => false,
        );
        break;
      case "WORKER":
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.workerBottomNavBar,
          (route) => false,
        );
        break;
      default:
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.bottomNavBar,
          (route) => false,
        );
    }
  }

  Widget _buildHeader(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Logo with bounce animation
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutBack,
          builder: (context, value, child) =>
              Transform.scale(scale: value, child: child),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.greenColor.withValues(alpha: 0.18),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Image.asset(
              ImageAssets.splashLogo,
              height: size.width * 0.13,
              width: size.width * 0.13,
            ),
          ),
        ),

        const SizedBox(height: 28),

        Text(
          'Verify Your\nMobile Number',
          style: TextStyle(
            fontSize: size.width * 0.075,
            fontFamily: AppFonts.popinsBold,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -0.5,
            color: const Color(0xFF1A2E1A),
          ),
        ),

        const SizedBox(height: 14),

        /// OTP hint chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_open_rounded,
                size: 14,
                color: AppColors.greenColor,
              ),
              const SizedBox(width: 6),
              Text(
                'Your OTP: ${widget.otp}',
                style: TextStyle(
                  color: AppColors.greenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: AppFonts.popinsBold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 15,
              fontFamily: AppFonts.popins,
              color: Colors.grey.shade500,
              height: 1.6,
            ),
            children: [
              const TextSpan(text: 'Code sent to '),
              TextSpan(
                text: '+91 ${widget.mobileNumber}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A2E1A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpSection() {
    /// Pinput theme definitions
    final defaultPinTheme = PinTheme(
      width: 52,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        fontFamily: AppFonts.popinsBold,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A2E1A),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greenColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.greenColor.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.greenColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greenColor, width: 1.5),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade400, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter 6-digit OTP',
          style: TextStyle(
            fontSize: 13,
            fontFamily: AppFonts.popinsBold,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 16),

        /// Shake animation wraps Pinput
        AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) => Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: child,
          ),
          child: BlocBuilder<LoginVerifyOtpBloc, LoginVerifyOtpState>(
            buildWhen: (c, p) => c.postApiStatus != p.postApiStatus,
            builder: (context, state) {
              final hasError = state.postApiStatus == PostApiStatus.error;
              return Pinput(
                length: 6,
                controller: _pinController,
                focusNode: _pinFocusNode,
                autofocus: true,
                defaultPinTheme: hasError ? errorPinTheme : defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                errorPinTheme: errorPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                showCursor: true,
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 2.5,
                      decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                onChanged: (value) {
                  _bloc.add(OtpChanged(value));
                },
                onCompleted: (value) {
                  _bloc.add(OtpChanged(value));
                  // Auto-submit when all 6 digits entered
                  _bloc.add(SubmitLoginOtp());
                },
              );
            },
          ),
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
        final isExpired = state.isResendEnabled;
        final isWarning = state.remainingSeconds < 10 && !isExpired;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: BoxDecoration(
            color: isExpired
                ? Colors.orange.shade50
                : isWarning
                ? Colors.red.shade50
                : Colors.green.shade50,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isExpired
                  ? Colors.orange.shade200
                  : isWarning
                  ? Colors.red.shade200
                  : Colors.green.shade100,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isExpired ? Icons.timer_off_outlined : Icons.timer_outlined,
                    color: isExpired
                        ? Colors.orange.shade600
                        : isWarning
                        ? Colors.red.shade600
                        : AppColors.greenColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isExpired ? 'OTP expired' : 'Time remaining',
                    style: TextStyle(
                      color: isExpired
                          ? Colors.orange.shade700
                          : isWarning
                          ? Colors.red.shade700
                          : AppColors.greenColor,
                      fontFamily: AppFonts.popins,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              if (!isExpired)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isWarning
                          ? Colors.red.shade300
                          : Colors.green.shade200,
                    ),
                  ),
                  child: Text(
                    '00:${state.remainingSeconds.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: isWarning
                          ? Colors.red.shade700
                          : AppColors.greenColor,
                      fontFamily: AppFonts.popinsBold,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1,
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
          current.postApiStatus != previous.postApiStatus ||
          current.otp != previous.otp,
      builder: (context, state) {
        final isLoading = state.postApiStatus == PostApiStatus.loading;
        final isComplete = (state.otp.length) == 6;
        final isActive = isComplete && !isLoading;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: isActive
                ? LinearGradient(
                    colors: [
                      AppColors.greenColor,
                      Color.lerp(
                        AppColors.greenColor,
                        Colors.green.shade800,
                        0.4,
                      )!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [Colors.grey.shade300, Colors.grey.shade300],
                  ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.greenColor.withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: ElevatedButton(
            onPressed: isActive ? () => _bloc.add(SubmitLoginOtp()) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: AppFonts.popinsBold,
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.white : Colors.grey.shade400,
                          letterSpacing: 0.4,
                        ),
                      ),
                      if (isActive) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ],
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
        final isLoading =
            state.resendPostApiStatus == ResendPostApiStatus.loading;
        final isEnabled = state.isResendEnabled && !isLoading;

        return Center(
          child: Column(
            children: [
              Text(
                "Didn't receive the code?",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontFamily: AppFonts.popins,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: isEnabled
                    ? () => _bloc.add(ResendOtpEvent(widget.mobileNumber))
                    : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? AppColors.greenColor.withValues(alpha: 0.08)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isEnabled
                          ? AppColors.greenColor.withValues(alpha: 0.6)
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLoading)
                        SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.greenColor,
                            ),
                          ),
                        )
                      else
                        Icon(
                          Icons.refresh_rounded,
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
                          fontSize: 14,
                          letterSpacing: 0.3,
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
