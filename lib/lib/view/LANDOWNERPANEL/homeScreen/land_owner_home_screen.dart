import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import '../../../blocs/LANDOWNERPANEL/landStatus/land_status_bloc.dart';
import '../../../config/routes/routes_name.dart';
import '../../../model/LANDOWNERSPANEL/landOwnerTimeLine/land_owner_timeline_model.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/enums.dart';

class LandOwnerHomeScreen extends StatefulWidget {
  const LandOwnerHomeScreen({super.key});

  @override
  State<LandOwnerHomeScreen> createState() => _LandOwnerHomeScreenState();
}

class _LandOwnerHomeScreenState extends State<LandOwnerHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProfileBloc>().add(UserProfileFetched());
    });
  }

  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    final parts = trimmed.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return trimmed.length >= 2
        ? trimmed.substring(0, 2).toUpperCase()
        : trimmed.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F4F8),
      body: BlocBuilder<LandStatusBloc, LandStatusState>(
        builder: (context, state) {
          switch (state.landStatus.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(color: Color(0xff34A853)),
              );

            case Status.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.landStatus.message ?? "Something went wrong",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: AppFonts.popins,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );

            case Status.completed:
              final data = state.landStatus.data!.data;
              final lands = data.lands;
              final totalCount = data.count;
              final activeCount = lands
                  .where((e) => e.status == "DOC_VERIFIED")
                  .length;
              final pendingCount = lands
                  .where((e) => e.status == "PENDING")
                  .length;
              final liveCount = lands.where((e) => e.isLive).length;

              return _buildHome(
                context,
                lands,
                totalCount,
                activeCount,
                pendingCount,
                liveCount,
              );

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
    int totalCount,
    int activeCount,
    int pendingCount,
    int liveCount,
  ) {
    return CustomScrollView(
      slivers: [
        /// ===== HEADER =====
        SliverToBoxAdapter(
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, profileState) {
              final userName =
                  profileState.userProfile.data?.user?.fullName ?? '';
              final userInitials = _getInitials(userName);

              return _Header(
                totalCount: totalCount,
                activeCount: activeCount,
                pendingCount: pendingCount,
                liveCount: liveCount,
                userName: userName,
                userInitials: userInitials,
                profileImage: profileState.userProfile.data?.user?.profileImage,
              );
            },
          ),
        ),

        /// ===== ACTIVITY SUMMARY STRIP =====
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: _ActivityStrip(lands: lands),
          ),
        ),

        /// ===== QUICK ACTIONS =====
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 22, 16, 10),
            child: _SectionTitle(title: "Quick Actions"),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _QuickActions(context: context),
          ),
        ),

        /// ===== MY LANDS =====
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 10),
            child: _SectionTitle(title: "My Lands"),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _LandCard(land: lands[index]),
              childCount: lands.length.clamp(0, 4),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────
