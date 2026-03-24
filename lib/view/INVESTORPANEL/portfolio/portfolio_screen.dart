import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/model/INVESTORPANEL/activeInvestment/active_investment_model.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/INVESTORPANEL/activeInvestment/active_investment_bloc.dart';
import '../../../blocs/INVESTORPANEL/allInvestmentPlan/all_investment_plan_bloc.dart';
import '../../../repository/INVESTORPANEL/invesmentPlan/all_investment_plan_repository.dart';
import '../../../res/color/app_colors.dart';
import '../newInvesment/new_investment_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioState();
}

class _PortfolioState extends State<PortfolioScreen> {
  int selectedFilter = 0;
  late ActiveInvestmentBloc activeInvestmentBloc;

  final filters = ["All", "Active", "Matured", "Pending"];

  @override
  void initState() {
    super.initState();
    activeInvestmentBloc = ActiveInvestmentBloc(
      activeInvestmentRepository: getIt(),
    );
  }

  @override
  void dispose() {
    activeInvestmentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F5F7),
      body: BlocProvider(
        create: (_) => activeInvestmentBloc..add(ActiveInvestmentFetched()),
        child: BlocBuilder<ActiveInvestmentBloc, ActiveInvestmentState>(
          builder: (BuildContext context, state) {
            switch (state.activeInvestment.status) {
              case Status.loading:
                return _buildLoadingState();

              case Status.error:
                return _buildErrorState(state);

              case Status.completed:
                if (state.activeInvestment.data == null) {
                  return _buildEmptyDataState();
                }

                final activeInvestment = state.activeInvestment.data!;
                final allInvestments = activeInvestment.investments ?? [];
                final stats = activeInvestment.stats;

                // Filter investments based on selected tab
                final filteredInvestments = _filterInvestments(
                  allInvestments,
                  filters[selectedFilter],
                );

                return RefreshIndicator(
                  onRefresh: () async {
                    activeInvestmentBloc.add(ActiveInvestmentFetched());
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        _buildHeader(context, stats),
                        _buildFilterChips(),
                        filteredInvestments.isEmpty
                            ? _buildEmptyState(filters[selectedFilter])
                            : _buildInvestmentsList(filteredInvestments),
                        const SizedBox(height: 24),

                        RoundButton(
                          width: 350,
                          title: '+ New Investment ',
                          buttonColor: AppColors.greenColor,
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (context) => AllInvestmentPlanBloc(
                                    allInvestmentPlanRepository:
                                        getIt<AllInvestmentPlanRepository>(),
                                  )..add(PlanFetched()),
                                  child: const NewInvestmentScreen(),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                );

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        _buildHeader(context, null),
        const Expanded(child: Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Widget _buildErrorState(ActiveInvestmentState state) {
    return Column(
      children: [
        _buildHeader(context, null),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
                const SizedBox(height: 16),
                Text(
                  state.activeInvestment.message.toString(),
                  style: const TextStyle(fontFamily: AppFonts.popins),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    activeInvestmentBloc.add(ActiveInvestmentFetched());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyDataState() {
    return Column(
      children: [
        _buildHeader(context, null),
        const Expanded(
          child: Center(
            child: Text(
              'No investment data found',
              style: TextStyle(fontFamily: AppFonts.popins),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentsList(List<Investments> investments) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: investments.length,
      itemBuilder: (context, index) {
        final investment = investments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PortfolioCard(investment: investment),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, Stats? stats) {
    final totalPortfolioValue = stats?.totalInvested ?? 0;
    final totalProfit =
        (stats?.projectedReturns ?? 0) - (stats?.totalInvested ?? 0);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1C5D9F), Color(0xff2FA463)],
        ),
      ),
      child: Column(
        children: [
          /// Top Bar
          Center(
            child: const Text(
              "My Portfolio",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: AppFonts.popins,
              ),
            ),
          ),
          const SizedBox(height: 20),

          /// Portfolio Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.15),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Portfolio Value",
                  style: TextStyle(
                    color: Colors.white70,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "₹${NumberFormat('#,##,###').format(totalPortfolioValue)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Invested: ₹${NumberFormat('#,##,###').format(totalPortfolioValue)}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                    Text(
                      "Profit: ₹${NumberFormat('#,##,###').format(totalProfit)}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
                if (stats != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeaderStat(
                          'Projected Returns',
                          '₹${NumberFormat('#,##,###').format(stats.projectedReturns ?? 0)}',
                        ),
                        _buildHeaderStat(
                          'Avg Return',
                          '${stats.avgReturnPercent?.toStringAsFixed(2) ?? '0'}%',
                        ),
                        _buildHeaderStat(
                          'Pending ROI',
                          '₹${NumberFormat('#,##,###').format(stats.pendingROI ?? 0)}',
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: AppFonts.popins,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 40,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        itemBuilder: (_, index) => _filterChip(index),
      ),
    );
  }

  Widget _filterChip(int index) {
    bool selected = selectedFilter == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3),
        width: 80,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: selected
              ? Colors.green
              : const Color.fromARGB(255, 215, 215, 215),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.25),
              blurRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            filters[index],
            style: TextStyle(
              color: selected ? Colors.white : Colors.black54,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.popins,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String filterType) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              "No $filterType Investments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
                fontFamily: AppFonts.popins,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "You don't have any $filterType investments yet",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                fontFamily: AppFonts.popins,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Investments> _filterInvestments(
    List<Investments> investments,
    String filter,
  ) {
    switch (filter.toLowerCase()) {
      case 'active':
        return investments.where((inv) {
          return inv.applicationStatus?.toLowerCase() == 'active' ||
              (inv.applicationStatus?.toLowerCase() == 'approved' &&
                  inv.endDate != null &&
                  DateTime.parse(inv.endDate!).isAfter(DateTime.now()));
        }).toList();

      case 'matured':
        return investments.where((inv) {
          return inv.applicationStatus?.toLowerCase() == 'completed' ||
              inv.applicationStatus?.toLowerCase() == 'matured' ||
              (inv.endDate != null &&
                  DateTime.parse(inv.endDate!).isBefore(DateTime.now()));
        }).toList();

      case 'pending':
        return investments.where((inv) {
          return inv.applicationStatus?.toLowerCase() == 'pending';
        }).toList();

      default:
        return investments;
    }
  }
}

/// ================= PORTFOLIO CARD =================
class PortfolioCard extends StatelessWidget {
  final Investments investment;

  const PortfolioCard({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    final status = _getStatusText(investment.applicationStatus);
    final statusColor = _getStatusColor(investment.applicationStatus);
    final progress = _calculateProgress(investment);
    final remainingTime = _getRemainingTime(investment);
    final currentValue = _calculateCurrentValue(investment);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.eco, color: Colors.green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      investment.planId?.planName ?? 'Investment Plan',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppFonts.popins,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${investment.investmentId ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Values
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _info(
                "Invested Amount",
                "₹${NumberFormat('#,##,###').format(investment.investmentAmount ?? 0)}",
              ),
              _info(
                "Current Value",
                "₹${NumberFormat('#,##,###').format(currentValue)}",
                valueColor: Colors.green,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _info("Tenure", "${investment.durationMonths ?? 0} Months"),
              _info(
                "Expected Returns",
                "${investment.expectedReturnPercent?.toStringAsFixed(2) ?? '0'}% p.a.",
                valueColor: Colors.green,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _info("ROI Frequency", investment.roiFrequency ?? 'N/A'),
              _info(
                "ROI Amount",
                "₹${NumberFormat('#,##,###').format(investment.roiAmount ?? 0)}/${_getFrequencyShort(investment.roiFrequency)}",
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Progress
          if (progress > 0 && progress < 1) ...[
            Text(
              "Progress",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontFamily: AppFonts.popins,
              ),
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                remainingTime,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],

          /// Bottom Row with Payment Button for Pending Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getGainText(investment),
                style: TextStyle(
                  color: _getGainColor(investment),
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.popins,
                ),
              ),

              RoundButton(
                height: 40,
                width: 90,
                fontSize: 10,
                buttonColor: AppColors.blueColor,
                title: 'View Details',
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.investmentDetailsScreen,
                  );
                },
              ),
              if (investment.applicationStatus?.toLowerCase() == 'pending' &&
                  investment.paymentStatus?.toLowerCase() == 'pending')
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.paymentScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                )
              else
                const Text(
                  "View Details",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.popins,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(String title, String value, {Color? valueColor}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: valueColor ?? Colors.black,
              fontFamily: AppFonts.popins,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  double _calculateProgress(Investments investment) {
    if (investment.startDate == null || investment.endDate == null) return 0;

    final start = DateTime.parse(investment.startDate!);
    final end = DateTime.parse(investment.endDate!);
    final now = DateTime.now();

    if (now.isBefore(start)) return 0;
    if (now.isAfter(end)) return 1;

    final totalDuration = end.difference(start).inDays;
    final elapsed = now.difference(start).inDays;

    return elapsed / totalDuration;
  }

  String _getRemainingTime(Investments investment) {
    if (investment.endDate == null) return 'No end date';

    final end = DateTime.parse(investment.endDate!);
    final now = DateTime.now();

    if (now.isAfter(end)) return 'Matured';

    final remaining = end.difference(now);
    final months = remaining.inDays ~/ 30;

    if (months > 0) {
      return '$months months remaining';
    } else {
      final days = remaining.inDays;
      return '$days days remaining';
    }
  }

  int _calculateCurrentValue(Investments investment) {
    final invested = investment.investmentAmount ?? 0;
    final expectedReturnPercent = investment.expectedReturnPercent ?? 0;
    final progress = _calculateProgress(investment);

    // Calculate current value based on progress
    final totalExpectedReturn = invested * (expectedReturnPercent / 100);
    final currentReturn = totalExpectedReturn * progress;

    return invested + currentReturn.toInt();
  }

  String _getGainText(Investments investment) {
    final invested = investment.investmentAmount ?? 0;
    final currentValue = _calculateCurrentValue(investment);
    final gain = currentValue - invested;
    final gainPercent = (gain / invested) * 100;

    if (gain >= 0) {
      return "+${gainPercent.toStringAsFixed(1)}% gain";
    } else {
      return "${gainPercent.toStringAsFixed(1)}% loss";
    }
  }

  Color _getGainColor(Investments investment) {
    final invested = investment.investmentAmount ?? 0;
    final currentValue = _calculateCurrentValue(investment);
    final gain = currentValue - invested;

    return gain >= 0 ? Colors.green : Colors.red;
  }

  String _getFrequencyShort(String? frequency) {
    switch (frequency?.toLowerCase()) {
      case 'monthly':
        return 'month';
      case 'quarterly':
        return 'quarter';
      case 'yearly':
        return 'year';
      default:
        return frequency?.toLowerCase() ?? 'period';
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
      case 'active':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'completed':
      case 'matured':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'approved':
        return 'Active';
      case 'active':
        return 'Active';
      case 'rejected':
        return 'Rejected';
      case 'completed':
      case 'matured':
        return 'Matured';
      default:
        return status ?? 'Unknown';
    }
  }
}
