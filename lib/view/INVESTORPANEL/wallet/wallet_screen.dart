import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../blocs/INVESTORPANEL/kycStatus/kyc_status_bloc.dart';
import '../../../blocs/INVESTORPANEL/wallet/wallet_bloc.dart';
import '../../../blocs/INVESTORPANEL/withdrawalAmount/withdrawal_amount_bloc.dart';
import '../../../repository/INVESTORPANEL/kycStatus/kyc_status_http_repository.dart';
import '../../../repository/INVESTORPANEL/wallet/wallet_http_repository.dart';
import '../../../res/color/app_colors.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../utils/enums.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final TextEditingController _amountController = TextEditingController(
    text: "0",
  );

  int selectedBankIndex = 0;
  int selectedQuickAmount = -1;
  late KycStatusBloc kycStatusBloc;
  late WalletBloc walletBloc;
  late WithdrawalAmountBloc withdrawalAmountBloc;

  final List<int> quickAmounts = [5000, 10000, 25000, 50000];

  @override
  void initState() {
    super.initState();
    kycStatusBloc = KycStatusBloc(
      kycStatusRepository: KycStatusHttpRepository(),
    )..add(KycStatusFetched());

    walletBloc = WalletBloc(walletRepository: WalletHttpRepository())
      ..add(WalletFetched());

    withdrawalAmountBloc = GetIt.instance<WithdrawalAmountBloc>();
  }

  @override
  void dispose() {
    kycStatusBloc.close();
    walletBloc.close();
    withdrawalAmountBloc.close();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: CustomAppBar(
        title: 'Withdraw Funds',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => kycStatusBloc),
          BlocProvider(create: (_) => walletBloc),
          BlocProvider(create: (_) => withdrawalAmountBloc),
        ],
        child: Builder(
          builder: (context) {
            // This builder ensures we have the correct context with all providers
            return BlocBuilder<KycStatusBloc, KycStatusState>(
              builder: (BuildContext context, kycState) {
                return BlocBuilder<WalletBloc, WalletState>(
                  builder: (BuildContext context, walletState) {
                    return BlocConsumer<
                      WithdrawalAmountBloc,
                      WithdrawalAmountState
                    >(
                      // REPLACE your existing listener block:
                      // WITH this — dismisses the loading dialog, then navigates or shows error:
                      listener: (context, withdrawalState) {
                        if (withdrawalState.postApiStatus ==
                            PostApiStatus.success) {
                          Navigator.pop(context); // ✅ closes the loading dialog
                          FlushBarHelper.flushBarSuccessMessage(
                            withdrawalState.message,
                            context,
                          );
                          walletBloc.add(WalletFetched());
                          withdrawalAmountBloc.add(ResetWithdrawalState());
                          _amountController.text = "0";
                          setState(() {
                            selectedQuickAmount = -1;
                          });
                          Navigator.pushNamed(
                            context,
                            RoutesName.withdrawScreen,
                          );
                        } else if (withdrawalState.postApiStatus ==
                            PostApiStatus.error) {
                          Navigator.pop(
                            context,
                          ); // ✅ closes the loading dialog on error too
                          FlushBarHelper.flushBarErrorMessage(
                            withdrawalState.message,
                            context,
                          );
                        }
                      },
                      builder: (context, withdrawalState) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Balance Card
                              _balanceCard(walletState),

                              const SizedBox(height: 20),

                              /// Withdrawal Amount
                              Text(
                                "Withdrawal Amount",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                              const SizedBox(height: 8),

                              TextField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,

                                onChanged: (value) {
                                  setState(() {
                                    if (selectedQuickAmount != -1) {
                                      selectedQuickAmount = -1;
                                    }
                                  });
                                  // Update BLoC with amount - using the context from builder
                                  context.read<WithdrawalAmountBloc>().add(
                                    AmountChanged(value),
                                  );
                                },
                                decoration: InputDecoration(
                                  prefixText: "₹ ",

                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Min: ₹1000",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "Withdraw Max",
                                    style: TextStyle(
                                      color: Color(0xff1E8E5A),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              /// Quick Select
                              const Text(
                                "Quick Select",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 10),

                              Wrap(
                                spacing: 10,
                                children: List.generate(
                                  quickAmounts.length,
                                  (index) => _quickAmountButton(context, index),
                                ),
                              ),

                              const SizedBox(height: 25),

                              const SizedBox(height: 20),

                              /// Info Box
                              _infoBox(),

                              const SizedBox(height: 20),
                              _bottomSection(
                                context,
                                kycState,
                                walletState,
                                withdrawalState,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _balanceCard(WalletState walletState) {
    String availableBalance = "0";
    String lockedBalance = "0";
    String withdrawableBalance = "0";
    String totalROI = "0";

    if (walletState.wallet.status == Status.completed &&
        walletState.wallet.data != null) {
      final walletData = walletState.wallet.data!;
      availableBalance = walletData.wallet!.availableBalance.toString();
      lockedBalance = walletData.wallet!.lockedBalance.toString();
      totalROI = walletData.wallet!.totalROIEarned.toString();

      // Withdrawable balance = availableBalance + totalROI earned
      final withdrawable = walletData.wallet!.totalROIEarned.toString();
      withdrawableBalance = withdrawable.toString();
    } else if (walletState.wallet.status == Status.loading) {
      availableBalance = "...";
      lockedBalance = "...";
      withdrawableBalance = "...";
      totalROI = "...";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff1C5D9F), Color(0xff2FA463)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Available Balance",
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: AppFonts.popins,
                ),
              ),
              RoundButton(
                width: 70,
                height: 30,
                fontSize: 12,
                buttonColor: AppColors.whiteColor.withValues(alpha: 0.2),
                title: 'Status',
                onPress: () {
                  Navigator.pushNamed(context, RoutesName.withdrawScreen);
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "₹$availableBalance",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Locked Amount: ₹$lockedBalance\nWithdrawable: ₹$withdrawableBalance\nTotal ROI Earned: ₹$totalROI",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickAmountButton(BuildContext context, int index) {
    final isSelected = selectedQuickAmount == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedQuickAmount = index;
          final amount = quickAmounts[index].toString();
          _amountController.text = amount;
        });
        // Update BLoC with selected amount - using the provided context
        context.read<WithdrawalAmountBloc>().add(
          AmountChanged(quickAmounts[index].toString()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff1E8E5A) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "₹${quickAmounts[index] ~/ 1000}K",
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.popins,
          ),
        ),
      ),
    );
  }

  Widget _infoBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Withdrawal Information",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.popins,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "• Processing time: 2-3 business days\n"
            "• No withdrawal charges\n"
            "• Minimum withdrawal ₹1000",
            style: TextStyle(fontSize: 12, fontFamily: AppFonts.popins),
          ),
        ],
      ),
    );
  }

  Widget _bottomSection(
    BuildContext context,
    KycStatusState kycState,
    WalletState walletState,
    WithdrawalAmountState withdrawalState,
  ) {
    final amount = int.tryParse(_amountController.text) ?? 0;

    // Get withdrawable balance from wallet
    num maxWithdrawable = 1000;
    if (walletState.wallet.status == Status.completed &&
        walletState.wallet.data != null) {
      final walletData = walletState.wallet.data!;
      maxWithdrawable =
          (walletData.wallet?.availableBalance ?? 0) +
          (walletData.wallet?.totalROIEarned ?? 0);
    }

    final receiveAmount = amount > maxWithdrawable ? maxWithdrawable : amount;

    bool isKycCompleted = false;
    String buttonText = "Proceed to Withdraw";
    VoidCallback? onPressed;

    // Check if withdrawal is in progress
    final isLoading = withdrawalState.postApiStatus == PostApiStatus.loading;

    if (kycState.kycStatus.status == Status.completed &&
        kycState.kycStatus.data != null) {
      final kycStatus =
          kycState.kycStatus.data!.data?.kycStatus ?? 'NOT_STARTED';

      // Check if KYC is completed (either COMPLETED, VERIFIED, or APPROVED)
      isKycCompleted =
          (kycStatus == 'COMPLETED' ||
          kycStatus == 'VERIFIED' ||
          kycStatus == 'APPROVED');

      if (isKycCompleted) {
        // ✅ KYC completed - allow withdrawal
        buttonText = isLoading ? "Processing..." : "Proceed to Withdraw";

        onPressed = isLoading
            ? null
            : () {
                if (amount >= 1000) {
                  if (amount > maxWithdrawable) {
                    FlushBarHelper.flushBarErrorMessage(
                      'Maximum withdrawal amount is ₹$maxWithdrawable',
                      context,
                    );
                  } else if (amount <= 0) {
                    FlushBarHelper.flushBarErrorMessage(
                      'Please enter a valid amount',
                      context,
                    );
                  } else {
                    // Show confirmation dialog before withdrawal
                    _showWithdrawalConfirmationDialog(context, amount);
                  }
                } else if (amount > 0 && amount < 1000) {
                  FlushBarHelper.flushBarErrorMessage(
                    'Minimum withdrawal amount is ₹1000',
                    context,
                  );
                } else {
                  FlushBarHelper.flushBarErrorMessage(
                    'Please enter withdrawal amount',
                    context,
                  );
                }
              };
      } else {
        // KYC not completed - handle based on status
        if (kycStatus == "DOCUMENTS_PENDING") {
          buttonText = "Upload Your Documents";
          onPressed = () {
            Navigator.pushNamed(context, RoutesName.uploadDocumentScreen);
          };
        } else if (kycStatus == "UNDER_REVIEW") {
          buttonText = "Check Your KYC Verification Status";
          onPressed = () {
            Navigator.pushNamed(
              context,
              RoutesName.kycVerificationStatusScreen,
            );
          };
        } else if (kycStatus == "REJECTED") {
          buttonText = "Re-submit KYC Documents";
          onPressed = () {
            Navigator.pushNamed(context, RoutesName.identityVerificationScreen);
          };
        } else {
          buttonText = "Complete Your KYC";
          onPressed = () {
            Navigator.pushNamed(context, RoutesName.identityVerificationScreen);
          };
        }
      }
    } else if (kycState.kycStatus.status == Status.loading) {
      buttonText = "Verifying KYC...";
      onPressed = null;
    } else if (kycState.kycStatus.status == Status.error) {
      buttonText = "Retry KYC Verification";
      onPressed = () {
        kycStatusBloc.add(KycStatusFetched());
      };
    } else {
      buttonText = "Complete Your KYC";
      onPressed = () {
        Navigator.pushNamed(context, RoutesName.identityVerificationScreen);
      };
    }

    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "You will receive",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              "₹$receiveAmount",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Show warning message for insufficient amount
        if (amount < 1000 && amount > 0 && !isLoading && isKycCompleted)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: Colors.orange.shade700,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Minimum withdrawal amount is ₹1000',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

        // Show warning message for exceeding withdrawable amount
        if (amount > maxWithdrawable &&
            amount > 0 &&
            maxWithdrawable > 0 &&
            !isLoading &&
            isKycCompleted)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: Colors.orange.shade700,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Maximum withdrawal amount is ₹$maxWithdrawable',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

        // Show KYC warning message if not completed
        if (!isKycCompleted &&
            kycState.kycStatus.status == Status.completed &&
            !isLoading)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: Colors.orange.shade700,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'KYC verification required to withdraw funds',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2BB673),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onPressed,
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    buttonText,
                    style: TextStyle(
                      fontFamily: AppFonts.popins,
                      color: AppColors.whiteColor,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  void _showWithdrawalConfirmationDialog(BuildContext blocContext, int amount) {
    showDialog(
      context: blocContext,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Withdrawal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Amount: ₹$amount'),
              const SizedBox(height: 8),
              const Text('Payment Method: Bank Transfer'),
              const SizedBox(height: 8),
              const Text(
                'This action cannot be undone.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext); // close confirm dialog
                _processWithdrawal(
                  blocContext,
                ); // ✅ pass bloc context, not dialog context
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2BB673),
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  // WITH this fixed version:
  void _processWithdrawal(BuildContext blocContext) {
    // ✅ Dispatch using the BlocProvider context BEFORE showing dialog
    blocContext.read<WithdrawalAmountBloc>().add(SubmitWithdrawal());

    showDialog(
      context: blocContext,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const AlertDialog(
          title: Text('Payment Processing'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Processing your withdrawal request...'),
            ],
          ),
        );
      },
    );
  }
}
