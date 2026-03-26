import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/main.dart';
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

  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  // Animation controllers
  late AnimationController _entranceController;
  late AnimationController _shakeController;
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _successController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _shakeAnimation;
  late Animation<double> _floatingAnim;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _bloc = LoginVerifyOtpBloc(getIt<LoginOtpVerifyRepository>());
    _bloc.add(SetUniqueKey(widget.uniqueKey));
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Entrance
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeIn),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Shake on error
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
        ]).animate(
          CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
        );

    // Floating background elements
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _floatingAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    // Pulse on logo
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.88, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Success micro-animation
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    _entranceController.dispose();
    _shakeController.dispose();
    _floatingController.dispose();
    _pulseController.dispose();
    _successController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _triggerShake() => _shakeController.forward(from: 0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 680;

    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        body: Stack(
          children: [
            // ── Background ─────────────────────────────────────────────
            _buildBackground(size),

            // ── Floating decorations ────────────────────────────────────
            _buildFloatingDecor(size),

            // ── Content ─────────────────────────────────────────────────
            BlocListener<LoginVerifyOtpBloc, LoginVerifyOtpState>(
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
                child: Column(
                  children: [
                    _buildAppBar(context),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                          vertical: isSmall ? 12 : 20,
                        ),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                              children: [
                                _buildTopCard(size, isSmall),
                                SizedBox(height: isSmall ? 16 : 24),
                                _buildOtpCard(size, isSmall),
                                SizedBox(height: isSmall ? 14 : 20),
                                _buildTimerCard(),
                                SizedBox(height: isSmall ? 20 : 28),
                                _buildVerifyButton(size),
                                SizedBox(height: isSmall ? 14 : 20),
                                _buildResendSection(),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── CUSTOM APP BAR ──────────────────────────────────────────────────────────

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF34A853), Color(0xFF0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const Expanded(
            child: Text(
              'Verify OTP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: AppFonts.popinsBold,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
          // Balance the back arrow
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // ── BACKGROUND ──────────────────────────────────────────────────────────────

  Widget _buildBackground(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFF9F3), Color(0xFFE8F4FD), Color(0xFFF8FFFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Top-right green blob
          Positioned(
            top: -size.height * 0.06,
            right: -size.width * 0.18,
            child: Container(
              width: size.width * 0.65,
              height: size.width * 0.65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF34A853).withOpacity(0.16),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Bottom-left blue blob
          Positioned(
            bottom: -size.height * 0.04,
            left: -size.width * 0.12,
            child: Container(
              width: size.width * 0.5,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF0D47A1).withOpacity(0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Dot grid
          CustomPaint(
            size: Size(size.width, size.height),
            painter: _DotGridPainter(),
          ),
        ],
      ),
    );
  }

  // ── FLOATING DECORATIONS ────────────────────────────────────────────────────

  Widget _buildFloatingDecor(Size size) {
    return AnimatedBuilder(
      animation: _floatingAnim,
      builder: (context, _) {
        return Stack(
          children: [
            Positioned(
              top: size.height * 0.15 + (_floatingAnim.value * 14),
              left: 16,
              child: _buildLeaf(
                22,
                0.5 + _floatingAnim.value * 0.2,
                const Color(0xFF34A853).withOpacity(0.2),
              ),
            ),
            Positioned(
              top: size.height * 0.22 - (_floatingAnim.value * 10),
              right: 20,
              child: _buildLeaf(
                16,
                -0.7 + _floatingAnim.value * 0.15,
                const Color(0xFF0D47A1).withOpacity(0.15),
              ),
            ),
            Positioned(
              top: size.height * 0.10 + (_floatingAnim.value * 7),
              right: size.width * 0.35,
              child: _buildDot(7, const Color(0xFF34A853).withOpacity(0.25)),
            ),
            Positioned(
              top: size.height * 0.32 - (_floatingAnim.value * 8),
              left: size.width * 0.22,
              child: Transform.rotate(
                angle: 0.785 + _floatingAnim.value * 0.3,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLeaf(double size, double angle, Color color) {
    return Transform.rotate(
      angle: angle,
      child: CustomPaint(
        size: Size(size, size),
        painter: _LeafPainter(color: color),
      ),
    );
  }

  Widget _buildDot(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  // ── TOP CARD (logo + heading + otp chip) ────────────────────────────────────

  Widget _buildTopCard(Size size, bool isSmall) {
    final logoSize = isSmall ? size.width * 0.14 : size.width * 0.16;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmall ? 20 : 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF34A853).withOpacity(0.10),
            blurRadius: 36,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo with pulse
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: _pulseAnim.value,
                    child: Container(
                      width: logoSize + 24,
                      height: logoSize + 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF34A853).withOpacity(0.12),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: logoSize + 10,
                    height: logoSize + 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF34A853).withOpacity(0.20),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(ImageAssets.splashLogo),
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 18),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Verify\n',
                        style: TextStyle(
                          fontSize: isSmall ? 22 : 26,
                          fontFamily: AppFonts.popinsBold,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A2E1A),
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                      TextSpan(
                        text: 'Mobile Number',
                        style: TextStyle(
                          fontSize: isSmall ? 22 : 26,
                          fontFamily: AppFonts.popinsBold,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF34A853),
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isSmall ? 8 : 12),
                // Sent to chip
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF5FB),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF0D47A1).withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.phone_android_rounded,
                        size: 12,
                        color: Color(0xFF0D47A1),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          '+91 ${widget.mobileNumber}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: AppFonts.popinsBold,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0D47A1),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── OTP CARD ────────────────────────────────────────────────────────────────

  Widget _buildOtpCard(Size size, bool isSmall) {
    final pinWidth = ((size.width * 0.88) - 56) / 6;
    final pinHeight = isSmall ? 54.0 : 62.0;

    final defaultPinTheme = PinTheme(
      width: pinWidth,
      height: pinHeight,
      textStyle: TextStyle(
        fontSize: isSmall ? 20 : 22,
        fontFamily: AppFonts.popinsBold,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A2E1A),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FFFE),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF34A853), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF34A853).withOpacity(0.20),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: const Color(0xFF34A853).withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF34A853), width: 1.5),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.red.shade400, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmall ? 20 : 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF34A853).withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF34A853), Color(0xFF0D47A1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Enter 6-digit OTP',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppFonts.popinsBold,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A2E1A),
                ),
              ),
              const Spacer(),
              // OTP hint badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
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
                      size: 12,
                      color: AppColors.greenColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.otp,
                      style: TextStyle(
                        color: AppColors.greenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: AppFonts.popinsBold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: isSmall ? 16 : 22),

          // Pinput with shake
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
                return Center(
                  child: Pinput(
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
                    separatorBuilder: (index) => const SizedBox(width: 6),
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 20,
                          height: 2.5,
                          decoration: BoxDecoration(
                            color: const Color(0xFF34A853),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    onChanged: (value) => _bloc.add(OtpChanged(value)),
                    onCompleted: (value) {
                      _bloc.add(OtpChanged(value));
                      _bloc.add(SubmitLoginOtp());
                    },
                  ),
                );
              },
            ),
          ),

          SizedBox(height: isSmall ? 12 : 16),

          // Helper text
          Center(
            child: Text(
              'Enter the code sent to your phone',
              style: TextStyle(
                fontSize: 12,
                fontFamily: AppFonts.popins,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── TIMER CARD ──────────────────────────────────────────────────────────────

  Widget _buildTimerCard() {
    return BlocBuilder<LoginVerifyOtpBloc, LoginVerifyOtpState>(
      buildWhen: (current, previous) =>
          current.remainingSeconds != previous.remainingSeconds ||
          current.isResendEnabled != previous.isResendEnabled,
      builder: (context, state) {
        final isExpired = state.isResendEnabled;
        final isWarning = state.remainingSeconds < 10 && !isExpired;

        // Colors based on state
        final bgColor = isExpired
            ? Colors.orange.shade50
            : isWarning
            ? Colors.red.shade50
            : const Color(0xFFEFFAF3);
        final borderColor = isExpired
            ? Colors.orange.shade200
            : isWarning
            ? Colors.red.shade200
            : Colors.green.shade100;
        final iconColor = isExpired
            ? Colors.orange.shade600
            : isWarning
            ? Colors.red.shade600
            : const Color(0xFF34A853);
        final textColor = isExpired
            ? Colors.orange.shade700
            : isWarning
            ? Colors.red.shade700
            : const Color(0xFF2E7D52);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: iconColor.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Animated icon container
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isExpired ? Icons.timer_off_outlined : Icons.timer_outlined,
                  color: iconColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isExpired ? 'OTP has expired' : 'Time remaining',
                  style: TextStyle(
                    color: textColor,
                    fontFamily: AppFonts.popins,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              if (!isExpired)
                // Countdown pill
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isWarning
                          ? Colors.red.shade300
                          : Colors.green.shade200,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: iconColor.withOpacity(0.10),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '00:${state.remainingSeconds.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: isWarning
                          ? Colors.red.shade700
                          : const Color(0xFF34A853),
                      fontFamily: AppFonts.popinsBold,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1.5,
                    ),
                  ),
                )
              else
                // Expired label
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Expired',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontFamily: AppFonts.popinsBold,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // ── VERIFY BUTTON ───────────────────────────────────────────────────────────

  Widget _buildVerifyButton(Size size) {
    return BlocBuilder<LoginVerifyOtpBloc, LoginVerifyOtpState>(
      buildWhen: (current, previous) =>
          current.postApiStatus != previous.postApiStatus ||
          current.otp != previous.otp,
      builder: (context, state) {
        final isLoading = state.postApiStatus == PostApiStatus.loading;
        final isComplete = state.otp.length == 6;
        final isActive = isComplete && !isLoading;

        return GestureDetector(
          onTap: isActive ? () => _bloc.add(SubmitLoginOtp()) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: double.infinity,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: isActive
                  ? const LinearGradient(
                      colors: [Color(0xFF34A853), Color(0xFF1A7A38)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [Colors.grey.shade200, Colors.grey.shade300],
                    ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: const Color(0xFF34A853).withOpacity(0.38),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Verifying...',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.popinsBold,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
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
                            color: isActive
                                ? Colors.white
                                : Colors.grey.shade400,
                            letterSpacing: 0.4,
                          ),
                        ),
                        if (isActive) ...[
                          const SizedBox(width: 10),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.22),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified_rounded,
                              color: Colors.white,
                              size: 17,
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  // ── RESEND SECTION ──────────────────────────────────────────────────────────

  Widget _buildResendSection() {
    return BlocBuilder<LoginVerifyOtpBloc, LoginVerifyOtpState>(
      buildWhen: (current, previous) =>
          current.isResendEnabled != previous.isResendEnabled ||
          current.resendPostApiStatus != previous.resendPostApiStatus,
      builder: (context, state) {
        final isLoading =
            state.resendPostApiStatus == ResendPostApiStatus.loading;
        final isEnabled = state.isResendEnabled && !isLoading;

        return Column(
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
                      ? const Color(0xFF34A853).withOpacity(0.07)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isEnabled
                        ? const Color(0xFF34A853).withOpacity(0.5)
                        : Colors.grey.shade200,
                    width: 1.5,
                  ),
                  boxShadow: isEnabled
                      ? [
                          BoxShadow(
                            color: const Color(0xFF34A853).withOpacity(0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
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
                            const Color(0xFF34A853),
                          ),
                        ),
                      )
                    else
                      Icon(
                        Icons.refresh_rounded,
                        size: 17,
                        color: isEnabled
                            ? const Color(0xFF34A853)
                            : Colors.grey.shade400,
                      ),
                    const SizedBox(width: 8),
                    Text(
                      isLoading ? 'Resending...' : 'Resend OTP',
                      style: TextStyle(
                        color: isEnabled
                            ? const Color(0xFF34A853)
                            : Colors.grey.shade400,
                        fontFamily: AppFonts.popinsBold,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
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
}

// ── PAINTERS ─────────────────────────────────────────────────────────────────

class _LeafPainter extends CustomPainter {
  final Color color;
  _LeafPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(
      size.width,
      size.height / 2,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(0, size.height / 2, size.width / 2, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_LeafPainter old) => old.color != color;
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF34A853).withOpacity(0.05)
      ..style = PaintingStyle.fill;
    const spacing = 28.0;
    final cols = (size.width / spacing).ceil();
    final rows = (size.height / spacing).ceil();
    for (int i = 0; i <= cols; i++) {
      for (int j = 0; j <= rows; j++) {
        canvas.drawCircle(
          Offset(i * spacing.toDouble(), j * spacing.toDouble()),
          1.4,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_DotGridPainter old) => false;
}
