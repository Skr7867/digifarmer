import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../res/color/app_colors.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';

class InvestmentDetailsScreen extends StatefulWidget {
  const InvestmentDetailsScreen({super.key});

  @override
  State<InvestmentDetailsScreen> createState() =>
      _InvestmentDetailsScreenState();
}

class _InvestmentDetailsScreenState extends State<InvestmentDetailsScreen> {
  final Map<String, dynamic> investmentData = {
    'investmentId': 'AGR-2024-001',
    'currentValue': 26750,
    'totalGain': 1750,
    'gainPercentage': 7.0,
    'investedAmount': 25000,
    'expectedReturn': 12.0,
    'timeRemaining': 8,
    'location': 'Nashik, Maharashtra',
    'area': '2.5 Acres',
    'irrigation': 'Drip System',
    'soilType': 'Clay Loam',
    'landOwner': 'Rajesh Patil',
    'plantingDate': DateTime(2024, 3, 15),
    'harvestDate': DateTime(2024, 6, 20),
    'growthStage': 'Vegetative',
    'growthPercentage': 60,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: CustomAppBar(
        title: 'Investment Details',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats Card
            Container(
              // margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff2FA463), Color(0xff2FA463)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Investment ID',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Farm ID: ${investmentData['investmentId']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard(
                        'Current Value',
                        '₹${NumberFormat('#,##,###').format(investmentData['currentValue'])}',
                        Colors.white,
                      ),
                      _buildStatCard(
                        'Total Gain',
                        '₹${NumberFormat('#,##,###').format(investmentData['totalGain'])} (${investmentData['gainPercentage']}%)',
                        Colors.white,
                        valueColor: Colors.lightGreenAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Farm Progress Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  const Text(
                    'Farm Progress',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildProgressStep('Week 1', 1, 8, 0),
                      _buildProgressStep('Week 4', 4, 8, 1),
                      _buildProgressStep('Week 8', 8, 8, 2),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Land Information Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  const Text(
                    'Land Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    Icons.location_on_outlined,
                    'Location',
                    investmentData['location'],
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.agriculture,
                    'Area',
                    investmentData['area'],
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.water_drop_outlined,
                    'Irrigation',
                    investmentData['irrigation'],
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.landscape,
                    'Soil Type',
                    investmentData['soilType'],
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Land Owner',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: AppFonts.popins,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              investmentData['landOwner'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.popins,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.phone, size: 16),
                        label: const Text(
                          'Contact',
                          style: TextStyle(fontFamily: AppFonts.popins),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Crop Status Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  const Text(
                    'Crop Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStatusRow(
                    'Planting Completed',
                    DateFormat(
                      'MMM dd, yyyy',
                    ).format(investmentData['plantingDate']),
                    Icons.check_circle,
                    Colors.green,
                  ),
                  const SizedBox(height: 12),
                  _buildStatusRow(
                    'Growth Stage',
                    '${investmentData['growthStage']} - ${investmentData['growthPercentage']}% Complete',
                    Icons.trending_up,
                    Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildStatusRow(
                    'Expected Harvest',
                    DateFormat(
                      'MMM dd, yyyy',
                    ).format(investmentData['harvestDate']),
                    Icons.calendar_today,
                    Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.green, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${investmentData['timeRemaining']} days left',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFonts.popins,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Investment Timeline Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  const Text(
                    'Investment Timeline',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTimelineItem(
                    'Investment Confirmed',
                    'Jan 15, 2024',
                    '₹25,000 invested in organic rice farming',
                    true,
                  ),
                  _buildTimelineItem(
                    'Land Preparation',
                    'Feb 10, 2024',
                    'Soil testing and field preparation completed',
                    true,
                  ),
                  _buildTimelineItem(
                    'Seeds Planted',
                    'Mar 15, 2024',
                    'Organic rice seedlings planted successfully',
                    true,
                  ),
                  _buildTimelineItem(
                    'Growth Monitoring',
                    'in Progress',
                    'Regular monitoring and care in progress',
                    false,
                    isActive: true,
                  ),
                  _buildTimelineItem(
                    'Harvest & Returns',
                    'Jun 20, 2024',
                    'Expected harvest and profit distribution',
                    false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Investment Metrics Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  const Text(
                    'Investment Metrics',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMetricRow(
                    'Invested Amount',
                    '₹${NumberFormat('#,##,###').format(investmentData['investedAmount'])}',
                  ),
                  _buildMetricRow(
                    'Current Value',
                    '₹${NumberFormat('#,##,###').format(investmentData['currentValue'])}',
                    valueColor: Colors.green,
                  ),
                  _buildMetricRow(
                    'Expected Return',
                    '${investmentData['expectedReturn']}% p.a.',
                  ),
                  _buildMetricRow(
                    'Time Remaining',
                    '${investmentData['timeRemaining']} months',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.contractSignScreen);
                      },
                      icon:  Icon(Icons.picture_as_pdf_outlined,color: AppColors.greenColor),
                      label:  Text(
                        'View Agreement',
                        style: TextStyle(fontFamily: AppFonts.popins, color: AppColors.greenColor),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.support_agent, color: AppColors.whiteColor,),
                      label: const Text(
                        'Contact Support',
                        style: TextStyle(fontFamily: AppFonts.popins, color: AppColors.whiteColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    Color textColor, {
    Color? valueColor,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor.withOpacity(0.8),
              fontSize: 12,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(
    String label,
    int currentWeek,
    int totalWeeks,
    int index,
  ) {
    bool isCompleted = currentWeek <= 8;
    bool isActive = currentWeek == 8;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? Colors.green : Colors.grey.shade200,
              border: Border.all(
                color: isActive ? Colors.green : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                isCompleted ? Icons.check : Icons.hourglass_empty,
                color: isCompleted ? Colors.white : Colors.grey,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isCompleted ? Colors.green : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.green.shade700),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontFamily: AppFonts.popins,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontFamily: AppFonts.popins,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    String title,
    String date,
    String description,
    bool isCompleted, {
    bool isActive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted || isActive
                      ? Colors.green
                      : Colors.grey.shade300,
                ),
                child: Center(
                  child: Icon(
                    isCompleted ? Icons.check : Icons.access_time,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
              if (title != 'Harvest & Returns')
                Container(
                  width: 2,
                  height: 40,
                  color: isCompleted ? Colors.green : Colors.grey.shade300,
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.w600,
                        color: isActive ? Colors.green : Colors.black,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }
}
