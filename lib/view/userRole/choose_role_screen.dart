import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/assets/image_assets.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:flutter/material.dart';

import '../../res/fonts/app_fonts.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  int selectedIndex = -1;

  final List<RoleModel> roles = [
    RoleModel(
      title: "Investor",
      subtitle: "Invest in agricultural projects and track returns",
      icon: Icons.show_chart,
      color: Color(0xff2E5AAC),
    ),
    RoleModel(
      title: "Land Owner",
      subtitle: "List your land and manage farming operations",
      icon: Icons.agriculture,
      color: Color(0xff2F9E5B),
    ),
    RoleModel(
      title: "Worker",
      subtitle: "Find work opportunities and manage tasks",
      icon: Icons.person,
      color: Color(0xff4C8F8F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Logo
              Image.asset(ImageAssets.splashLogo, height: 80, width: 80),

              const SizedBox(height: 20),

              /// Title
              const Text(
                "Choose Your Role",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Select how you'd like to use DigiFarmer",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontFamily: AppFonts.popins,
                ),
              ),

              const SizedBox(height: 30),

              /// Role List
              Expanded(
                child: ListView.builder(
                  itemCount: roles.length,
                  itemBuilder: (context, index) {
                    return roleCard(index);
                  },
                ),
              ),

              RoundButton(
                width: double.infinity,
                buttonColor: selectedIndex == -1
                    ? Colors.grey.shade300
                    : Colors.blue,
                title: 'Continue',
                onPress: () {
                  Navigator.pushNamed(context, RoutesName.personalInfoScreen);
                },
              ),
              SizedBox(height: 20),

              /// Bottom Help
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.info, size: 18, color: Colors.blue),
                  SizedBox(width: 6),
                  Text(
                    "Learn about each role",
                    style: TextStyle(
                      color: Colors.blue,
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
      ),
    );
  }

  /// ✅ Clickable Role Card
  Widget roleCard(int index) {
    final role = roles[index];
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Icon Box
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: role.color,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(role.icon, color: Colors.white),
            ),

            const SizedBox(width: 16),

            /// Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role.subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ],
              ),
            ),

            /// Radio Indicator
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.blue,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ Role Model
class RoleModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  RoleModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
