import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Wallet screen'),
      body: Center(child: Column(children: [Text('Wallet')])),
    );
  }
}