// HEADER
// ─────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final int totalCount, activeCount, pendingCount, liveCount;
  final String userName;
  final String userInitials;
  final String? profileImage;

  const _Header({
    required this.totalCount,
    required this.activeCount,
    required this.pendingCount,
    required this.liveCount,
    required this.userName, // ← added
    required this.userInitials, // ← added
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        bottom: 28,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff0D47A1), Color(0xff1976D2), Color(0xff34A853)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top bar
          Row(
            mainAxisAlignment: .end,
            children: [
              /// Notification bell with badge — unchanged
              Stack(
                clipBehavior: Clip.none,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.workerNotification,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xffFF5252),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),

              // ── CHANGED: initials avatar instead of static NetworkImage ──
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.userProfileScreen);
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    backgroundImage:
                        (profileImage != null && profileImage!.isNotEmpty)
                        ? NetworkImage(profileImage!)
                        : null,
                    child: (profileImage != null && profileImage!.isNotEmpty)
                        ? null
                        : Text(
                            userInitials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: AppFonts.popinsBold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          /// Greeting — unchanged
          const Text(
            "Welcome back,",
            style: TextStyle(
              color: Colors.white70,
              fontFamily: AppFonts.popins,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 2),

          // ── CHANGED: dynamic name with loading placeholder ──
          userName.isEmpty
              ? Container(
                  height: 24,
                  width: 150,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )
              : Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.popins,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

          const SizedBox(height: 4),

          /// ID + Date row — unchanged
          Row(
            children: [
              const Icon(Icons.badge_outlined, color: Colors.white60, size: 13),
              const SizedBox(width: 4),
              const Text(
                "LO2024567",
                style: TextStyle(
                  color: Colors.white60,
                  fontFamily: AppFonts.popins,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.calendar_today_outlined,
                color: Colors.white60,
                size: 13,
              ),
              const SizedBox(width: 4),
              Text(
                DateFormat('dd MMM yyyy').format(DateTime.now()),
                style: const TextStyle(
                  color: Colors.white60,
                  fontFamily: AppFonts.popins,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          /// Stats card — unchanged
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCell(
                  icon: Icons.landscape,
                  value: "$totalCount",
                  label: "Total",
                  color: const Color(0xff0D47A1),
                ),
                _vDivider(),
                _StatCell(
                  icon: Icons.verified_outlined,
                  value: "$activeCount",
                  label: "Verified",
                  color: const Color(0xff34A853),
                ),
                _vDivider(),
                _StatCell(
                  icon: Icons.pending_actions_outlined,
                  value: "$pendingCount",
                  label: "Pending",
                  color: const Color(0xffFFA000),
                ),
                _vDivider(),
                _StatCell(
                  icon: Icons.wifi_tethering,
                  value: "$liveCount",
                  label: "Live",
                  color: const Color(0xffE53935),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _vDivider() =>
      Container(width: 1, height: 44, color: const Color(0xffEEEEEE));
}

class _StatCell extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCell({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontFamily: AppFonts.popins,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppFonts.popins,
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────
// ACTIVITY STRIP
// ─────────────────────────────────────────────────────────
class _ActivityStrip extends StatelessWidget {
  final List<LandOwnerTimelineLand> lands;

  const _ActivityStrip({required this.lands});

  @override
  Widget build(BuildContext context) {
    if (lands.isEmpty) return const SizedBox();

    final sorted = [...lands]
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    final recent = sorted.first;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffE8F5E9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xff34A853).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xff34A853).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.update, color: Color(0xff34A853), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Latest Update",
                  style: TextStyle(
                    fontFamily: AppFonts.popins,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xff34A853),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "${recent.title}  •  ${recent.stepStatus}",
                  style: const TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 13,
                    color: Color(0xff2E7D32),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            DateFormat('dd MMM').format(recent.updatedAt),
            style: const TextStyle(
              fontFamily: AppFonts.popins,
              fontSize: 11,
              color: Color(0xff34A853),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// QUICK ACTIONS
// ─────────────────────────────────────────────────────────
class _QuickActions extends StatelessWidget {
  final BuildContext context;

  const _QuickActions({required this.context});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionData(
        icon: Icons.add_location_alt_outlined,
        label: "Add Land",
        color: const Color(0xff0D47A1),
        bg: const Color(0xffE3F2FD),
        onTap: () => Navigator.pushNamed(context, RoutesName.addNewLandScreen),
      ),

      _ActionData(
        icon: Icons.support_agent_outlined,
        label: "Support",
        color: const Color(0xff9C27B0),
        bg: const Color(0xffF3E5F5),
      ),
    ];

    return Row(
      children: actions
          .map(
            (a) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _QuickActionTile(data: a),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ActionData {
  final IconData icon;
  final String label;
  final Color color;
  final Color bg;
  final VoidCallback? onTap;

  const _ActionData({
    required this.icon,
    required this.label,
    required this.color,
    required this.bg,
    this.onTap,
  });
}

class _QuickActionTile extends StatelessWidget {
  final _ActionData data;

  const _QuickActionTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: data.color.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: data.bg, shape: BoxShape.circle),
              child: Icon(data.icon, color: data.color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              data.label,
              style: TextStyle(
                fontFamily: AppFonts.popins,
                fontWeight: FontWeight.w600,
                fontSize: 11,
                color: data.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// SECTION TITLE
// ─────────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xff34A853),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: AppFonts.popins,
            color: Color(0xff1A1A2E),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────
// LAND CARD
// ─────────────────────────────────────────────────────────
class _LandCard extends StatelessWidget {
  final LandOwnerTimelineLand land;

  const _LandCard({required this.land});

  Color get _statusColor {
    switch (land.status) {
      case 'DOC_VERIFIED':
        return const Color(0xff34A853);
      case 'PENDING':
        return const Color(0xffFFA000);
      case 'REJECTED':
        return const Color(0xffE53935);
      default:
        return const Color(0xff0D47A1);
    }
  }

  String get _statusLabel {
    switch (land.status) {
      case 'DOC_VERIFIED':
        return 'Verified';
      case 'PENDING':
        return 'Pending';
      case 'REJECTED':
        return 'Rejected';
      default:
        return land.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  "https://images.unsplash.com/photo-1500382017468-9049fed747ef",
                  height: 145,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 145,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),
              if (land.isLive)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xff34A853)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xff34A853),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "LIVE",
                          style: TextStyle(
                            color: Color(0xff34A853),
                            fontFamily: AppFonts.popins,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _statusLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: AppFonts.popins,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      land.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: AppFonts.popins,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 12,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            land.location,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontFamily: AppFonts.popins,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _chip(
                      icon: Icons.crop_free,
                      label: land.area,
                      color: const Color(0xff0D47A1),
                    ),
                    const SizedBox(width: 8),
                    _chip(
                      icon: Icons.tag,
                      label: land.landId,
                      color: Colors.purple,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _infoRow(
                        icon: Icons.alt_route,
                        iconColor: Colors.teal,
                        label: "Step Status",
                        value: land.stepStatus,
                      ),
                    ),
                    Expanded(
                      child: _infoRow(
                        icon: Icons.format_list_numbered,
                        iconColor: const Color(0xffFFA000),
                        label: "Current Step",
                        value: "${land.currentStep} / 4",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _infoRow(
                        icon: Icons.calendar_today_outlined,
                        iconColor: Colors.teal,
                        label: "Submitted",
                        value: dateFormat.format(land.submittedAt),
                      ),
                    ),
                    Expanded(
                      child: _infoRow(
                        icon: Icons.update,
                        iconColor: Colors.orange,
                        label: "Updated",
                        value: dateFormat.format(land.updatedAt),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Verification Progress",
                      style: TextStyle(
                        fontFamily: AppFonts.popins,
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${((land.currentStep / 4) * 100).toInt()}%",
                      style: const TextStyle(
                        fontFamily: AppFonts.popins,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff34A853),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: land.currentStep / 4,
                    backgroundColor: const Color(0xffE8F5E9),
                    color: const Color(0xff34A853),
                    minHeight: 7,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppFonts.popins,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 13, color: iconColor),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: AppFonts.popins,
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: AppFonts.popins,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff333333),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
