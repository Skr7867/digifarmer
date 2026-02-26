import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/model/investmentPlan/all_investment_plan_model.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/allInvestmentPlan/all_investment_plan_bloc.dart';
import '../../../main.dart';
import '../../../res/color/app_colors.dart';
import '../../../utils/enums.dart';

class NewInvestmentScreen extends StatefulWidget {
  const NewInvestmentScreen({super.key});

  @override
  State<NewInvestmentScreen> createState() => _NewInvestmentScreenState();
}

class _NewInvestmentScreenState extends State<NewInvestmentScreen> {
  late AllInvestmentPlanBloc _allInvestmentPlanBloc;
  int? selectedDuration;
  double investmentAmount = 25000;
  InvestmentPlanModel? selectedPlan;

  @override
  void initState() {
    super.initState();
    _allInvestmentPlanBloc = AllInvestmentPlanBloc(
      allInvestmentPlanRepository: getIt(),
    );
    _allInvestmentPlanBloc.add(PlanFetched());
  }

  @override
  void dispose() {
    _allInvestmentPlanBloc.close();
    super.dispose();
  }

  double getMultiplier() {
    if (selectedPlan == null || selectedDuration == null) return 1.0;
    final multipliers = selectedPlan!.durationMultipliers;
    final key = selectedDuration.toString();
    final val = multipliers[key];
    if (val == null) return 1.0;
    // ignore: unnecessary_type_check, dead_code
    return (val is num) ? val.toDouble() : 1.0;
  }

  double calculateReturns() {
    if (selectedPlan == null || selectedDuration == null) return 0;
    double rate = selectedPlan!.baseReturnPercent / 100.0;
    double multiplier = getMultiplier();
    int years = selectedDuration!;
    return investmentAmount * rate * years * multiplier;
  }

