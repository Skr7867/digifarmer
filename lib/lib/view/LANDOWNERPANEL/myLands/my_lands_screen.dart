import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/LANDOWNERPANEL/landStatus/land_status_bloc.dart';
import '../../../model/LANDOWNERSPANEL/landOwnerTimeLine/land_owner_timeline_model.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/enums.dart';

class MyLandsScreen extends StatefulWidget {
  const MyLandsScreen({super.key});

  @override
  State<MyLandsScreen> createState() => _MyLandsScreenState();
}

class _MyLandsScreenState extends State<MyLandsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _searchQuery = '';
  String _selectedFilter = 'All';

  // Pagination
  static const int _pageSize = 5;
  int _currentPage = 1;

  final List<String> _filterOptions = [
    'All',
    'DOC_VERIFIED',
    'PENDING',
    'LIVE',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  // Cache filtered lands length to avoid recomputing in scroll listener
  int _cachedFilteredTotal = 0;

  void _loadMore() {
    final maxPages = (_cachedFilteredTotal / _pageSize).ceil();
    if (_currentPage < maxPages) {
      setState(() => _currentPage++);
    }
  }

  List<LandOwnerTimelineLand> _filterLands(List<LandOwnerTimelineLand> lands) {
    final filtered = lands.where((land) {
      final query = _searchQuery.toLowerCase();
      final matchesSearch =
          query.isEmpty ||
          land.title.toLowerCase().contains(query) ||
          land.location.toLowerCase().contains(query) ||
          land.landId.toLowerCase().contains(query) ||
          land.area.toLowerCase().contains(query);

      final matchesFilter =
          _selectedFilter == 'All' ||
          (_selectedFilter == 'LIVE' && land.isLive) ||
          land.status == _selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();

    _cachedFilteredTotal = filtered.length;
    return filtered;
  }

  List<LandOwnerTimelineLand> _paginate(
    List<LandOwnerTimelineLand> filteredLands,
  ) {
    final end = (_currentPage * _pageSize).clamp(0, filteredLands.length);
    return filteredLands.sublist(0, end);
  }

  void _resetPagination() {
    setState(() {
      _currentPage = 1;
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

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
              final lands = state.landStatus.data!.data.lands;
              final totalCount = state.landStatus.data!.data.count;
              final activeCount = lands
                  .where((e) => e.status == "DOC_VERIFIED")
                  .length;
              final pendingCount = lands
                  .where((e) => e.status == "PENDING")
                  .length;
              final liveCount = lands.where((e) => e.isLive).length;
              final filteredLands = _filterLands(lands);
              final paginated = _paginate(filteredLands);
              final hasMore = paginated.length < filteredLands.length;

              return _buildScrollableBody(
                filteredLands: filteredLands,
                paginated: paginated,
                totalCount: totalCount,
                activeCount: activeCount,
                pendingCount: pendingCount,
                liveCount: liveCount,
                hasMore: hasMore,
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildScrollableBody({
    required List<LandOwnerTimelineLand> filteredLands,
    required List<LandOwnerTimelineLand> paginated,
    required int totalCount,
    required int activeCount,
    required int pendingCount,
    required int liveCount,
    required bool hasMore,
  }) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        /// ===== SUMMARY STATS =====
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff34A853), Color(0xff0D47A1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statItem(Icons.landscape, "$totalCount", "Total"),
                _vDivider(),
                _statItem(Icons.verified, "$activeCount", "Verified"),
                _vDivider(),
                _statItem(Icons.pending_actions, "$pendingCount", "Pending"),
                _vDivider(),
                _statItem(Icons.wifi_tethering, "$liveCount", "Live"),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 14)),

        /// ===== SEARCH BAR =====
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                _searchQuery = val;
                _resetPagination();
              },
              style: const TextStyle(fontFamily: AppFonts.popins, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Search by title, location, land ID...",
                hintStyle: const TextStyle(
                  fontFamily: AppFonts.popins,
                  fontSize: 13,
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xff34A853)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _searchQuery = '';
                          _resetPagination();
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xffE0E0E0),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xff34A853),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 10)),

        /// ===== FILTER CHIPS =====
        SliverToBoxAdapter(
          child: SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filterOptions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final option = _filterOptions[index];
                final isSelected = _selectedFilter == option;
                return GestureDetector(
                  onTap: () {
                    _selectedFilter = option;
                    _resetPagination();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff34A853)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xff34A853)
                            : const Color(0xffDDDDDD),
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(
                                  0xff34A853,
                                ).withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontFamily: AppFonts.popins,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 6)),

        /// ===== RESULT COUNT =====
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              "${filteredLands.length} land${filteredLands.length != 1 ? 's' : ''} found  •  showing ${paginated.length}",
              style: const TextStyle(
                fontFamily: AppFonts.popins,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 4)),

        /// ===== EMPTY STATE =====
        if (paginated.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  Text(
                    "No lands found",
                    style: TextStyle(
                      fontFamily: AppFonts.popins,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Try a different search or filter",
                    style: TextStyle(
                      fontFamily: AppFonts.popins,
                      fontSize: 13,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),

        /// ===== LAND CARDS =====
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _LandCard(land: paginated[index]),
              childCount: paginated.length,
            ),
          ),
        ),

        /// ===== LOAD MORE / END INDICATOR =====
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: hasMore
                ? Center(
                    child: TextButton.icon(
                      onPressed: _loadMore,
                      icon: const Icon(
                        Icons.expand_more,
                        color: Color(0xff34A853),
                      ),
                      label: Text(
                        "Load more  (${filteredLands.length - paginated.length} remaining)",
                        style: const TextStyle(
                          fontFamily: AppFonts.popins,
                          color: Color(0xff34A853),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(
                          0xff34A853,
                        ).withValues(alpha: 0.08),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: Color(0xff34A853),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  )
                : paginated.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey.shade300,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "All lands loaded",
                          style: TextStyle(
                            fontFamily: AppFonts.popins,
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ),
      ],
    );
  }

  Widget _statItem(IconData icon, String count, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.popins,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontFamily: AppFonts.popins,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _vDivider() => Container(
    height: 40,
    width: 1,
    color: Colors.white.withValues(alpha: 0.3),
  );
}

