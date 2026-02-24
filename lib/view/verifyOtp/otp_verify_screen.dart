import 'dart:async';

import 'package:digifarmer/blocs/verifyOtp/verify_otp_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/color/app_colors.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../../repository/verifyOtp/verify_otp_repository.dart';

class OtpVerificationScreen extends StatefulWidget {
  // ✅ Constructor se directly lo
  final String uniqueKey;
  final String otp;

  const OtpVerificationScreen({
    super.key,
    required this.uniqueKey,
    required this.otp,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int seconds = 29;
  Timer? timer;
  late final VerifyOtpBloc _verifyOtpBloc;

  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _verifyOtpBloc = VerifyOtpBloc(getIt<VerifyOtpRepository>());
    startTimer();

    // ✅ widget.uniqueKey guaranteed available — no timing issue
    print('DEBUG uniqueKey from widget: ${widget.uniqueKey}');
    print('DEBUG otp from widget: ${widget.otp}');
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  String get _enteredOtp => _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    timer?.cancel();
    _verifyOtpBloc.close();
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  Widget _otpBox(int index) {
    return SizedBox(
      width: 48,
      height: 55,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.popins,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xffF2F4F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.greenColor, width: 1.5),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 5) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
            }
          } else {
            if (index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          }
          _verifyOtpBloc.add(OtpChanged(otp: _enteredOtp));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _verifyOtpBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocListener<VerifyOtpBloc, VerifyOtpState>(
            listenWhen: (current, previous) =>
                current.postApiStatus != previous.postApiStatus,
            listener: (context, state) {
              if (state.postApiStatus == PostApiStatus.error) {
                FlushBarHelper.flushBarErrorMessage(state.message, context);
              }
              if (state.postApiStatus == PostApiStatus.sucess) {
                FlushBarHelper.flushBarSuccessMessage(state.message, context);
                Navigator.pushNamed(context, RoutesName.chooseRoleScreen);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  /// Back Button
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xffF2F4F7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// ✅ OTP from widget directly
                  if (widget.otp.isNotEmpty)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.greenColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.greenColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lock_open_outlined,
                              size: 18,
                              color: AppColors.greenColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Your OTP: ${widget.otp}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppFonts.popinsBold,
                                color: AppColors.greenColor,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      "Enter Verification Code",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1D2939),
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Center(
                    child: Text(
                      "We've sent a 6-digit code to your mobile",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff667085),
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// OTP Boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) => _otpBox(index)),
                  ),

                  const SizedBox(height: 60),

                  /// Resend Timer
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                          color: Color(0xff98A2B3),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Resend code in ",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                        Text(
                          "0:${seconds.toString().padLeft(2, '0')}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: GestureDetector(
                      onTap: seconds == 0
                          ? () {
                              setState(() => seconds = 29);
                              startTimer();
                            }
                          : null,
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: seconds == 0
                              ? AppColors.greenColor
                              : const Color(0xff98A2B3),
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  /// ✅ Verify Button — widget.uniqueKey directly pass
                  BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
                    buildWhen: (current, previous) =>
                        current.postApiStatus != previous.postApiStatus,
                    builder: (context, state) {
                      return RoundButton(
                        width: double.infinity,
                        buttonColor: AppColors.greenColor,
                        title: state.postApiStatus == PostApiStatus.loading
                            ? 'Please wait...'
                            : 'Verify & Continue',
                        onPress: () {
                          print('DEBUG uniqueKey: ${widget.uniqueKey}');
                          print('DEBUG otp entered: $_enteredOtp');
                          _verifyOtpBloc.add(
                            VerifyOtp(uniqueKey: widget.uniqueKey),
                          );
                        },
                      );
                    },
                  ),

                  const Spacer(),

                  /// Bottom Help
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Didn't receive the code?",
                          style: TextStyle(
                            color: Color(0xff98A2B3),
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.call,
                              size: 18,
                              color: Color(0xff155EEF),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Call Support",
                              style: TextStyle(
                                color: Color(0xff155EEF),
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.popins,
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.mail,
                              size: 18,
                              color: Color(0xff155EEF),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Email Help",
                              style: TextStyle(
                                color: Color(0xff155EEF),
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.popins,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
