import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/INVESTORPANEL/login/user_login_bloc.dart';
import '../../../config/routes/routes_name.dart';
import '../../../main.dart';
import '../../../repository/INVESTORPANEL/userLogin/user_login_repository.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/customeWidgets/custom_textfield.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/enums.dart';
import '../../../utils/flush_bar_helper.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _mobileFocusNode = FocusNode();

  late final LoginBloc _loginBloc;

  // Animation controllers
  late AnimationController _heroController;
  late AnimationController _cardController;
  late AnimationController _floatingController;
  late AnimationController _pulseController;

  late Animation<double> _heroScale;
  late Animation<double> _heroOpacity;
  late Animation<Offset> _cardSlide;
  late Animation<double> _cardOpacity;
  late Animation<double> _floatingAnim;
  late Animation<double> _pulseAnim;

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(getIt<UserLoginRepository>());
    _initAnimations();

    _mobileFocusNode.addListener(() {
      setState(() => _isFocused = _mobileFocusNode.hasFocus);
    });
  }

  void _initAnimations() {
    // Hero logo animation
    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _heroScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.easeOutBack),
    );
    _heroOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _heroController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Card slide up
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic),
        );
    _cardOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );

    // Floating leaves / shapes
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _floatingAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    // Pulse on logo ring
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Stagger: hero first, then card
    _heroController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _cardController.forward();
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _mobileFocusNode.dispose();
    _loginBloc.close();
    _heroController.dispose();
    _cardController.dispose();
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _loginBloc,
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
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
          child: Stack(
            children: [
              // ── Background ──────────────────────────────────────────
              _buildBackground(size),

              // ── Floating decorative elements ─────────────────────────
              _buildFloatingElements(size),

              // ── Main content ─────────────────────────────────────────
              SafeArea(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.06),
                          _buildHeroSection(size),
                          SizedBox(height: size.height * 0.05),
                          _buildFormCard(),
                          const SizedBox(height: 20),
                          _buildCreateAccountRow(),
                          const SizedBox(height: 32),
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
    );
  }

  // ── BACKGROUND ──────────────────────────────────────────────────────────────

  Widget _buildBackground(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF0FAF4), Color(0xFFE8F5E9), Color(0xFFFFFFFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.4, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Top-right arc blob
          Positioned(
            top: -size.height * 0.08,
            right: -size.width * 0.2,
            child: Container(
              width: size.width * 0.7,
              height: size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF34A853).withOpacity(0.18),
                    const Color(0xFF34A853).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          // Bottom-left arc blob
          Positioned(
            bottom: -size.height * 0.05,
            left: -size.width * 0.15,
            child: Container(
              width: size.width * 0.55,
              height: size.width * 0.55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF0D47A1).withOpacity(0.10),
                    const Color(0xFF0D47A1).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          // Subtle grid texture
          CustomPaint(
            size: Size(size.width, size.height),
            painter: _DotGridPainter(),
          ),
        ],
      ),
    );
  }

  // ── FLOATING ELEMENTS ───────────────────────────────────────────────────────

  Widget _buildFloatingElements(Size size) {
    return AnimatedBuilder(
      animation: _floatingAnim,
      builder: (context, _) {
        return Stack(
          children: [
            // Leaf shape 1
            Positioned(
              top: size.height * 0.12 + (_floatingAnim.value * 12),
              left: 20,
              child: _FloatingLeaf(
                size: 28,
                rotation: 0.4 + (_floatingAnim.value * 0.2),
                color: const Color(0xFF34A853).withOpacity(0.25),
              ),
            ),
            // Leaf shape 2
            Positioned(
              top: size.height * 0.18 - (_floatingAnim.value * 8),
              right: 28,
              child: _FloatingLeaf(
                size: 20,
                rotation: -0.6 + (_floatingAnim.value * 0.15),
                color: const Color(0xFF0D47A1).withOpacity(0.18),
              ),
            ),
            // Small circle
            Positioned(
              top: size.height * 0.08 + (_floatingAnim.value * 6),
              right: size.width * 0.3,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF34A853).withOpacity(0.3),
                ),
              ),
            ),
            // Tiny diamond
            Positioned(
              top: size.height * 0.28 - (_floatingAnim.value * 10),
              left: size.width * 0.25,
              child: Transform.rotate(
                angle: 0.785 + (_floatingAnim.value * 0.3),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withOpacity(0.15),
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

  // ── HERO SECTION ─────────────────────────────────────────────────────────────

  Widget _buildHeroSection(Size size) {
    return AnimatedBuilder(
      animation: Listenable.merge([_heroController, _pulseController]),
      builder: (context, _) {
        return FadeTransition(
          opacity: _heroOpacity,
          child: ScaleTransition(
            scale: _heroScale,
            child: Column(
              children: [
                // Logo with pulse ring
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer pulse ring
                    Transform.scale(
                      scale: _pulseAnim.value,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFF34A853).withOpacity(0.12),
                              const Color(0xFF34A853).withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Logo container
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF34A853).withOpacity(0.22),
                            blurRadius: 28,
                            offset: const Offset(0, 8),
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            blurRadius: 12,
                            offset: const Offset(-4, -4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Image.asset(
                          ImageAssets.splashLogo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Welcome text
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome\n',
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: AppFonts.popinsBold,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A2E1A),
                          height: 1.1,
                          letterSpacing: -1.0,
                        ),
                      ),
                      TextSpan(
                        text: 'Back!',
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: AppFonts.popinsBold,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF34A853),
                          height: 1.1,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Login or create an account to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: AppFonts.popins,
                    color: Colors.grey.shade500,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── FORM CARD ────────────────────────────────────────────────────────────────

  Widget _buildFormCard() {
    return SlideTransition(
      position: _cardSlide,
      child: FadeTransition(
        opacity: _cardOpacity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF34A853).withOpacity(0.10),
                blurRadius: 40,
                offset: const Offset(0, 16),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card header
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 22,
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
                        'Sign In',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFonts.popinsBold,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A2E1A),
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Enter your mobile number to receive OTP',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontFamily: AppFonts.popins,
                      color: Colors.grey.shade400,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Mobile label
                  Text(
                    'Mobile Number',
                    style: TextStyle(
                      color: const Color(0xFF1A2E1A),
                      fontSize: 13,
                      fontFamily: AppFonts.popinsBold,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Custom styled text field wrapper
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: _isFocused
                          ? [
                              BoxShadow(
                                color: const Color(
                                  0xFF34A853,
                                ).withOpacity(0.18),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                    ),
                    child: CustomTextField(
                      controller: _mobileController,
                      focusNode: _mobileFocusNode,
                      maxLength: 10,
                      fillColor: _isFocused
                          ? const Color(0xFFF0FAF4)
                          : Colors.grey.shade50,
                      prefixIcon: Icons.phone_outlined,
                      hintText: 'Enter your mobile number',
                      keyboardType: TextInputType.phone,
                      borderColor: _isFocused
                          ? const Color(0xFF34A853)
                          : Colors.grey.shade200,
                      validator: _validateMobileNumber,
                      onChanged: (value) {
                        _loginBloc.add(MobileNumberChanged(value));
                      },
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Send OTP button
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (current, previous) =>
                        current.postApiStatus != previous.postApiStatus,
                    builder: (context, state) {
                      final isLoading =
                          state.postApiStatus == PostApiStatus.loading;
                      return _SendOtpButton(
                        isLoading: isLoading,
                        onTap: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _loginBloc.add(SubmitLogin());
                                }
                              },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── CREATE ACCOUNT ROW ───────────────────────────────────────────────────────

  Widget _buildCreateAccountRow() {
    return SlideTransition(
      position: _cardSlide,
      child: FadeTransition(
        opacity: _cardOpacity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontFamily: AppFonts.popins,
                fontSize: 13,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.userRegisterScreen);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Create one',
                style: TextStyle(
                  color: const Color(0xFF34A853),
                  fontFamily: AppFonts.popinsBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF34A853),
                ),
              ),
            ),
          ],
        ),
      ),
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

// ── SEND OTP BUTTON ─────────────────────────────────────────────────────────────

class _SendOtpButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onTap;

  const _SendOtpButton({required this.isLoading, required this.onTap});

  @override
  State<_SendOtpButton> createState() => _SendOtpButtonState();
}

class _SendOtpButtonState extends State<_SendOtpButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _pressController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressController.forward(),
      onTapUp: (_) => _pressController.reverse(),
      onTapCancel: () => _pressController.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: widget.isLoading
                ? LinearGradient(
                    colors: [Colors.grey.shade300, Colors.grey.shade300],
                  )
                : const LinearGradient(
                    colors: [Color(0xFF34A853), Color(0xFF1B8C3A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            boxShadow: widget.isLoading
                ? []
                : [
                    BoxShadow(
                      color: const Color(0xFF34A853).withOpacity(0.40),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Center(
            child: widget.isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Please wait...',
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
                        'Send OTP',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.popinsBold,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// ── FLOATING LEAF ────────────────────────────────────────────────────────────

class _FloatingLeaf extends StatelessWidget {
  final double size;
  final double rotation;
  final Color color;

  const _FloatingLeaf({
    required this.size,
    required this.rotation,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: CustomPaint(
        size: Size(size, size),
        painter: _LeafPainter(color: color),
      ),
    );
  }
}

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
  bool shouldRepaint(_LeafPainter oldDelegate) => oldDelegate.color != color;
}

// ── DOT GRID PAINTER ─────────────────────────────────────────────────────────

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF34A853).withOpacity(0.055)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.fill;

    const spacing = 28.0;
    final cols = (size.width / spacing).ceil();
    final rows = (size.height / spacing).ceil();

    for (int i = 0; i <= cols; i++) {
      for (int j = 0; j <= rows; j++) {
        canvas.drawCircle(Offset(i * spacing, j * spacing), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotGridPainter oldDelegate) => false;
}
