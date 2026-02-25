import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/loginOtpVerify/login_otp_verify_bloc.dart';
import '../../main.dart';
import '../../repository/loginOtpVerify/login_otp_verify_repository.dart';
import '../../utils/enums.dart';

class UserLoginVerifyOtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String uniqueKey;

  const UserLoginVerifyOtpScreen({
    super.key,
    required this.mobileNumber,
    required this.uniqueKey,
  });

  @override
  State<UserLoginVerifyOtpScreen> createState() =>
      _UserLoginVerifyOtpScreenState();
}

class _UserLoginVerifyOtpScreenState extends State<UserLoginVerifyOtpScreen> {
  late final LoginVerifyOtpBloc _bloc;

  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();

    _bloc = LoginVerifyOtpBloc(getIt<LoginOtpVerifyRepository>());

    /// Set unique key once
    _bloc.add(SetUniqueKey(widget.uniqueKey));
  }

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    _bloc.close();
    super.dispose();
  }

  String get _enteredOtp => _otpControllers.map((e) => e.text).join();

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _otpFocusNodes[index + 1].requestFocus();
    }

    _bloc.add(OtpChanged(_enteredOtp));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: BlocListener<LoginVerifyOtpBloc, LoginVerifyOtpState>(
            listenWhen: (current, previous) =>
                current.postApiStatus != previous.postApiStatus,
            listener: (context, state) {
              if (state.postApiStatus == PostApiStatus.error) {
                _showSnackBar(state.message, isError: true);
              }

              if (state.postApiStatus == PostApiStatus.success) {
                _showSnackBar(state.message, isError: false);

                /// Navigate to home
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.bottomNavBar,
                  (route) => false,
                );
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildOtpInput(),
                  const SizedBox(height: 40),
                  _buildVerifyButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Verify Your Mobile Number",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "Code sent to +91 ${widget.mobileNumber}",
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 48,
          child: TextField(
            controller: _otpControllers[index],
            focusNode: _otpFocusNodes[index],
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(counterText: ''),
            onChanged: (value) => _onOtpChanged(index, value),
          ),
        );
      }),
    );
  }

  /// 🔥 Only this button rebuilds
  Widget _buildVerifyButton() {
    return BlocBuilder<LoginVerifyOtpBloc, LoginVerifyOtpState>(
      buildWhen: (current, previous) =>
          current.postApiStatus != previous.postApiStatus,
      builder: (context, state) {
        final isLoading = state.postApiStatus == PostApiStatus.loading;

        return SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    if (_enteredOtp.length != 6) {
                      _showSnackBar("Enter complete OTP", isError: true);
                      return;
                    }

                    _bloc.add(SubmitLoginOtp());
                  },
            child: isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text("Verify OTP", style: TextStyle(fontSize: 16)),
          ),
        );
      },
    );
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
}