  double calculateMaturity() {
    return investmentAmount + calculateReturns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: BlocProvider(
        create: (_) => _allInvestmentPlanBloc,
        child: BlocBuilder<AllInvestmentPlanBloc, AllInvestmentSplanState>(
          builder: (context, state) {
            switch (state.allInvestmentPlan.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.allInvestmentPlan.message ??
                            'Something went wrong',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontFamily: AppFonts.popins),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () =>
                            _allInvestmentPlanBloc.add(PlanFetched()),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );

              case Status.completed:
                final allPlanData = state.allInvestmentPlan.data;
                if (allPlanData == null || allPlanData.plans.isEmpty) {
                  return const Center(child: Text('No plans found'));
                }

                final plans = allPlanData.plans;

                // init defaults once
                if (selectedPlan == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      selectedPlan = plans.first;
                      selectedDuration =
                          plans.first.availableDurations.isNotEmpty
                          ? plans.first.availableDurations.first
                          : null;
                    });
                  });
                  selectedPlan = plans.first;
                  selectedDuration = plans.first.availableDurations.isNotEmpty
                      ? plans.first.availableDurations.first
                      : null;
                }

                final plan = selectedPlan!;
                final quickAmounts = _getQuickAmounts(plan);

                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// HEADER
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(Icons.arrow_back),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Color(0xffE6F4EA),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.eco,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plan.planName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                  Text(
                                    plan.riskLevel,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// STEP INDICATOR
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _stepCircle("1", true),
                                  _stepLine(),
                                  _stepCircle("2", false),
                                  _stepLine(),
                                  _stepCircle("3", false),
                                ],
                              ),

                              const SizedBox(height: 30),

                              /// PLAN SELECTOR (if multiple plans)
                              if (plans.length > 1) ...[
                                const Text(
                                  "Select Plan",
                                  style: TextStyle(
                                    fontFamily: AppFonts.popins,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: plans.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 8),
                                    itemBuilder: (context, index) {
                                      final p = plans[index];
                                      final isSelected =
                                          selectedPlan?.id == p.id;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedPlan = p;
                                            selectedDuration =
                                                p.availableDurations.isNotEmpty
                                                ? p.availableDurations.first
                                                : null;
                                            investmentAmount = p.minInvestment
                                                .toDouble();
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.blue
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            border: Border.all(
                                              color: isSelected
                                                  ? Colors.blue
                                                  : Colors.grey.shade300,
                                            ),
                                          ),
                                          child: Text(
                                            p.planName,
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontFamily: AppFonts.popins,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],

                              /// ENTER INVESTMENT
                              const Text(
                                "Enter Investment Amount",
                                style: TextStyle(
                                  fontFamily: AppFonts.popins,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Choose how much you want to invest",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),

                              const SizedBox(height: 16),

                              /// AMOUNT BOX
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withValues(alpha: 0.25),
                                  ),
                                  color: const Color(0xffE9EEF5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Investment Amount",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: AppFonts.popins,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "₹ ${investmentAmount.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.popins,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 10),

                              /// MIN MAX
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Minimum ₹${_formatAmount(plan.minInvestment.toDouble())}",
                                    style: const TextStyle(
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                  Text(
                                    "Maximum ₹${_formatAmount(plan.maxInvestment.toDouble())}",
                                    style: const TextStyle(
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              /// QUICK AMOUNT BUTTONS
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: quickAmounts
                                    .map(
                                      (amount) => _amountButton(amount, plan),
                                    )
                                    .toList(),
                              ),

                              const SizedBox(height: 30),

                              /// TENURE
                              const Text(
                                "Select Investment Tenure",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Higher tenure offers better returns",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),

                              const SizedBox(height: 16),

                              ...plan.availableDurations.asMap().entries.map((
                                entry,
                              ) {
                                final duration = entry.value;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _tenureCard(
                                    duration,
                                    plan,
                                    popular:
                                        plan.isPopular &&
                                        duration == plan.defaultDurationMonths,
                                  ),
                                );
                              }),

                              const SizedBox(height: 20),

                              /// INFO BOX
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFF4DB),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.info,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "${plan.defaultRoiFrequency} Returns\n"
                                        "Lock-in period: ${plan.lockInPeriodMonths} months. "
                                        "${plan.prematureExitAllowed ? 'Premature exit allowed with ${plan.prematureExitPenalty}% penalty.' : 'Premature exit not allowed.'}",
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 30),

                              /// TOTAL SECTION
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Total Investment"),
                                        Text(
                                          "₹ ${investmentAmount.toStringAsFixed(0)}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: AppFonts.popins,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Expected Returns",
                                          style: TextStyle(
                                            fontFamily: AppFonts.popins,
                                          ),
                                        ),
                                        Text(
                                          "₹ ${calculateReturns().toStringAsFixed(0)}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontFamily: AppFonts.popins,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              /// CONTINUE BUTTON
                              RoundButton(
                                width: double.infinity,
                                buttonColor: AppColors.greenColor,
                                title: 'Continue to review',
                                onPress: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.proceedPaymentScreen,
                                  );
                                },
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
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

  List<double> _getQuickAmounts(InvestmentPlanModel plan) {
    final min = plan.minInvestment.toDouble();
    final max = plan.maxInvestment.toDouble();
    final range = max - min;
    if (range <= 0) return [min];

    return [min, min + range * 0.25, min + range * 0.5, max];
  }

  String _formatAmount(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    }
    return amount.toStringAsFixed(0);
  }

  Widget _amountButton(double amount, InvestmentPlanModel plan) {
    final isSelected = investmentAmount == amount;
    return GestureDetector(
      onTap: () {
        setState(() {
          investmentAmount = amount.clamp(
            plan.minInvestment.toDouble(),
            plan.maxInvestment.toDouble(),
          );
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? Colors.blue.withOpacity(0.08) : Colors.white,
        ),
        child: Text(
          "₹${_formatAmount(amount)}",
          style: TextStyle(
            fontFamily: AppFonts.popins,
            color: isSelected ? Colors.blue : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _tenureCard(
    int duration,
    InvestmentPlanModel plan, {
    bool popular = false,
  }) {
    final isSelected = selectedDuration == duration;
    final rate =
        plan.baseReturnPercent * getMultiplierForDuration(plan, duration);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDuration = duration;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Radio<int>(
                  value: duration,
                  groupValue: selectedDuration,
                  onChanged: (value) {
                    setState(() {
                      selectedDuration = value;
                    });
                  },
                ),
                Text(
                  "$duration Months",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const Spacer(),
                Text(
                  "${rate.toStringAsFixed(1)}% p.a.",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                const SizedBox(width: 6),
                if (popular)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Popular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xffE8F5E9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _rowData(
                    "Estimated Returns",
                    "₹ ${_calcReturnsForDuration(plan, duration).toStringAsFixed(0)}",
                  ),
                  const SizedBox(height: 6),
                  _rowData(
                    "Maturity Amount",
                    "₹ ${(investmentAmount + _calcReturnsForDuration(plan, duration)).toStringAsFixed(0)}",
                    isGreen: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getMultiplierForDuration(InvestmentPlanModel plan, int duration) {
    final val = plan.durationMultipliers[duration.toString()];
    if (val == null) return 1.0;
    // ignore: unnecessary_type_check, dead_code
    return (val is num) ? val.toDouble() : 1.0;
  }

  double _calcReturnsForDuration(InvestmentPlanModel plan, int durationMonths) {
    double rate = plan.baseReturnPercent / 100.0;
    double multiplier = getMultiplierForDuration(plan, durationMonths);
    double years = durationMonths / 12.0;
    return investmentAmount * rate * years * multiplier;
  }

  Widget _rowData(String title, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isGreen ? Colors.green : Colors.black,
            fontFamily: AppFonts.popins,
          ),
        ),
      ],
    );
  }

  Widget _stepCircle(String text, bool active) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.blue : Colors.grey.shade300,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.popins,
          ),
        ),
      ),
    );
  }

  Widget _stepLine() {
    return Container(width: 40, height: 2, color: Colors.grey.shade300);
  }
}
