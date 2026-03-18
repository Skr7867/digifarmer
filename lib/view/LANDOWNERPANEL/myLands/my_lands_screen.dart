import 'package:digifarmer/res/color/app_colors.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/LANDOWNERPANEL/landStatus/land_status_bloc.dart';
import '../../../model/LANDOWNERSPANEL/landOwnerTimeLine/land_owner_timeline_model.dart';
import '../../../utils/enums.dart';

class MyLandsScreen extends StatelessWidget {
  const MyLandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My All Lands',
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      backgroundColor: const Color(0xffF5F6FA),
      body: BlocBuilder<LandStatusBloc, LandStatusState>(
        builder: (context, state) {
          switch (state.landStatus.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());

            case Status.error:
              return Center(
                child: Text(state.landStatus.message ?? "Something went wrong"),
              );

            case Status.completed:
              final lands = state.landStatus.data!.data.lands;

              final activeCount = lands
                  .where((e) => e.status == "DOC_VERIFIED")
                  .length;

              final pendingCount = lands
                  .where((e) => e.status == "PENDING")
                  .length;

              return _buildHome(context, lands, activeCount, pendingCount);

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildHome(
    BuildContext context,
    List<LandOwnerTimelineLand> lands,
    int activeCount,
    int pendingCount,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= QUICK ACTIONS =================
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              "My Lands",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: AppFonts.popins,
              ),
            ),
          ),

          /// Dynamic Lands List
          ListView.builder(
            itemCount: lands.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final land = lands[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _landCard(land),
              );
            },
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  /// ================= LAND CARD =================
  static Widget _landCard(LandOwnerTimelineLand land) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.35),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Dummy Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              "https://images.unsplash.com/photo-1500382017468-9049fed747ef",
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      land.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.popins,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        land.status,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  land.location,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: AppFonts.popins,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Area: ${land.area}",
                  style: TextStyle(fontFamily: AppFonts.popins),
                ),
                Text(
                  "Land ID: ${land.landId},",
                  style: TextStyle(fontFamily: AppFonts.popins),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
