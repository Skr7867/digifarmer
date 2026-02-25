import 'dart:developer';

import 'package:digifarmer/blocs/chooseRole/choose_role_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/assets/image_assets.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../../repository/chooseRole/choose_role_repository.dart';
import '../../res/fonts/app_fonts.dart';

class ChooseRoleScreen extends StatefulWidget {
  final String uniqueKey;
  const ChooseRoleScreen({super.key, required this.uniqueKey});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  late final ChooseRoleBloc _chooseRoleBloc;

  int selectedIndex = -1;

  final List<RoleModel> roles = [
    RoleModel(
      title: "Investor",
      subtitle: "Invest in agricultural projects and track returns",
      icon: Icons.show_chart,
      color: Color(0xff2E5AAC),
      backendValue: "INVESTOR",
    ),
    RoleModel(
      title: "Land Owner",
      subtitle: "List your land and manage farming operations",
      icon: Icons.agriculture,
      color: Color(0xff2F9E5B),
      backendValue: "LAND_OWNER",
    ),
    RoleModel(
      title: "Worker",
      subtitle: "Find work opportunities and manage tasks",
      icon: Icons.person,
      color: Color(0xff4C8F8F),
      backendValue: "WORKER",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _chooseRoleBloc = ChooseRoleBloc(getIt<ChooseRoleRepository>());
    _chooseRoleBloc.add(SetUniqueKey(widget.uniqueKey));
    log("DEBUG uniqueKey in ChooseRole: ${widget.uniqueKey}");
  }

  @override
  void dispose() {
    _chooseRoleBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chooseRoleBloc,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: BlocListener<ChooseRoleBloc, ChooseRoleState>(
            listenWhen: (current, previous) =>
                current.postApiStatus != previous.postApiStatus,
            listener: (context, state) {
              if (state.postApiStatus == PostApiStatus.error) {
                FlushBarHelper.flushBarErrorMessage(state.message, context);
              }

              if (state.postApiStatus == PostApiStatus.success) {
                FlushBarHelper.flushBarSuccessMessage(state.message, context);

                Navigator.pushNamed(
                  context,
                  RoutesName.personalInfoScreen,
                  arguments: {"uniqueKey": widget.uniqueKey},
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Image.asset(ImageAssets.splashLogo, height: 80, width: 80),

                  const SizedBox(height: 20),

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

                  Expanded(
                    child: ListView.builder(
                      itemCount: roles.length,
                      itemBuilder: (context, index) {
                        return roleCard(index);
                      },
                    ),
                  ),

                  BlocBuilder<ChooseRoleBloc, ChooseRoleState>(
                    builder: (context, state) {
                      return RoundButton(
                        width: double.infinity,
                        buttonColor: selectedIndex == -1
                            ? Colors.grey.shade300
                            : Colors.blue,
                        title: state.postApiStatus == PostApiStatus.loading
                            ? "Please wait..."
                            : "Continue",
                        onPress: selectedIndex == -1
                            ? null
                            : () {
                                _chooseRoleBloc.add(SubmitRole());
                              },
                      );
                    },
                  ),

                  const SizedBox(height: 20),

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
        ),
      ),
    );
  }

  Widget roleCard(int index) {
    final role = roles[index];
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        _chooseRoleBloc.add(SetRole(role.backendValue));
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
        ),
        child: Row(
          children: [
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
          ],
        ),
      ),
    );
  }
}

class RoleModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String backendValue;

  RoleModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.backendValue,
  });
}
