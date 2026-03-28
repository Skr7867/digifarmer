import 'package:flutter/material.dart';

import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';

class WithdrawalStatusScreen extends StatefulWidget {
  const WithdrawalStatusScreen({super.key});

  @override
  State<WithdrawalStatusScreen> createState() => _WithdrawalStatusScreenState();
}

class _WithdrawalStatusScreenState extends State<WithdrawalStatusScreen> {
  String _selectedTab = 'All'; // 'All', 'Pending', 'Paid'

  // Sample withdrawal data
  final List<WithdrawalItem> _allWithdrawals = [
    WithdrawalItem(
      amount: '₹25,000',
      ref: 'WD2024001234',
      status: 'Paid',
      statusColor: Colors.green,
      bankName: 'HDFC Bank',
      accountSuffix: '4567',
      requestedOn: '12 Dec 2024, 10:30 AM',
      extraInfo: 'Paid On: 14 Dec 2024, 02:15 PM',
      showReceiptButton: true,
    ),
    WithdrawalItem(
      amount: '₹15,500',
      ref: 'WD2024001235',
      status: 'Approved',
      statusColor: Colors.orange.shade700,
      bankName: 'ICICI Bank',
      accountSuffix: '8901',
      requestedOn: '18 Dec 2024, 03:45 PM',
      extraInfo: 'Expected By: 20 Dec 2024',
      showReceiptButton: false,
    ),
    WithdrawalItem(
      amount: '₹10,000',
      ref: 'WD2024001236',
      status: 'Pending',
      statusColor: Colors.grey.shade600,
      bankName: 'HDFC Bank',
      accountSuffix: '4567',
      requestedOn: '20 Dec 2024, 11:20 AM',
      extraInfo: 'Processing Time: 2–3 Business Days',
      showReceiptButton: false,
    ),
  ];

  List<WithdrawalItem> get _filteredWithdrawals {
    if (_selectedTab == 'All') {
      return _allWithdrawals;
    } else if (_selectedTab == 'Pending') {
      return _allWithdrawals
          .where(
            (item) => item.status == 'Pending' || item.status == 'Approved',
          )
          .toList();
    } else if (_selectedTab == 'Paid') {
      return _allWithdrawals.where((item) => item.status == 'Paid').toList();
    }
    return _allWithdrawals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(
        title: 'Withdrawal Status',
        automaticallyImplyLeading: true,
        gradient: const LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tab row: All | Pending | Paid
          _buildStatusTabs(),
          const SizedBox(height: 20),

          // Withdrawal Cards - filtered based on selected tab
          ..._filteredWithdrawals.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildWithdrawalCard(
                amount: item.amount,
                ref: item.ref,
                status: item.status,
                statusColor: item.statusColor,
                bankName: item.bankName,
                accountSuffix: item.accountSuffix,
                requestedOn: item.requestedOn,
                extraInfo: item.extraInfo,
                showReceiptButton: item.showReceiptButton,
              ),
            );
          }),

          if (_selectedTab == 'Approved' ||
              (_selectedTab == 'Pending' && _filteredWithdrawals.isNotEmpty))
            const SizedBox(height: 24),

          // Warning / Info card for approved withdrawal - only show in appropriate tabs
          if (_selectedTab == 'All' || _selectedTab == 'Pending')
            _buildInfoCard(),
        ],
      ),
    );
  }

  Widget _buildStatusTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          _tabItem('All', isSelected: _selectedTab == 'All'),
          _tabItem('Pending', isSelected: _selectedTab == 'Pending'),
          _tabItem('Paid', isSelected: _selectedTab == 'Paid'),
        ],
      ),
    );
  }

  Widget _tabItem(String title, {required bool isSelected}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: isSelected
                ? const Border(bottom: BorderSide(color: Colors.blue, width: 2))
                : null,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.popins,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.blue : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWithdrawalCard({
    required String amount,
    required String ref,
    required String status,
    required Color statusColor,
    required String bankName,
    required String accountSuffix,
    required String requestedOn,
    required String extraInfo,
    required bool showReceiptButton,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade900,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontFamily: AppFonts.popins,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Ref: $ref',
              style: TextStyle(
                fontFamily: AppFonts.popins,
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
            const Divider(height: 24, thickness: 0.5, color: Colors.grey),
            Row(
              children: [
                const Icon(Icons.account_balance, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Bank Account: $bankName ****$accountSuffix',
                    style: TextStyle(
                      fontFamily: AppFonts.popins,
                      fontSize: 13,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'Requested On: $requestedOn',
                  style: TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  status == 'Paid'
                      ? Icons.check_circle_outline
                      : Icons.access_time,
                  size: 14,
                  color: Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  extraInfo,
                  style: TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showReceiptButton)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextButton(
                      onPressed: () {
                        // Handle receipt action
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Receipt',
                        style: TextStyle(
                          fontFamily: AppFonts.popins,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    // Handle view details action
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      fontFamily: AppFonts.popins,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 20,
                color: Colors.orange.shade800,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Your withdrawal has been approved and is being processed. Amount will be credited within 1–2 business days.',
                  style: TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 13,
                    color: Colors.orange.shade900,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Handle cancel action
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.orange.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  // Handle view details action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                ),
                child: Text(
                  'View Details',
                  style: TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Data model for withdrawal items
class WithdrawalItem {
  final String amount;
  final String ref;
  final String status;
  final Color statusColor;
  final String bankName;
  final String accountSuffix;
  final String requestedOn;
  final String extraInfo;
  final bool showReceiptButton;

  WithdrawalItem({
    required this.amount,
    required this.ref,
    required this.status,
    required this.statusColor,
    required this.bankName,
    required this.accountSuffix,
    required this.requestedOn,
    required this.extraInfo,
    required this.showReceiptButton,
  });
}
