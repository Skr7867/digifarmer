import 'dart:async';

import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/color/app_colors.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int seconds = 29;
  Timer? timer;

  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 48,
      height: 55,
      child: TextField(
        controller: controllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.popins,
        ),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: const Color(0xffF2F4F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              /// Back Button
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
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

              /// Title
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

              /// Subtitle
              const Center(
                child: Text(
                  "We've sent a 6-digit code to",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff667085),
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              /// Phone
              const Center(
                child: Text(
                  "+91 98765 43210",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1D2939),
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => otpBox(index)),
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

              /// Resend OTP Disabled
              const Center(
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                    color: Color(0xff98A2B3),
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),

              const SizedBox(height: 60),

              /// Verify Button
              RoundButton(
                width: double.infinity,
                buttonColor: AppColors.greenColor,
                title: 'Verify  Continue',
                onPress: () {
                  Navigator.pushNamed(context, RoutesName.chooseRoleScreen);
                },
              ),

              const Spacer(),

              /// Bottom Help Section
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
                        Icon(Icons.call, size: 18, color: Color(0xff155EEF)),
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
                        Icon(Icons.mail, size: 18, color: Color(0xff155EEF)),
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
    );
  }
}
