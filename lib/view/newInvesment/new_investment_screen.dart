import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/utils/enums.dart';
import '../../blocs/allInvestmentPlan/all_investment_plan_bloc.dart';
import '../../config/component/internet_exception.dart';
import '../../model/investmentPlan/all_investment_plan_model.dart';
import '../../res/color/app_colors.dart';
import '../../res/fonts/app_fonts.dart';
import '../../res/customeWidgets/round_button.dart';

class NewInvestmentScreen extends StatefulWidget {
  const NewInvestmentScreen({super.key});

  @override
  State<NewInvestmentScreen> createState() => _NewInvestmentScreenState();
}

class _NewInvestmentScreenState extends State<NewInvestmentScreen> {
  late AllInvestmentPlanBloc bloc;

  int selectedTenure = 0;
  double investmentAmount = 0;

  @override
  void initState() {
    super.initState();
    bloc = AllInvestmentPlanBloc(allInvestmentPlanRepository: getIt())
      ..add(PlanFetched());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: BlocProvider(
        create: (_) => bloc,
        child: BlocBuilder<AllInvestmentPlanBloc, AllInvestmentSplanState>(
          builder: (context, state) {
            switch (state.allInvestmentPlan.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                if (state.allInvestmentPlan.message ==
                    'No Internet Connection') {
                  return Center(child: InternetException(onPress: () {}));
                } else {
                  return Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      state.allInvestmentPlan.message.toString(),
                      style: TextStyle(
                        fontFamily: AppFonts.popins,
                        color: AppColors.redColor,
                        fontSize: 15,
                      ),
                    ),
                  );
                }
              case Status.completed:
                final data = state.allInvestmentPlan.data;

                if (data == null || data.plans.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Plans Available",
                      style: TextStyle(
                        fontFamily: AppFonts.popins,
                        fontSize: 15,
                      ),
                    ),
                  );
                }

                /// For now select first active plan
                final plan = data.plans.firstWhere(
                  (e) => e.isActive == true,
                  orElse: () => data.plans.first,
                );

                /// Initialize values
                selectedTenure = selectedTenure == 0
                    ? plan.availableDurations.first
                    : selectedTenure;

                investmentAmount = investmentAmount == 0
                    ? plan.minInvestment.toDouble()
                    : investmentAmount;

                return _buildUI(plan);

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  /// ================= UI =================

  Widget _buildUI(InvestmentPlanModel plan) {
    double baseRate = plan.baseReturnPercent / 100;
    double multiplier =
        (plan.durationMultipliers[selectedTenure.toString()] ?? 1).toDouble();

    double finalRate = baseRate * multiplier;

    double estimatedReturns =
        investmentAmount * finalRate * (selectedTenure / 12);

    double maturityAmount = investmentAmount + estimatedReturns;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PLAN NAME
            Text(
              plan.planName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.popins,
              ),
            ),

            const SizedBox(height: 20),

            /// INVESTMENT AMOUNT BOX
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xffE9EEF5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text("Investment Amount"),
                  const SizedBox(height: 8),
                  Text(
                    "₹ ${investmentAmount.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Minimum ₹${plan.minInvestment}"),
                Text("Maximum ₹${plan.maxInvestment}"),
              ],
            ),

            const SizedBox(height: 16),

            /// QUICK AMOUNT BUTTONS
            Wrap(
              spacing: 10,
              children: [
                _amountButton(plan.minInvestment.toDouble()),
                _amountButton((plan.minInvestment * 2).toDouble()),
                _amountButton((plan.maxInvestment / 2).toDouble()),
                _amountButton(plan.maxInvestment.toDouble()),
              ],
            ),

            const SizedBox(height: 30),

            /// TENURE SECTION
            const Text(
              "Select Investment Tenure",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 16),

            ...plan.availableDurations.map((year) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _tenureCard(
                  plan,
                  year,
                  estimatedReturns,
                  maturityAmount,
                ),
              );
            }),

            const SizedBox(height: 20),

            /// SUMMARY BOX
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _row(
                    "Total Investment",
                    "₹ ${investmentAmount.toStringAsFixed(0)}",
                  ),
                  const SizedBox(height: 8),
                  _row(
                    "Expected Returns",
                    "₹ ${estimatedReturns.toStringAsFixed(0)}",
                    isGreen: true,
                  ),
                  const SizedBox(height: 8),
                  _row(
                    "Maturity Amount",
                    "₹ ${maturityAmount.toStringAsFixed(0)}",
                    isGreen: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            RoundButton(
              width: double.infinity,
              buttonColor: AppColors.greenColor,
              title: 'Continue',
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _amountButton(double amount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          investmentAmount = amount;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text("₹${(amount / 1000).toStringAsFixed(0)}K"),
      ),
    );
  }

  Widget _tenureCard(
    InvestmentPlanModel plan,
    int year,
    double returns,
    double maturity,
  ) {
    bool isSelected = selectedTenure == year;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTenure = year;
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
        child: Row(
          children: [
            Radio(
              value: year,
              groupValue: selectedTenure,
              onChanged: (value) {
                setState(() {
                  selectedTenure = value!;
                });
              },
            ),
            Text("$year Months"),
            const Spacer(),
            Text("${plan.baseReturnPercent}%"),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isGreen ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}
