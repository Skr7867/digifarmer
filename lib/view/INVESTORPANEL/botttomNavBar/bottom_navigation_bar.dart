import 'package:digifarmer/blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import 'package:digifarmer/repository/INVESTORPANEL/userProfile/user_profile_http_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_screen.dart';
import '../portfolio/portfolio_screen.dart';
import '../profile/profile_screen.dart';
import '../wallet/wallet_screen.dart';
import 'custom_nav_bar.dart';

class BottomnavBar extends StatefulWidget {
  const BottomnavBar({super.key});

  @override
  State<BottomnavBar> createState() => _BottomnavBarState();
}

class _BottomnavBarState extends State<BottomnavBar> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    PortfolioScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserProfileBloc(
            userProfileRepository: UserProfileHttpRepository(),
          ),
        ),
        // add your other blocs here if needed
      ],
      child: WillPopScope(
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
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
