import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:flutter/material.dart';

import '../../../res/color/app_colors.dart';

class AddNewLandScreen extends StatefulWidget {
  const AddNewLandScreen({super.key});

  @override
  State<AddNewLandScreen> createState() => _AddNewLandScreenState();
}

class _AddNewLandScreenState extends State<AddNewLandScreen> {
  bool borewell = false;
  bool canal = false;
  bool openWell = false;
  bool rainwater = false;
  String? selectedState;

  List<String> indianStates = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
  ];

  void _openStateBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: indianStates.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(indianStates[index]),
              onTap: () {
                setState(() {
                  selectedState = indianStates[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7),
      body: Column(
        children: [
          /// HEADER
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xff2FA66A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  "Add New Land",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.map, color: Colors.white),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Register Your Land\nComplete the form to add your property",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Registration Progress",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text("Step 1 of 3", style: TextStyle(color: Colors.white)),
                  ],
                ),

                const SizedBox(height: 6),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 0.33,
                    backgroundColor: Colors.white24,
                    color: Colors.white,
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),

          /// FORM
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// BASIC INFO
                  _sectionCard(
                    title: "Basic Information",
                    children: [
                      _textField("Khasra/Survey Number"),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(child: _textField("Enter area")),
                          const SizedBox(width: 10),
                          Expanded(child: _textField("Acres")),
                        ],
                      ),
                    ],
                  ),

                  /// LOCATION
                  _sectionCard(
                    title: "Location Details",
                    children: [
                      _textField("Village/Town"),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(child: _textField("Tehsil")),
                          const SizedBox(width: 10),
                          Expanded(child: _textField("District")),
                        ],
                      ),

                      const SizedBox(height: 10),

                      _dropdown("Select state"),

                      const SizedBox(height: 10),

                      _textField("PIN Code"),
                    ],
                  ),

                  /// FARMING DETAILS
                  _sectionCard(
                    title: "Farming Details",
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Water Source",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Wrap(
                        spacing: 10,
                        children: [
                          _checkbox("Borewell", borewell, (v) {
                            setState(() => borewell = v!);
                          }),
                          _checkbox("Canal", canal, (v) {
                            setState(() => canal = v!);
                          }),
                          _checkbox("Open Well", openWell, (v) {
                            setState(() => openWell = v!);
                          }),
                          _checkbox("Rainwater", rainwater, (v) {
                            setState(() => rainwater = v!);
                          }),
                        ],
                      ),

                      const SizedBox(height: 10),

                      _textField("Land Description", maxLines: 3),
                    ],
                  ),

                  /// LEASE
                  _sectionCard(
                    title: "Lease Preferences",
                    children: [
                      _textField("Expected Monthly Rent (₹)"),
                      const SizedBox(height: 10),
                      _textField("Select minimum duration"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: RoundButton(
                          buttonColor: AppColors.greyColor,
                          title: 'Save Draft',
                          onPress: () {},
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: RoundButton(
                          buttonColor: AppColors.greenColor,
                          title: 'Continue',
                          onPress: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          ...children,
        ],
      ),
    );
  }

  Widget _textField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xfff7f7f7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dropdown(String hint) {
    return InkWell(
      onTap: _openStateBottomSheet,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xfff7f7f7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedState ?? hint,
              style: TextStyle(
                color: selectedState == null ? Colors.grey : Colors.black,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _checkbox(String text, bool value, Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(text),
      ],
    );
  }
}
