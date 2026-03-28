import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/INVESTORPANEL/kycStatus/kyc_status_bloc.dart';
import '../../../repository/INVESTORPANEL/kycStatus/kyc_status_http_repository.dart';
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

  final List<int> quickAmounts = [5000, 10000, 25000, 50000];

  @override
  void initState() {
    super.initState();
    kycStatusBloc = KycStatusBloc(
      kycStatusRepository: KycStatusHttpRepository(),
    )..add(KycStatusFetched());
  }

  @override
  void dispose() {
    kycStatusBloc.close();
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
      body: BlocProvider(
        create: (_) => kycStatusBloc,
        child: BlocBuilder<KycStatusBloc, KycStatusState>(
          builder: (BuildContext context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Balance Card
                  _balanceCard(),

                  const SizedBox(height: 20),

                  /// Withdrawal Amount
                  const Text(
                    "Withdrawal Amount",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Min: ₹500",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
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
                      (index) => _quickAmountButton(index),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const SizedBox(height: 20),

                  /// Info Box
                  _infoBox(),

                  const SizedBox(height: 20),
                  _bottomSection(state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _balanceCard() {
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
                  // Refresh KYC status when clicking status button
                  // kycStatusBloc.add(KycStatusFetched());
                  Navigator.pushNamed(context, RoutesName.withdrawScreen);
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            "₹1,24,500",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Locked Amount: ₹75,000\nWithdrawable: ₹49,500",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickAmountButton(int index) {
    final isSelected = selectedQuickAmount == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedQuickAmount = index;
          _amountController.text = quickAmounts[index].toString();
        });
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
            "• Minimum withdrawal ₹500",
            style: TextStyle(fontSize: 12, fontFamily: AppFonts.popins),
          ),
        ],
      ),
    );
  }

  Widget _bottomSection(KycStatusState state) {
    final amount = int.tryParse(_amountController.text) ?? 0;
    final receiveAmount = amount;
    bool isKycCompleted = false;
    String buttonText = "Proceed to Withdraw";
    VoidCallback? onPressed;

    if (state.kycStatus.status == Status.completed &&
        state.kycStatus.data != null) {
      final kycStatus = state.kycStatus.data!.data?.kycStatus ?? 'NOT_STARTED';

      isKycCompleted = (kycStatus == 'COMPLETED' || kycStatus == 'VERIFIED');

      if (isKycCompleted) {
        // ✅ KYC completed
        buttonText = "Proceed to Withdraw";

        onPressed = () {
          if (amount >= 500) {
            Navigator.pushNamed(context, RoutesName.identityVerificationScreen);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Minimum withdrawal amount is ₹500'),
                backgroundColor: Colors.red,
              ),
            );
          }
        };
      } else {
        if (kycStatus == "DOCUMENTS_PENDING") {
          buttonText = "Upload Your Documents";
        } else if (kycStatus == "UNDER_REVIEW") {
          buttonText = "Check Your KYC Verification Status";
        } else {
          buttonText = "Complete Your KYC";
        }

        onPressed = () {
          if (kycStatus == "DOCUMENTS_PENDING") {
            Navigator.pushNamed(context, RoutesName.uploadDocumentScreen);
          } else if (kycStatus == "UNDER_REVIEW") {
            Navigator.pushNamed(
              context,
              RoutesName.kycVerificationStatusScreen,
            );
          } else {
            Navigator.pushNamed(context, RoutesName.identityVerificationScreen);
          }
        };
      }
    } else if (state.kycStatus.status == Status.loading) {
      buttonText = "Verifying KYC...";
      onPressed = null;
    } else if (state.kycStatus.status == Status.error) {
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
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "You will receive",
              style: TextStyle(fontWeight: .bold, fontSize: 16),
            ),
            Text(
              "₹$receiveAmount",
              style: TextStyle(fontWeight: .bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Show warning message for insufficient amount
        if (amount < 500 && amount > 0)
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
                    'Minimum withdrawal amount is ₹500',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

        // Show KYC warning message if not completed
        if (!isKycCompleted && state.kycStatus.status == Status.completed)
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
            child: Text(
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
}
