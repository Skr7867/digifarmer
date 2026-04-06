import 'dart:io';

import 'package:digifarmer/blocs/INVESTORPANEL/investmentDetails/investment_details_bloc.dart';
import 'package:digifarmer/main.dart';
import 'package:digifarmer/model/INVESTORPANEL/investmentDetails/investment_details_model.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/res/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/routes/routes_name.dart';
import '../../../res/color/app_colors.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../utils/enums.dart';

class InvestmentDetailsScreen extends StatefulWidget {
  final String investmentId;

  const InvestmentDetailsScreen({super.key, required this.investmentId});

  @override
  State<InvestmentDetailsScreen> createState() =>
      _InvestmentDetailsScreenState();
}

class _InvestmentDetailsScreenState extends State<InvestmentDetailsScreen>
    with SingleTickerProviderStateMixin {
  late InvestmentDetailsBloc investmentDetailsBloc;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    investmentDetailsBloc = InvestmentDetailsBloc(
      investmentDetailsRepository: getIt(),
    );
    investmentDetailsBloc.add(
      InvestmentDetailsFetched(planId: widget.investmentId),
    );

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    investmentDetailsBloc.close();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _openPdf(String url, String fileName) async {
    try {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // Download PDF
      final response = await http.get(Uri.parse(url));

      // Check if the request was successful
      if (response.statusCode != 200) {
        throw Exception('Failed to download PDF: ${response.statusCode}');
      }

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);

      // Use response.bodyBytes instead of response.body
      await file.writeAsBytes(response.bodyBytes);

      // Close loading dialog
      if (mounted) {
        Navigator.pop(context);
      }

      // Open PDF
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        throw Exception('Failed to open PDF');
      }
    } catch (e) {
      // Close loading dialog if it's still showing
      if (mounted) {
        Navigator.pop(context);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to open PDF: $e',
            style: const TextStyle(fontFamily: AppFonts.popins),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (_) {
      return 'N/A';
    }
  }

  String _formatDateTime(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (_) {
      return 'N/A';
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
      case 'allocated':
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'completed':
      case 'matured':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Color _getRiskColor(String? risk) {
    switch (risk?.toLowerCase()) {
      case 'low':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

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
      body: BlocProvider(
        create: (_) => investmentDetailsBloc,
        child: BlocBuilder<InvestmentDetailsBloc, InvestmentDetailsState>(
          builder: (context, state) {
            switch (state.investmentDetails.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
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
                        state.investmentDetails.message ??
                            'Something went wrong',
                        style: const TextStyle(fontFamily: AppFonts.popins),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          investmentDetailsBloc.add(
                            InvestmentDetailsFetched(
                              planId: widget.investmentId,
                            ),
                          );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );

              case Status.completed:
                final data = state.investmentDetails.data;
                if (data == null || data.investment == null) {
                  return const Center(
                    child: Text(
                      'No investment data found',
                      style: TextStyle(fontFamily: AppFonts.popins),
                    ),
                  );
                }

                final investment = data.investment!;
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderCard(investment),
                        const SizedBox(height: 16),
                        _buildInvestmentMetrics(investment),
                        const SizedBox(height: 16),
                        if (investment.allocations != null &&
                            investment.allocations!.lands != null &&
                            investment.allocations!.lands!.isNotEmpty)
                          _buildLandAllocationCard(investment),
                        SizedBox(height: 16),
                        if (investment.statusTimeline != null &&
                            investment.statusTimeline!.isNotEmpty)
                          _buildTimelineCard(investment),
                        SizedBox(height: 16),
                        _buildInvestmentDetailsCard(investment),
                        const SizedBox(height: 16),
                        _buildActionButtons(investment),
                        const SizedBox(height: 30),
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

  Widget _buildHeaderCard(Investment investment) {
    final statusColor = _getStatusColor(investment.applicationStatus);
    final riskColor = _getRiskColor(investment.riskLevel);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff2FA463), Color(0xff1C5D9F)],
          begin: Alignment.topLeft,
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
                    investment.investmentId ?? 'N/A',
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
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor, width: 1),
                ),
                child: Text(
                  investment.applicationStatus ?? 'N/A',
                  style: TextStyle(
                    color: statusColor,
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
            children: [
              Expanded(
                child: _buildStatCard(
                  'Invested Amount',
                  '₹${NumberFormat('#,##,###').format(investment.investmentAmount ?? 0)}',
                  Colors.white,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _buildStatCard(
                  'Expected Returns',
                  '${investment.expectedReturnPercent?.toStringAsFixed(2) ?? '0'}%',
                  Colors.white,
                  valueColor: Colors.lightGreenAccent,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _buildStatCard(
                  'Duration',
                  '${investment.durationMonths ?? 0} Months',
                  Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeaderInfo(
                  'Plan',
                  investment.planId?.planName ?? 'N/A',
                  Icons.agriculture,
                ),
                _buildHeaderInfo(
                  'Risk Level',
                  investment.riskLevel ?? 'N/A',
                  Icons.warning,
                  valueColor: riskColor,
                ),
                _buildHeaderInfo(
                  'ROI\nFrequency',
                  investment.roiFrequency ?? 'N/A',
                  Icons.timeline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    Color textColor, {
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          softWrap: true,
          title,
          style: TextStyle(
            color: textColor.withOpacity(0.8),
            fontSize: 10,
            fontFamily: AppFonts.popins,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          softWrap: true,
          value,
          style: TextStyle(
            color: valueColor ?? textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.popins,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderInfo(
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white70),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              softWrap: true,
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontFamily: AppFonts.popins,
                fontWeight: .bold,
              ),
            ),
            Text(
              softWrap: true,
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.popins,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInvestmentMetrics(Investment investment) {
    final progress = _calculateProgress(
      investment.startDate,
      investment.endDate,
    );

    return Container(
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
            'Investment Progress',
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
              _buildMetricItem(
                'Start Date',
                _formatDate(investment.startDate),
                Icons.play_circle,
              ),
              _buildMetricItem(
                'End Date',
                _formatDate(investment.endDate),
                Icons.flag,
              ),
              _buildMetricItem(
                'Maturity Date',
                _formatDate(investment.maturityDate),
                Icons.calendar_today,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (progress > 0 && progress < 1) ...[
            const Text(
              'Investment Duration Progress',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontFamily: AppFonts.popins,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: Colors.green,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress * 100).toStringAsFixed(1)}% Completed',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.popins,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.green.shade700),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontFamily: AppFonts.popins,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.popins,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // _buildLandAllocationCard method to pass images

  Widget _buildLandAllocationCard(Investment investment) {
    final lands = investment.allocations!.lands!;

    // ✅ Get task images from investment.taskImages instead of land images
    final taskImageList = investment.taskImages?.allImages ?? [];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Land Allocation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
              // ✅ Show Photos button only if task images exist
              if (taskImageList.isNotEmpty)
                RoundButton(
                  fontSize: 10,
                  height: 20,
                  width: 80,
                  buttonColor: AppColors.greenColor,
                  title: 'Task Photos',
                  onPress: () {
                    // ✅ Navigate with TaskImage list instead of String list
                    Navigator.pushNamed(
                      context,
                      RoutesName.landImagesScreen,
                      arguments: {
                        'taskImages': taskImageList, // ✅ pass TaskImage objects
                        'landTitle': 'Task Photos',
                        'initialIndex': 0,
                      },
                    );
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),
          ...lands.map((land) => _buildLandCard(land)),
        ],
      ),
    );
  }

  Widget _buildLandCard(Lands land) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.landscape,
                  size: 20,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      land.landId?.landTitle ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                    Text(
                      '${land.landId?.city ?? 'N/A'}, ${land.landId?.state ?? 'N/A'}',
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${land.allocationPercent ?? 0}%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                    fontFamily: AppFonts.popins,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildLandDetail(
                Icons.straighten,
                'Area',
                '${land.landId?.totalSize ?? 0} ${land.landId?.areaUnit ?? 'Acres'}',
              ),
              const SizedBox(width: 12),
              _buildLandDetail(
                Icons.attach_money,
                'Allocated',
                '₹${NumberFormat('#,##,###').format(land.allocatedAmount ?? 0)}',
              ),
            ],
          ),
          if (land.crops != null && land.crops!.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text(
              'Crops',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontFamily: AppFonts.popins,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: land.crops!.map((crop) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    crop.type ?? 'N/A',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange.shade800,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLandDetail(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  fontFamily: AppFonts.popins,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(Investment investment) {
    return Container(
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
            'Status Timeline',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 16),
          ...investment.statusTimeline!.asMap().entries.map((entry) {
            final index = entry.key;
            final timeline = entry.value;
            final isLast = index == investment.statusTimeline!.length - 1;

            return _buildTimelineItem(timeline, isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(StatusTimeline timeline, bool isLast) {
    final statusColor = _getStatusColor(timeline.status);

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
                  color: statusColor,
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white, size: 14),
                ),
              ),
              if (!isLast)
                Container(width: 2, height: 40, color: Colors.grey.shade300),
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
                      timeline.status ?? 'N/A',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatDateTime(timeline.updatedAt),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        fontFamily: AppFonts.popins,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  timeline.note ?? 'N/A',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    fontFamily: AppFonts.popins,
                  ),
                ),
                if (timeline.updatedBy != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'By: ${timeline.updatedBy}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                      fontFamily: AppFonts.popins,
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

  Widget _buildInvestmentDetailsCard(Investment investment) {
    return Container(
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
            'Investment Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.popins,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            'Payment Status',
            investment.paymentStatus ?? 'N/A',
            _getStatusColor(investment.paymentStatus),
          ),
          _buildDetailRow(
            'Payment Method',
            investment.paymentMethod ?? 'N/A',
            Colors.blue,
          ),
          _buildDetailRow(
            'Paid Amount',
            '₹${NumberFormat('#,##,###').format(investment.paidAmount ?? 0)}',
            Colors.green,
          ),
          if (investment.paidAt != null)
            _buildDetailRow(
              'Paid On',
              _formatDateTime(investment.paidAt),
              Colors.grey,
            ),
          if (investment.adminRemarks != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 20, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Admin Remarks',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            investment.adminRemarks!,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
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
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontFamily: AppFonts.popins,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor,
              fontFamily: AppFonts.popins,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Investment investment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                if (investment.agreementPdfUrl != null &&
                    investment.agreementPdfUrl!.isNotEmpty) {
                  _openPdf(
                    investment.agreementPdfUrl!,
                    'agreement_${investment.investmentId}.pdf',
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No agreement available'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.picture_as_pdf_outlined,
                color: AppColors.greenColor,
              ),
              label: Text(
                'View Agreement',
                style: TextStyle(
                  fontFamily: AppFonts.popins,
                  color: AppColors.greenColor,
                ),
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
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutesName.workerHelpSupportScreen,
                );
              },
              icon: const Icon(Icons.support_agent, color: Colors.white),
              label: const Text(
                'Contact Support',
                style: TextStyle(
                  fontFamily: AppFonts.popins,
                  color: Colors.white,
                ),
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
    );
  }

  double _calculateProgress(String? startDate, String? endDate) {
    if (startDate == null || endDate == null) return 0;
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      final now = DateTime.now();

      if (now.isBefore(start)) return 0;
      if (now.isAfter(end)) return 1;

      final totalDuration = end.difference(start).inDays;
      final elapsed = now.difference(start).inDays;

      return elapsed / totalDuration;
    } catch (_) {
      return 0;
    }
  }
}
