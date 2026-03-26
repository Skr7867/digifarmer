import 'package:digifarmer/view/LANDOWNERPANEL/landStatus/land_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import '../../../blocs/LANDOWNERPANEL/landStatus/land_status_bloc.dart';
import '../../../main.dart';
import '../../../repository/INVESTORPANEL/userProfile/user_profile_http_repository.dart';
import '../../INVESTORPANEL/profile/profile_screen.dart';
import '../homeScreen/land_owner_home_screen.dart';
import '../myLands/my_lands_screen.dart';
import 'land_owner_custom_nav_bar.dart';

class LandOwnerBottomNavigationBar extends StatefulWidget {
  const LandOwnerBottomNavigationBar({super.key});

  @override
  State<LandOwnerBottomNavigationBar> createState() =>
      _LandOwnerBottomNavigationBarState();
}

class _LandOwnerBottomNavigationBarState
    extends State<LandOwnerBottomNavigationBar> {
  int currentIndex = 0;

  final List<Widget> screens = [
    /// HOME — needs both LandStatusBloc + UserProfileBloc
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LandStatusBloc(landStatusRepository: getIt())
                ..add(LandStatusFetched()),
        ),
        BlocProvider(
          create: (context) => UserProfileBloc(
            userProfileRepository: UserProfileHttpRepository(),
          ),
        ),
      ],
      child: const LandOwnerHomeScreen(),
    ),

    /// MY LANDS — unchanged
    BlocProvider(
      create: (context) =>
          LandStatusBloc(landStatusRepository: getIt())
            ..add(LandStatusFetched()),
      child: MyLandsScreen(),
    ),

    /// LAND STATUS — unchanged
    const LandStatusScreen(),

    /// PROFILE — unchanged
    BlocProvider(
      create: (context) =>
          UserProfileBloc(userProfileRepository: UserProfileHttpRepository()),
      child: const ProfileScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          setState(() {
            currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(index: currentIndex, children: screens),
        bottomNavigationBar: LandOwnerCustomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
