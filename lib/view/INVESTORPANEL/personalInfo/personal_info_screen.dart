import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:digifarmer/res/customeWidgets/custom_textfield.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/personalInfo/personal_info_bloc.dart';
import '../../../repository/personalInfo/personal_info_repository.dart';
import '../../../res/color/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/flush_bar_helper.dart';

class PersonalInfoScreen extends StatefulWidget {
  final String uniqueKey;

  const PersonalInfoScreen({super.key, required this.uniqueKey});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late final PersonalInfoBloc _personalInfoBloc;

  // Controllers
  final _fullNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _panController = TextEditingController();
  final _aadharController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pinCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _personalInfoBloc = PersonalInfoBloc(getIt<PersonalInfoRepository>());
    _personalInfoBloc.add(SetUniqueKey(widget.uniqueKey));
  }

  @override
  void dispose() {
    _personalInfoBloc.close();
    _fullNameController.dispose();
    _dobController.dispose();
    _panController.dispose();
    _aadharController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _dobController.text =
          "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _personalInfoBloc,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: const CustomAppBar(
          title: 'Personal Details',
          automaticallyImplyLeading: true,
        ),
        body: BlocListener<PersonalInfoBloc, PersonalInfoState>(
          listenWhen: (c, p) => c.postApiStatus != p.postApiStatus,
          listener: (context, state) {
            if (state.postApiStatus == PostApiStatus.error) {
              FlushBarHelper.flushBarErrorMessage(state.message, context);
            }

            if (state.postApiStatus == PostApiStatus.success) {
              FlushBarHelper.flushBarSuccessMessage(state.message, context);
              Navigator.pushNamed(context, RoutesName.userLoginScreen);
            }
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Full Name', isRequired: true),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _fullNameController,
                    hintText: 'Enter full name',
                    prefixIcon: Icons.person_outline,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Full name required' : null,
                  ),

                  const SizedBox(height: 20),

                  _buildLabel('Date of Birth', isRequired: true),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _dobController,
                    hintText: 'DD/MM/YYYY',
                    prefixIcon: Icons.calendar_today_outlined,
                    readOnly: true,
                    onTap: _selectDate,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'DOB required' : null,
                  ),

                  const SizedBox(height: 20),

                  _buildLabel('PAN Number', isRequired: true),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _panController,
                    hintText: 'ABCDE1234F',
                    prefixIcon: Icons.credit_card_outlined,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (v) =>
                        v == null || v.length != 10 ? 'Enter valid PAN' : null,
                  ),

                  const SizedBox(height: 20),

                  _buildLabel('Aadhar Number', isRequired: true),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _aadharController,
                    hintText: '1234 5678 9012',
                    prefixIcon: Icons.numbers_outlined,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12),
                      _AadharInputFormatter(),
                    ],
                    validator: (v) =>
                        v == null || v.replaceAll(' ', '').length != 12
                        ? 'Enter valid Aadhar'
                        : null,
                  ),

                  const SizedBox(height: 20),

                  _buildLabel('Address', isRequired: true),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _addressController,
                    hintText: 'House/Street/Landmark',
                    maxLines: 3,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Address required' : null,
                  ),

                  const SizedBox(height: 20),

                  _buildLabel('City', isRequired: true),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _cityController,
                    hintText: 'Enter city',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'City required' : null,
                  ),

                  const SizedBox(height: 20),

                  _buildLabel('State', isRequired: true),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _stateController,
                    hintText: 'Enter state',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'State required' : null,
                  ),

                  const SizedBox(height: 20),

                  _buildLabel('PIN Code', isRequired: true),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _pinCodeController,
                    hintText: '6-digit PIN',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    validator: (v) =>
                        v == null || v.length != 6 ? 'Enter valid PIN' : null,
                  ),

                  const SizedBox(height: 30),

                  BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
                    buildWhen: (c, p) => c.postApiStatus != p.postApiStatus,
                    builder: (context, state) {
                      return RoundButton(
                        width: double.infinity,
                        buttonColor: AppColors.greenColor,
                        title: state.postApiStatus == PostApiStatus.loading
                            ? "Please wait..."
                            : "Save & Continue",
                        onPress: state.postApiStatus == PostApiStatus.loading
                            ? null
                            : _submitForm,
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

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final parts = _dobController.text.split('/');
    final formattedDob = "${parts[2]}-${parts[1]}-${parts[0]}";

    _personalInfoBloc.add(FullNameChanged(_fullNameController.text.trim()));
    _personalInfoBloc.add(DobChanged(formattedDob));
    _personalInfoBloc.add(PanChanged(_panController.text.trim()));
    _personalInfoBloc.add(
      AadhaarChanged(_aadharController.text.replaceAll(' ', '')),
    );
    _personalInfoBloc.add(
      AddressChanged(
        houseNumber: _addressController.text.trim(),
        street: "",
        area: "",
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        pinCode: _pinCodeController.text.trim(),
      ),
    );

    _personalInfoBloc.add(SubmitPersonalInfo());
  }
}

class _AadharInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 3 || i == 7) {
        buffer.write(' ');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
