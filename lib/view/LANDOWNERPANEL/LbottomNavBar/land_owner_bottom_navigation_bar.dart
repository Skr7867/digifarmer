import 'package:digifarmer/view/LANDOWNERPANEL/landStatus/land_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import '../../../blocs/LANDOWNERPANEL/landStatus/land_status_bloc.dart';
import '../../../main.dart';
import '../../../utils/enums.dart';
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
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    final landStatusBloc = getIt<LandStatusBloc>();
    final userProfileBloc = getIt<UserProfileBloc>();
    if (landStatusBloc.state.landStatus.status != Status.completed) {
      landStatusBloc.add(const LandStatusFetched());
    }
    if (userProfileBloc.state.userProfile.status != Status.completed) {
      userProfileBloc.add(UserProfileFetched());
    }

    // ✅ Screens created ONCE — blocs injected via .value (no new instances)
    screens = [
      MultiBlocProvider(
        providers: [
          BlocProvider<LandStatusBloc>.value(value: landStatusBloc),
          BlocProvider<UserProfileBloc>.value(value: userProfileBloc),
        ],
        child: const LandOwnerHomeScreen(),
      ),
      BlocProvider<LandStatusBloc>.value(
        value: landStatusBloc,
        child: const MyLandsScreen(),
      ),
      const LandStatusScreen(),
      BlocProvider<UserProfileBloc>.value(
        value: userProfileBloc,
        child: const ProfileScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          setState(() => currentIndex = 0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(index: currentIndex, children: screens),
        bottomNavigationBar: LandOwnerCustomNavBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
        ),
      ),
    );
  }
}
