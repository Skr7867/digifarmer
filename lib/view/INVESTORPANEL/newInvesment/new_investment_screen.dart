import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/model/INVESTORPANEL/investmentPlan/all_investment_plan_model.dart';
import 'package:digifarmer/res/color/app_colors.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/INVESTORPANEL/allInvestmentPlan/all_investment_plan_bloc.dart';
import '../../../model/INVESTORPANEL/investmentPlan/investment_select_model.dart';
import '../../../utils/enums.dart';

class NewInvestmentScreen extends StatefulWidget {
  const NewInvestmentScreen({super.key});

  @override
  State<NewInvestmentScreen> createState() => _NewInvestmentScreenState();
}

class _NewInvestmentScreenState extends State<NewInvestmentScreen> {
  final TextEditingController amountController = TextEditingController(
    text: "25000",
  );

  int selectedIndex = 0;

  List<int> quickAmounts = [10000, 25000, 50000, 100000];

  /// user entered amount
  int get userAmount =>
      int.tryParse(amountController.text.replaceAll(",", "")) ?? 0;

  /// calculate return based on API per lakh value
  double calculateReturn(InvestmentPlanModel plan) {
    return (userAmount / 100000) * plan.totalReturnOnLakh;
  }

  /// calculate maturity
  double calculateMaturity(InvestmentPlanModel plan) {
    return userAmount + calculateReturn(plan);
  }

  String formatCurrency(num value) {
    return "₹${value.toStringAsFixed(0)}";
  }

  void setAmount(int amount) {
    setState(() {
      amountController.text = amount.toString();
    });
  }

  bool isValidAmount(InvestmentPlanModel plan) {
    return userAmount >= plan.minInvestment && userAmount <= plan.maxInvestment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: CustomAppBar(
        title: 'Organic Rice form',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      body: BlocBuilder<AllInvestmentPlanBloc, AllInvestmentSplanState>(
        builder: (context, state) {
          switch (state.allInvestmentPlan.status) {
            /// LOADING
            case Status.loading:
              return const Center(child: CircularProgressIndicator());

            /// ERROR
            case Status.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.allInvestmentPlan.message ?? "Something went wrong",
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {
                        context.read<AllInvestmentPlanBloc>().add(
                          PlanFetched(),
                        );
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );

            /// SUCCESS
            case Status.completed:
              final AllInvestmentPlanModel response =
                  state.allInvestmentPlan.data!;

              final List<InvestmentPlanModel> plans = response.plans;

              return _buildBody(plans);

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildBody(List<InvestmentPlanModel> plans) {
    final selectedPlan = plans[selectedIndex];

    final totalReturn = calculateReturn(selectedPlan);
    final maturity = calculateMaturity(selectedPlan);

    return Padding(
      padding: const EdgeInsets.all(16),

      child: ListView(
        children: [
          /// ENTER AMOUNT
          const Text(
            "Enter Investment Amount",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xffE8EDF4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text("Investment Amount"),

                const SizedBox(height: 10),

                TextField(
                  controller: amountController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    prefixText: "₹ ",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// MIN MAX
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Minimum ${selectedPlan.minInvestmentFormatted}"),
              Text("Maximum ${selectedPlan.maxInvestmentFormatted}"),
            ],
          ),

          const SizedBox(height: 15),

          /// QUICK AMOUNTS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: quickAmounts.map((amount) {
              return GestureDetector(
                onTap: () => setAmount(amount),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                  ),
                  child: Text(
                    "₹${amount ~/ 1000}K",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 25),

          /// SELECT TENURE
          const Text(
            "Select Investment Tenure",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          ListView.builder(
            itemCount: plans.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final plan = plans[index];
              final isSelected = selectedIndex == index;

              final returnAmount = calculateReturn(plan);
              final maturityAmount = calculateMaturity(plan);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },

                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                      width: 1.5,
                    ),
                    color: Colors.white,
                  ),

                  child: Column(
                    children: [
                      /// PLAN HEADER
                      Row(
                        children: [
                          Radio(
                            value: index,
                            groupValue: selectedIndex,
                            onChanged: (value) {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plan.planName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                Text(
                                  plan.durationFormatted,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${plan.returnPercent}%",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text("per annum"),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// RETURNS BOX
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xffEAF4ED),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Estimated Returns"),
                                Text(
                                  formatCurrency(returnAmount),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("Maturity Amount"),
                                Text(
                                  formatCurrency(maturityAmount),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          /// SUMMARY
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Investment\n${formatCurrency(userAmount)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              Text(
                "Expected Returns\n${formatCurrency(totalReturn)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            "Maturity Amount: ${formatCurrency(maturity)}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 20),

          /// CONTINUE BUTTON
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: isValidAmount(selectedPlan)
                  ? () {
                      final investmentData = InvestmentSelectionModel(
                        plan: selectedPlan,
                        amount: userAmount,
                        expectedReturn: totalReturn,
                        maturityAmount: maturity,
                      );

                      Navigator.pushNamed(
                        context,
                        RoutesName.proceedPaymentScreen,
                        arguments: investmentData,
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Continue to Review →",
                style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