// =====================================================
// LAND CARD
// =====================================================
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

  IconData get _stepIcon {
    switch (land.currentStep) {
      case 1:
        return Icons.upload_file;
      case 2:
        return Icons.manage_search;
      case 3:
        return Icons.fact_check;
      case 4:
        return Icons.verified;
      default:
        return Icons.flag;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
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
                  top: Radius.circular(18),
                ),
                child: Image.network(
                  "https://images.unsplash.com/photo-1500382017468-9049fed747ef",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 150,
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
                    top: Radius.circular(18),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.55),
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
                      children: [
                        Container(
                          width: 7,
                          height: 7,
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
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                bottom: 10,
                left: 12,
                right: 12,
                child: Text(
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
                    _badge(
                      label: _statusLabel,
                      color: _statusColor,
                      bgColor: _statusColor.withValues(alpha: 0.12),
                    ),
                    const SizedBox(width: 8),
                    _badge(
                      label: land.stepStatus,
                      color: const Color(0xff0D47A1),
                      bgColor: const Color(0xff0D47A1).withValues(alpha: 0.1),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _infoRow(
                  icon: Icons.location_on_outlined,
                  iconColor: Colors.redAccent,
                  text: land.location,
                ),
                const SizedBox(height: 6),
                _infoRow(
                  icon: Icons.crop_free,
                  iconColor: const Color(0xff0D47A1),
                  text: "Area: ${land.area}",
                ),
                const SizedBox(height: 6),
                _infoRow(
                  icon: Icons.tag,
                  iconColor: Colors.purple,
                  text: "Land ID: ${land.landId}",
                ),
                const SizedBox(height: 6),
                _infoRow(
                  icon: Icons.calendar_today_outlined,
                  iconColor: Colors.teal,
                  text: "Submitted: ${dateFormat.format(land.submittedAt)}",
                ),
                const SizedBox(height: 6),
                _infoRow(
                  icon: Icons.update,
                  iconColor: Colors.orange,
                  text: "Updated: ${dateFormat.format(land.updatedAt)}",
                ),
                const SizedBox(height: 14),
                const Divider(height: 1, color: Color(0xffF0F0F0)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(_stepIcon, size: 16, color: const Color(0xff34A853)),
                    const SizedBox(width: 6),
                    Text(
                      "Step ${land.currentStep} Progress",
                      style: const TextStyle(
                        fontFamily: AppFonts.popins,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xff34A853),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: land.currentStep / 4,
                    backgroundColor: const Color(0xffE8F5E9),
                    color: const Color(0xff34A853),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Step ${land.currentStep} of 4 completed",
                  style: const TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge({
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: AppFonts.popins,
          fontWeight: FontWeight.w600,
          fontSize: 11,
          color: color,
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: iconColor),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: AppFonts.popins,
              fontSize: 13,
              color: Color(0xff444444),
            ),
          ),
        ),
      ],
    );
  }
}
