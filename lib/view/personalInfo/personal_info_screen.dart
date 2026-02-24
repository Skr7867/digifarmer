import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:digifarmer/res/customeWidgets/custom_textfield.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../res/color/app_colors.dart';
import '../../res/fonts/app_fonts.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  // Focus Nodes
  final FocusNode _fullNameFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _panFocus = FocusNode();
  final FocusNode _aadharFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _pinCodeFocus = FocusNode();

  @override
  void dispose() {
    // Dispose controllers
    _fullNameController.dispose();
    _dobController.dispose();
    _panController.dispose();
    _aadharController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();

    // Dispose focus nodes
    _fullNameFocus.dispose();
    _dobFocus.dispose();
    _panFocus.dispose();
    _aadharFocus.dispose();
    _addressFocus.dispose();
    _cityFocus.dispose();
    _stateFocus.dispose();
    _pinCodeFocus.dispose();
    super.dispose();
  }

  // Date Picker Function
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.greenColor,
              onPrimary: Colors.white,
              onSurface: AppColors.blackColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text =
            "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: 'Personal Details',
        automaticallyImplyLeading: true,
        actions: [
          // Help Icon
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {
                _showHelpDialog(context);
              },
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section with Progress
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.greenColor.withOpacity(0.1),
                        AppColors.whiteColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.greenColor.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.verified_user,
                              color: AppColors.greenColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Identity Verification',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppFonts.popinsBold,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Step 2 of 5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.greyColor,
                                    fontFamily: AppFonts.popins,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Progress Indicator
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '40%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: 0.4,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.greenColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Title Section
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: AppFonts.popinsBold,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please provide your personal information for identity verification',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.greyColor,
                    fontFamily: AppFonts.popins,
                  ),
                ),

                const SizedBox(height: 24),

                // Form Fields
                _buildLabel('Full Name', isRequired: true),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _fullNameController,
                  focusNode: _fullNameFocus,
                  borderRadius: 12,
                  prefixIcon: Icons.person_outline,
                  hintText: 'Enter your full name as per ID',
                  fontSize: 14,

                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_dobFocus);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full name is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildLabel('Date of Birth', isRequired: true),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _dobController,
                  focusNode: _dobFocus,
                  borderRadius: 12,
                  prefixIcon: Icons.calendar_today_outlined,
                  hintText: 'DD/MM/YYYY',
                  fontSize: 14,
                  readOnly: true,
                  onTap: _selectDate,
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.greyColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Date of birth is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildLabel('PAN Number', isRequired: true),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _panController,
                  focusNode: _panFocus,
                  borderRadius: 12,
                  prefixIcon: Icons.credit_card_outlined,
                  hintText: 'ABCDE1234F',
                  fontSize: 14,

                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_aadharFocus);
                  },

                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'PAN number is required';
                    } else if (value.length != 10) {
                      return 'PAN number must be 10 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildLabel('Aadhar Number', isRequired: true),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _aadharController,
                  focusNode: _aadharFocus,
                  borderRadius: 12,
                  prefixIcon: Icons.numbers_outlined,
                  hintText: '1234 4567 9012',
                  fontSize: 14,
                  keyboardType: TextInputType.number,

                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_addressFocus);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                    _AadharInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Aadhar number is required';
                    } else if (value.replaceAll(' ', '').length != 12) {
                      return 'Aadhar number must be 12 digits';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildLabel('Complete Address', isRequired: true),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _addressController,
                  focusNode: _addressFocus,
                  borderRadius: 12,
                  height: 100,
                  maxLines: 3,
                  prefixIcon: Icons.location_on_outlined,
                  hintText: 'House/Flat No, Street, Area, Landmark',
                  fontSize: 14,

                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_cityFocus);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // City and State Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// City
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('City', isRequired: true),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _cityController,
                            focusNode: _cityFocus,
                            borderRadius: 12,
                            hintText: 'Enter city',
                            fontSize: 14,

                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_stateFocus);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'City is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// State
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('State', isRequired: true),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _stateController,
                            focusNode: _stateFocus,
                            borderRadius: 12,
                            hintText: 'Select state',
                            fontSize: 14,
                            readOnly: true,
                            onTap: _showStateSelector,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.greyColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'State is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// PIN Code
                _buildLabel('PIN Code', isRequired: true),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _pinCodeController,
                  focusNode: _pinCodeFocus,
                  borderRadius: 12,
                  prefixIcon: Icons.markunread_mailbox_outlined,
                  hintText: 'Enter 6-digit PIN code',
                  fontSize: 14,
                  keyboardType: TextInputType.number,

                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'PIN code is required';
                    } else if (value.length != 6) {
                      return 'PIN code must be 6 digits';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    _submitForm();
                  },
                ),

                const SizedBox(height: 24),

                /// Secure Info Card with Animation
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xffE6F4EC), Color(0xffEAF3F0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.greenColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        /// Shield Icon with glow effect
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.greenColor.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.shield_outlined,
                            color: AppColors.greenColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),

                        /// Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "🔒 Secure & Encrypted",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppFonts.popinsBold,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "All information is encrypted and stored securely as per RBI guidelines.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.greyColor,
                                  fontFamily: AppFonts.popins,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _clearForm();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.greyColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontFamily: AppFonts.popins,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RoundButton(
                        width: double.infinity,
                        buttonColor: AppColors.greenColor,
                        title: 'Save & Continue',
                        onPress: _submitForm,
                        height: 40,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Terms and Conditions
                Center(
                  child: Text(
                    'By continuing, you agree to our Terms & Conditions',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.greyColor,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
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
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.popinsBold,
              color: AppColors.blackColor,
            ),
          ),
          if (isRequired)
            TextSpan(
              text: ' *',
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.popinsBold,
                color: Colors.red.shade400,
              ),
            ),
        ],
      ),
    );
  }

  void _showStateSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select State',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildStateItem('Andhra Pradesh'),
              _buildStateItem('Telangana'),
              _buildStateItem('Tamil Nadu'),
              _buildStateItem('Karnataka'),
              _buildStateItem('Maharashtra'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStateItem(String state) {
    return ListTile(
      title: Text(state),
      onTap: () {
        setState(() {
          _stateController.text = state;
        });
        Navigator.pop(context);
      },
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Need Help?'),
          content: const Text(
            'Make sure to enter your details exactly as they appear on your official documents for successful verification.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    _fullNameController.clear();
    _dobController.clear();
    _panController.clear();
    _aadharController.clear();
    _addressController.clear();
    _cityController.clear();
    _stateController.clear();
    _pinCodeController.clear();
  }

  void _submitForm() {
    Navigator.pushNamed(context, RoutesName.bottomNavBar);

    // if (_formKey.currentState?.validate() ?? false) {
    //   Navigator.pushNamed(context, RoutesName.bottomNavBar);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text('Information saved successfully!'),
    //       backgroundColor: AppColors.greenColor,
    //       behavior: SnackBarBehavior.floating,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ),
    //   );

    //   // Navigate to next screen
    //   // Navigator.push...
    // }
  }
}

// Aadhar Number Formatter
class _AadharInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');

    if (text.isEmpty) {
      return newValue;
    }

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
