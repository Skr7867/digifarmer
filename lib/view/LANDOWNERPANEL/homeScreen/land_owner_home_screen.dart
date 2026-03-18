import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/color/app_colors.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/LANDOWNERPANEL/landStatus/land_status_bloc.dart';
import '../../../model/LANDOWNERSPANEL/landOwnerTimeLine/land_owner_timeline_model.dart';
import '../../../utils/enums.dart';

class LandOwnerHomeScreen extends StatelessWidget {
  const LandOwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          /// ================= HEADER =================
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff1E88E5), Color(0xff2BB673)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                /// Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu, color: Colors.white),
                    Row(
                      children: [
                        const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 12),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              "https://i.pravatar.cc/100",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome back,",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),

                const SizedBox(height: 5),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Rajesh Kumar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Land Owner ID: LO2024567",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),

                const SizedBox(height: 20),

                /// Stats Card
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(
                        title: "Total Lands",
                        value: lands.length.toString(),
                      ),
                      _StatItem(
                        title: "Active Leases",
                        value: activeCount.toString(),
                      ),
                      _StatItem(
                        title: "Pending",
                        value: pendingCount.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= QUICK ACTIONS =================
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Quick Actions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: AppFonts.popins,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _quickActionCard(
                    icon: Icons.add,
                    title: "Add New Land",
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.addNewLandScreen);
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _quickActionCard(
                    icon: Icons.description,
                    title: "View Contracts",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          /// ================= MY LANDS =================
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
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
            itemCount: 4,
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

  /// ================= QUICK ACTION CARD =================
  static Widget _quickActionCard({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xffE8F5E9),
              child: Icon(icon, color: const Color(0xff2BB673)),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.popins,
              ),
            ),
          ],
        ),
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

class _StatItem extends StatelessWidget {
  final String title;
  final String value;

  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontFamily: AppFonts.popins,
          ),
        ),
      ],
    );
  }
}
