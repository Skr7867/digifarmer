import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/color/app_colors.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/INVESTORPANEL/planPurchase/plan_purchase_bloc.dart';
import '../../../model/INVESTORPANEL/investmentPlan/investment_select_model.dart';
import '../../../model/INVESTORPANEL/planPurchase/purchase_plan_request_model.dart';
import '../../../utils/enums.dart';
import 'investment_growth_screen.dart';

class ProceedToPaymentScreen extends StatelessWidget {
  final InvestmentSelectionModel investment;

  const ProceedToPaymentScreen({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    final plan = investment.plan;
    final amount = investment.amount;
    final returns = investment.expectedReturn;
    final maturity = investment.maturityAmount;

    return BlocConsumer<PurchasePlanBloc, PurchasePlanState>(
      listener: (context, state) {
        if (state.purchaseResponse.status == Status.completed) {
          Navigator.pushNamed(
            context,
            RoutesName.paymentScreen,
            arguments: state.purchaseResponse.data,
          );
        }

        if (state.purchaseResponse.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.purchaseResponse.message ?? "Something went wrong",
              ),
            ),
          );
        }
      },

      builder: (context, state) {
        final isLoading = state.purchaseResponse.status == Status.loading;

        return Stack(
          children: [
            Scaffold(
              backgroundColor: const Color(0xffF5F7FA),

              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ================= HEADER =================
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 2, 34, 75),
                            Color(0xff1C5DC9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(height: 80),

                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.energy_savings_leaf_sharp,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(width: 12),

                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Organic Rice Farm",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                  Text(
                                    "Maharashtra",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                ],
                              ),

                              const Spacer(),

                              const Icon(Icons.share, color: Colors.white),
                            ],
                          ),

                          const SizedBox(height: 20),

                          /// INVESTMENT SUMMARY
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                /// Amount
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Investment Amount",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontFamily: AppFonts.popins,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "₹${amount.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.popins,
                                      ),
                                    ),
                                  ],
                                ),

                                /// Tenure
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Tenure Selected",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontFamily: AppFonts.popins,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      plan.durationFormatted,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.popins,
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

                    const SizedBox(height: 20),

                    /// ================= SUMMARY CARD =================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 170,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: const Color(0xffE8F5E9),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.greenColor.withValues(alpha: 0.2),
                          ),
                        ),

                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor.withValues(
                                    alpha: .24,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.trending_up,
                                  color: Colors.green,
                                ),
                              ),

                              title: const Text(
                                "Maturity Amount",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),

                              subtitle: Text(
                                "₹${maturity.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),

                              trailing: Column(
                                children: [
                                  const SizedBox(height: 9),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.greenColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      "+${returns.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontFamily: AppFonts.popinsBold,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const Text(
                                    'Total Growth',
                                    style: TextStyle(
                                      fontFamily: AppFonts.popins,
                                      color: Colors.blueGrey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total Returns",
                                    style: TextStyle(
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                  Text(
                                    "₹${returns.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 6),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Annual ROI",
                                    style: TextStyle(
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                  Text(
                                    "${plan.returnPercent}%",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.popins,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// CHART
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Investment Growth Projection",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: AppFonts.popins,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    AttractivePieChart(
                      investment: amount.toDouble(),
                      returns: returns,
                      maturity: maturity,
                    ),

                    const SizedBox(height: 30),

                    /// ================= BUY PLAN BUTTON =================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RoundButton(
                        buttonColor: AppColors.greenColor,
                        width: double.infinity,
                        title: 'Buy Plan',
                        onPress: () {
                          final request = PurchasePlanRequestModel(
                            planId: plan.id,
                            planName: plan.planName,
                            investmentAmount: amount,
                            durationMonths: plan.durationMonths,
                            roiFrequency: plan.roiFrequency,
                            startDate: "2026-03-01",
                            riskLevel: plan.riskLevel,
                            lockInPeriodMonths: plan.lockInPeriodMonths,
                            prematureExitAllowed: plan.prematureExitAllowed,
                            prematureExitPenalty: plan.prematureExitPenalty,
                            expectedReturnPercent: plan.returnPercent
                                .toDouble(),
                            maturityAmount: maturity,
                            totalReturn: returns,
                          );

                          context.read<PurchasePlanBloc>().add(
                            PurchasePlanSubmitted(request),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            /// Loader Overlay
            if (isLoading) const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}
