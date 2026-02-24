import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Explore'),

      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [Text('Explore')],
      ),
    );
  }
}
