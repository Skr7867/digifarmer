import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/INVESTORPANEL/activeInvestment/active_investment_bloc.dart';
import '../../../blocs/INVESTORPANEL/allInvestmentPlan/all_investment_plan_bloc.dart';
import '../../../config/component/internet_exception.dart';
import '../../../config/routes/routes_name.dart';
import '../../../main.dart';
import '../../../model/INVESTORPANEL/activeInvestment/active_investment_model.dart';
import '../../../repository/INVESTORPANEL/invesmentPlan/all_investment_plan_repository.dart';
import '../../../res/color/app_colors.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/customeWidgets/round_button.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/enums.dart';
import '../newInvesment/new_investment_screen.dart';

class ActiveInvestmentScreen extends StatefulWidget {
  const ActiveInvestmentScreen({super.key});

  @override
  State<ActiveInvestmentScreen> createState() => _ActiveInvestmentScreenState();
}

class _ActiveInvestmentScreenState extends State<ActiveInvestmentScreen> {
  late ActiveInvestmentBloc activeInvestmentBloc;

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
      appBar: CustomAppBar(
        title: 'Active Investment ',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: BlocProvider(
        create: (_) => activeInvestmentBloc..add(ActiveInvestmentFetched()),
        child: BlocBuilder<ActiveInvestmentBloc, ActiveInvestmentState>(
          builder: (BuildContext context, state) {
            switch (state.activeInvestment.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
                if (state.activeInvestment.message ==
                    'No Internet Connection') {
                  return Center(
                    child: InternetException(
                      onPress: () {
                        activeInvestmentBloc.add(ActiveInvestmentFetched());
                      },
                    ),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.activeInvestment.message.toString(),
                        style: const TextStyle(fontSize: 16),
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
                );

              case Status.completed:
                if (state.activeInvestment.data == null) {
                  return _buildEmptyState();
                }

                final activeInvestment = state.activeInvestment.data!;
                final allInvestments = activeInvestment.investments ?? [];
                final stats = activeInvestment.stats;

                // Filter only active investments
                final activeInvestments = _filterActiveInvestments(
                  allInvestments,
                );

                if (activeInvestments.isEmpty) {
                  return _buildEmptyState();
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    activeInvestmentBloc.add(ActiveInvestmentFetched());
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats Cards
                        if (stats != null)
                          _buildStatsSection(
                            context,
                            stats,
                            activeInvestments.length,
                          ),

                        const SizedBox(height: 16),

                        // Investments List
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Your Active Investments',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                  fontFamily: AppFonts.popins,
                                ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: activeInvestments.length,
                          itemBuilder: (context, index) {
                            final investment = activeInvestments[index];
                            return _buildInvestmentCard(context, investment);
                          },
                        ),

                        const SizedBox(height: 24),
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

  // Filter only active investments
  List<Investments> _filterActiveInvestments(List<Investments> investments) {
    return investments.where((inv) {
      // Check if investment is active based on application status and dates
      final isActive =
          inv.applicationStatus?.toLowerCase() == 'active' ||
          inv.applicationStatus?.toLowerCase() == 'approved';

      // Check if investment is not matured
      final isNotMatured =
          inv.endDate == null ||
          DateTime.parse(inv.endDate!).isAfter(DateTime.now());

      // Check if investment is not pending (pending investments are not active)
      final isNotPending = inv.applicationStatus?.toLowerCase() != 'pending';

      return isActive && isNotMatured && isNotPending;
    }).toList();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.trending_up,
              size: 80,
              color: Colors.green.shade300,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Active Investments',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'You don\'t have any active investments at the moment. Start your investment journey today!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.5,
                fontFamily: AppFonts.popins,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          RoundButton(
            width: 200,
            title: 'Explore Investment',
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
        ],
      ),
    );
  }

  Widget _buildStatsSection(
    BuildContext context,
    Stats stats,
    int activeCount,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade700, Colors.green.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatCard(
                context,
                'Total Invested',
                '₹${NumberFormat('#,##,###').format(stats.totalInvested)}',
                Icons.account_balance_wallet,
                Colors.white,
              ),
              SizedBox(width: 10),
              _buildStatCard(
                context,
                'Active',
                activeCount.toString(),
                Icons.trending_up,
                Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard(
                context,
                'Projected Returns',
                '₹${NumberFormat('#,##,###').format(stats.projectedReturns)}',
                Icons.attach_money,
                Colors.white,
              ),
              SizedBox(width: 10),
              _buildStatCard(
                context,
                'Avg Return',
                '${stats.avgReturnPercent!.toStringAsFixed(2)}%',
                Icons.percent,
                Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard(
                context,
                'Total ROI Earned',
                '₹${NumberFormat('#,##,###').format(stats.totalROIEarned)}',
                Icons.currency_rupee,
                Colors.white,
              ),
              SizedBox(width: 10),
              _buildStatCard(
                context,
                'Pending ROI',
                '₹${NumberFormat('#,##,###').format(stats.pendingROI)}',
                Icons.pending_actions,
                Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pending Payments',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade600,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    stats.pendingPayments.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.popins,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
                fontFamily: AppFonts.popins,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestmentCard(BuildContext context, Investments investment) {
    final statusColor = _getStatusColor(investment.applicationStatus);
    final statusText = _getStatusText(investment.applicationStatus);
    final riskColor = _getRiskColor(investment.riskLevel);

    // Calculate progress percentage
    final progress = _calculateProgress(investment);
    final remainingTime = _getRemainingTime(investment);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Plan Name and Status
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        investment.planId?.planName ?? 'Investment Plan',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${investment.investmentId}',
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
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Investment Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailItem(
                      'Investment Amount',
                      '₹${NumberFormat('#,##,###').format(investment.investmentAmount)}',
                      Icons.currency_rupee,
                    ),
                    _buildDetailItem(
                      'Return %',
                      '${investment.expectedReturnPercent?.toStringAsFixed(2) ?? '0'}%',
                      Icons.percent,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailItem(
                      'Duration',
                      '${investment.durationMonths} Months',
                      Icons.timer,
                    ),
                    _buildDetailItem(
                      'ROI Frequency',
                      investment.roiFrequency ?? 'N/A',
                      Icons.repeat,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailItem(
                      'Expected ROI',
                      '₹${NumberFormat('#,##,###').format(investment.totalRoiExpected ?? 0)}',
                      Icons.trending_up,
                    ),
                    _buildDetailItem(
                      'ROI Amount',
                      '₹${NumberFormat('#,##,###').format(investment.roiAmount ?? 0)}/${investment.roiFrequency?.toLowerCase() ?? 'month'}',
                      Icons.payments,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Progress Bar
                if (progress > 0 && progress < 1) ...[
                  Text(
                    'Investment Progress',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade200,
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Started: ${DateFormat('dd MMM yyyy').format(DateTime.parse(investment.startDate!))}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                      Text(
                        remainingTime,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],

                // Date Information
                if (investment.startDate != null && investment.endDate != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Date',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat(
                                'dd MMM yyyy',
                              ).format(DateTime.parse(investment.startDate!)),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppFonts.popins,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.grey.shade300,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Maturity Date',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontFamily: AppFonts.popins,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat(
                                'dd MMM yyyy',
                              ).format(DateTime.parse(investment.endDate!)),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppFonts.popins,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 12),

                // Risk Level and Lock-in Period
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRiskBadge(investment.riskLevel, riskColor),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Lock-in: ${investment.lockInPeriodMonths} months',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // View Details Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.investmentDetailsScreen,
                        arguments: investment.id,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.green.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
    final days = remaining.inDays % 30;

    if (months > 0) {
      return '$months months ${days > 0 ? '$days days' : ''} remaining';
    } else {
      return '$days days remaining';
    }
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.popins,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskBadge(String? riskLevel, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            'Risk: ${riskLevel ?? 'N/A'}',
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontFamily: AppFonts.popins,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'PENDING':
        return Colors.orange.shade600;
      case 'APPROVED':
      case 'ACTIVE':
        return Colors.green.shade600;
      case 'REJECTED':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  String _getStatusText(String? status) {
    switch (status?.toUpperCase()) {
      case 'PENDING':
        return 'Pending';
      case 'APPROVED':
        return 'Active';
      case 'ACTIVE':
        return 'Active';
      case 'REJECTED':
        return 'Rejected';
      default:
        return status ?? 'Unknown';
    }
  }

  Color _getRiskColor(String? riskLevel) {
    switch (riskLevel?.toUpperCase()) {
      case 'LOW':
        return Colors.green.shade600;
      case 'MEDIUM':
        return Colors.orange.shade600;
      case 'HIGH':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}
