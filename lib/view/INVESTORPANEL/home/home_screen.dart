import 'package:digifarmer/blocs/INVESTORPANEL/activeInvestment/active_investment_bloc.dart';
import 'package:digifarmer/blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/model/INVESTORPANEL/activeInvestment/active_investment_model.dart';
import 'package:digifarmer/repository/INVESTORPANEL/invesmentPlan/all_investment_plan_repository.dart';
import 'package:digifarmer/res/color/app_colors.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/INVESTORPANEL/allInvestmentPlan/all_investment_plan_bloc.dart';
import '../../../utils/enums.dart';
import '../newInvesment/new_investment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ActiveInvestmentBloc activeInvestmentBloc;
  late UserProfileBloc userProfileBloc;

  @override
  void initState() {
    super.initState();
    // Initialize blocs using getIt from main.dart
    activeInvestmentBloc = ActiveInvestmentBloc(
      activeInvestmentRepository: getIt(),
    );
    userProfileBloc = UserProfileBloc(userProfileRepository: getIt());
  }

  @override
  void dispose() {
    activeInvestmentBloc.close();
    userProfileBloc.close();
    super.dispose();
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

  // Filter only active investments
  List<Investments> _filterActiveInvestments(List<Investments> investments) {
    return investments.where((inv) {
      final isActive =
          inv.applicationStatus?.toLowerCase() == 'active' ||
          inv.applicationStatus?.toLowerCase() == 'approved';

      final isNotMatured =
          inv.endDate == null ||
          DateTime.parse(inv.endDate!).isAfter(DateTime.now());

      final isNotPending = inv.applicationStatus?.toLowerCase() != 'pending';

      return isActive && isNotMatured && isNotPending;
    }).toList();
  }

  // Calculate total portfolio value
  int _calculateTotalPortfolioValue(
    Stats? stats,
    List<Investments> activeInvestments,
  ) {
    if (stats != null && stats.totalInvested != null) {
      return stats.totalInvested!;
    }

    // Fallback calculation from active investments
    int total = 0;
    for (var inv in activeInvestments) {
      total += inv.investmentAmount ?? 0;
    }
    return total;
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

  // Calculate monthly returns from active investments
  int _calculateMonthlyReturns(List<Investments> activeInvestments) {
    int monthlyTotal = 0;
    for (var inv in activeInvestments) {
      final roiAmount = inv.roiAmount ?? 0;
      final frequency = inv.roiFrequency?.toLowerCase();

      if (frequency == 'monthly') {
        monthlyTotal += roiAmount.toInt();
      } else if (frequency == 'quarterly') {
        monthlyTotal += (roiAmount / 3).toInt();
      } else if (frequency == 'yearly') {
        monthlyTotal += (roiAmount / 12).toInt();
      } else {
        monthlyTotal += roiAmount.toInt();
      }
    }
    return monthlyTotal;
  }

  // Calculate maturity value
  int _calculateMaturityValue(List<Investments> activeInvestments) {
    int total = 0;
    for (var inv in activeInvestments) {
      total +=
          (inv.investmentAmount ?? 0) + (inv.totalRoiExpected?.toInt() ?? 0);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActiveInvestmentBloc>.value(value: activeInvestmentBloc),
        BlocProvider<UserProfileBloc>.value(value: userProfileBloc),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: MultiBlocListener(
          listeners: [
            BlocListener<ActiveInvestmentBloc, ActiveInvestmentState>(
              listener: (context, state) {
                // Handle any side effects if needed
              },
            ),
            BlocListener<UserProfileBloc, UserProfileState>(
              listener: (context, state) {
                // Handle any side effects if needed
              },
            ),
          ],
          child: BlocBuilder<ActiveInvestmentBloc, ActiveInvestmentState>(
            builder: (context, investmentState) {
              // Fetch data when bloc is ready
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (investmentState.activeInvestment.status == Status.loading) {
                  activeInvestmentBloc.add(ActiveInvestmentFetched());
                }
                if (context.read<UserProfileBloc>().state.userProfile.status ==
                    Status.loading) {
                  context.read<UserProfileBloc>().add(UserProfileFetched());
                }
              });

              // Fix: Explicitly type cast to List<Investments>
              final List<Investments> activeInvestments =
                  investmentState.activeInvestment.status == Status.completed
                  ? _filterActiveInvestments(
                      investmentState.activeInvestment.data?.investments ?? [],
                    )
                  : [];

              final stats =
                  investmentState.activeInvestment.status == Status.completed
                  ? investmentState.activeInvestment.data?.stats
                  : null;

              final totalPortfolioValue = _calculateTotalPortfolioValue(
                stats,
                activeInvestments,
              );
              final monthlyReturns = _calculateMonthlyReturns(
                activeInvestments,
              );
              final maturityValue = _calculateMaturityValue(activeInvestments);

              // Calculate overall profit percentage
              final totalInvested = stats?.totalInvested ?? totalPortfolioValue;
              final totalProfit =
                  (stats?.projectedReturns ?? 0) - totalInvested;
              final profitPercentage = totalInvested > 0
                  ? (totalProfit / totalInvested) * 100
                  : 0;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    /// ================= HEADER =================
                    BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, profileState) {
                        final userName =
                            profileState.userProfile.data?.user?.fullName ?? '';
                        final userInitials = _getInitials(userName);

                        return Container(
                          padding: const EdgeInsets.fromLTRB(18, 50, 18, 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? [Colors.black87, Colors.black54]
                                  : [
                                      const Color(0xff1C6C8C),
                                      const Color(0xff2FA463),
                                    ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              /// Top Row with Avatar and Notification
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RoutesName.userProfileScreen,
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                      child: Text(
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
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Welcome back,",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontFamily: AppFonts.popins,
                                          ),
                                        ),
                                        userName.isEmpty
                                            ? Container(
                                                height: 16,
                                                width: 110,
                                                margin: const EdgeInsets.only(
                                                  top: 3,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.25),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              )
                                            : Text(
                                                userName,
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).cardColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: AppFonts.popins,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RoutesName.workerNotification,
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.notifications_none,
                                        color: Theme.of(context).cardColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              /// Portfolio Card with Real Data
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.portFolioScreen,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.12),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Total Portfolio Value",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: AppFonts.popins,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "₹${NumberFormat('#,##,###').format(totalPortfolioValue)}",
                                        style: TextStyle(
                                          color: Theme.of(context).cardColor,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: AppFonts.popins,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        profitPercentage >= 0
                                            ? "+${profitPercentage.toStringAsFixed(1)}% ↑"
                                            : "${profitPercentage.toStringAsFixed(1)}% ↓",
                                        style: TextStyle(
                                          color: profitPercentage >= 0
                                              ? Colors.lightGreenAccent
                                              : Colors.redAccent,
                                          fontFamily: AppFonts.popins,
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Active Investments",
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontFamily: AppFonts.popins,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                activeInvestments.length
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).cardColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  fontFamily: AppFonts.popins,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "Monthly Returns",
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontFamily: AppFonts.popins,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                "₹${NumberFormat('#,##,###').format(monthlyReturns)}",
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).cardColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  fontFamily: AppFonts.popins,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    /// ================= BODY =================
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Invested + Current Value Cards
                          Row(
                            children: [
                              Expanded(
                                child: _smallCard(
                                  icon: Icons.account_balance_wallet,
                                  title: "Total Invested",
                                  value:
                                      "₹${NumberFormat('#,##,###').format(totalPortfolioValue)}",
                                  percent: profitPercentage >= 0
                                      ? "+${profitPercentage.toStringAsFixed(1)}%"
                                      : "${profitPercentage.toStringAsFixed(1)}%",
                                  color: const Color(0xffDFF3E7),
                                  isPositive: profitPercentage >= 0,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _smallCard(
                                  icon: Icons.show_chart,
                                  title: "Current Value",
                                  value:
                                      "₹${NumberFormat('#,##,###').format(totalPortfolioValue + (stats?.totalROIEarned ?? 0))}",
                                  percent:
                                      "+${((stats?.totalROIEarned ?? 0) / (totalPortfolioValue > 0 ? totalPortfolioValue : 1) * 100).toStringAsFixed(1)}%",
                                  color: const Color(0xffE6EDFF),
                                  isPositive: true,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          /// Expected Maturity Card
                          if (activeInvestments.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purple.shade100,
                                    Colors.purple.shade50,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.event_available,
                                        color: Colors.purple,
                                      ),
                                      const SizedBox(width: 10),
                                      const Expanded(
                                        child: Text(
                                          "Expected Maturity Value",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: AppFonts.popins,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "₹${NumberFormat('#,##,###').format(maturityValue)}",
                                        style: const TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          fontFamily: AppFonts.popins,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: totalPortfolioValue > 0
                                          ? (totalPortfolioValue /
                                                    (maturityValue > 0
                                                        ? maturityValue
                                                        : 1))
                                                .clamp(0.0, 1.0)
                                          : 0.0,
                                      minHeight: 8,
                                      backgroundColor: Colors.purple.shade100,
                                      valueColor: const AlwaysStoppedAnimation(
                                        Colors.purple,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${((totalPortfolioValue / (maturityValue > 0 ? maturityValue : 1)) * 100).toStringAsFixed(1)}%",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppFonts.popins,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          const SizedBox(height: 24),

                          /// Active Investments Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Active Investments",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                              if (activeInvestments.isNotEmpty)
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesName.activeInvestmentScreen,
                                    );
                                  },
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          /// Active Investments List or Empty State
                          if (investmentState.activeInvestment.status ==
                              Status.loading)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          else if (activeInvestments.isEmpty)
                            _buildEmptyActiveInvestments(context)
                          else
                            ...activeInvestments.take(3).map((investment) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _investmentTile(
                                  title:
                                      investment.planId?.planName ??
                                      'Investment Plan',
                                  subtitle:
                                      "${investment.durationMonths} months • ${investment.roiFrequency ?? 'N/A'} ROI",
                                  value:
                                      "₹${NumberFormat('#,##,###').format(investment.investmentAmount)}",
                                  roi:
                                      "+${investment.expectedReturnPercent?.toStringAsFixed(1) ?? '0'}% ROI",
                                  progress: _calculateProgress(investment),
                                  startDate: investment.startDate,
                                  endDate: investment.endDate,
                                ),
                              );
                            }),

                          const SizedBox(height: 24),

                          /// Quick Actions
                          const Text(
                            "Quick Actions",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: AppFonts.popins,
                            ),
                          ),

                          const SizedBox(height: 14),

                          Row(
                            children: [
                              Expanded(
                                child: _actionCard(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider(
                                          create: (context) =>
                                              AllInvestmentPlanBloc(
                                                allInvestmentPlanRepository:
                                                    getIt<
                                                      AllInvestmentPlanRepository
                                                    >(),
                                              )..add(PlanFetched()),
                                          child: const NewInvestmentScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  title: "New Investment",
                                  subtitle: "Browse opportunities",
                                  color: const Color(0xff2FA463),
                                  icon: Icons.add_circle_outline,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _actionCard(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesName.portFolioScreen,
                                    );
                                  },
                                  title: "Portfolio",
                                  subtitle: "View details",
                                  color: const Color(0xff3B6FD8),
                                  icon: Icons.pie_chart_outline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyActiveInvestments(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: Offset(3, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.trending_up,
              size: 48,
              color: Colors.green.shade400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "No Active Investments",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Start your investment journey today and grow your wealth",
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.popins,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              "Explore Investments",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.popins,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallCard({
    required IconData icon,
    required String title,
    required String value,
    required String percent,
    required Color color,
    required bool isPositive,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: AppFonts.popins,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            percent,
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontSize: 11,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _investmentTile({
    required String title,
    required String subtitle,
    required String value,
    required String roi,
    required double progress,
    String? startDate,
    String? endDate,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.eco, color: Colors.green, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  Text(
                    roi,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 11,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (progress > 0 && progress < 1) ...[
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: Colors.grey.shade200,
              color: Colors.green,
              borderRadius: BorderRadius.circular(2),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (startDate != null)
                  Text(
                    DateFormat('dd MMM').format(DateTime.parse(startDate)),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                Text(
                  "${(progress * 100).toStringAsFixed(0)}% completed",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                if (endDate != null)
                  Text(
                    DateFormat('dd MMM').format(DateTime.parse(endDate)),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _actionCard({
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
