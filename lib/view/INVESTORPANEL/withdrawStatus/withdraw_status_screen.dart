import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/INVESTORPANEL/wallet/wallet_bloc.dart';
import '../../../repository/INVESTORPANEL/wallet/wallet_http_repository.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/enums.dart';

class WithdrawalStatusScreen extends StatefulWidget {
  const WithdrawalStatusScreen({super.key});

  @override
  State<WithdrawalStatusScreen> createState() => _WithdrawalStatusScreenState();
}

class _WithdrawalStatusScreenState extends State<WithdrawalStatusScreen> {
  String _selectedTab = 'All';
  late WalletBloc walletBloc;

  @override
  void initState() {
    super.initState();
    walletBloc = WalletBloc(walletRepository: WalletHttpRepository())
      ..add(WalletFetched());
  }

  @override
  void dispose() {
    walletBloc.close();
    super.dispose();
  }

  /// Map API status string → display label, color, tab bucket
  _StatusMeta _getStatusMeta(String apiStatus) {
    switch (apiStatus.toUpperCase()) {
      case 'PAID':
      case 'COMPLETED':
        return _StatusMeta('Paid', Colors.green);
      case 'APPROVED':
        return _StatusMeta('Approved', Colors.orange.shade700);
      case 'REJECTED':
        return _StatusMeta('Rejected', Colors.red);
      case 'PENDING':
      default:
        return _StatusMeta('Pending', Colors.grey.shade600);
    }
  }

  /// Which tab bucket does this status belong to?
  bool _matchesTab(String apiStatus, String tab) {
    if (tab == 'All') return true;
    final upper = apiStatus.toUpperCase();
    if (tab == 'Pending') {
      return upper == 'PENDING' || upper == 'APPROVED';
    }
    if (tab == 'Paid') {
      return upper == 'PAID' || upper == 'COMPLETED';
    }
    return true;
  }

  String _formatDate(String? isoDate) {
    if (isoDate == null) return '—';
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final hour = dt.hour > 12
          ? dt.hour - 12
          : dt.hour == 0
          ? 12
          : dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final ampm = dt.hour >= 12 ? 'PM' : 'AM';
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}, $hour:$minute $ampm';
    } catch (_) {
      return isoDate;
    }
  }

  String _formatPaymentMethod(String? method) {
    if (method == null) return '—';
    return method.replaceAll('_', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => walletBloc,
      child: Scaffold(
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
        body: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, walletState) {
            // ── Loading ──────────────────────────────────────────────────
            if (walletState.wallet.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            // ── Error ────────────────────────────────────────────────────
            if (walletState.wallet.status == Status.error) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red.shade300,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      walletState.wallet.message ?? 'Something went wrong',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.popins,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => walletBloc.add(WalletFetched()),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2BB673),
                      ),
                    ),
                  ],
                ),
              );
            }

            // ── Data ─────────────────────────────────────────────────────
            final requests =
                walletState.wallet.data?.wallet?.withdrawalRequests ?? [];

            // Filter by selected tab
            final filtered = requests
                .where((r) => _matchesTab(r.status ?? '', _selectedTab))
                .toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildStatusTabs(),
                const SizedBox(height: 20),

                if (filtered.isEmpty)
                  _buildEmptyState()
                else
                  ...filtered.map((item) {
                    final meta = _getStatusMeta(item.status ?? '');
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildWithdrawalCard(
                        amount: item.amount ?? 0,
                        ref: item.id ?? '—',
                        status: meta.label,
                        statusColor: meta.color,
                        paymentMethod: _formatPaymentMethod(item.paymentMethod),
                        requestedOn: _formatDate(item.requestedAt),
                        notes: item.notes,
                        apiStatus: item.status ?? '',
                      ),
                    );
                  }),
              ],
            );
          },
        ),
      ),
    );
  }

  // ── Tab bar ─────────────────────────────────────────────────────────────────

  Widget _buildStatusTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [_tabItem('All'), _tabItem('Pending'), _tabItem('Paid')],
      ),
    );
  }

  Widget _tabItem(String title) {
    final isSelected = _selectedTab == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = title),
        child: Container(
          margin: EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.popins,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }

  // ── Empty state ──────────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    final messages = {
      'All': 'No withdrawal requests yet',
      'Pending': 'No pending withdrawals',
      'Paid': 'No completed withdrawals',
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 56,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            messages[_selectedTab] ?? 'No data',
            style: TextStyle(
              fontFamily: AppFonts.popins,
              fontSize: 15,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // ── Card ─────────────────────────────────────────────────────────────────────

  Widget _buildWithdrawalCard({
    required num amount,
    required String ref,
    required String status,
    required Color statusColor,
    required String paymentMethod,
    required String requestedOn,
    String? notes,
    required String apiStatus,
  }) {
    final isPaid =
        apiStatus.toUpperCase() == 'PAID' ||
        apiStatus.toUpperCase() == 'COMPLETED';
    final isRejected = apiStatus.toUpperCase() == 'REJECTED';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount + Status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${_formatAmount(amount)}',
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
                    color: statusColor.withOpacity(0.12),
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

            const SizedBox(height: 4),
            Text(
              'Ref: $ref',
              style: TextStyle(
                fontFamily: AppFonts.popins,
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),

            const Divider(height: 24, thickness: 0.5),

            // Payment method
            _infoRow(Icons.account_balance, 'Payment: $paymentMethod'),
            const SizedBox(height: 8),

            // Requested on
            _infoRow(Icons.calendar_today, 'Requested On: $requestedOn'),

            // Notes (if any and not the default placeholder)
            if (notes != null && notes.isNotEmpty && notes != 'string') ...[
              const SizedBox(height: 8),
              _infoRow(Icons.notes, 'Note: $notes'),
            ],

            const SizedBox(height: 8),

            // Status-specific extra info row
            _infoRow(
              isPaid
                  ? Icons.check_circle_outline
                  : isRejected
                  ? Icons.cancel_outlined
                  : Icons.access_time,
              isPaid
                  ? 'Payment completed'
                  : isRejected
                  ? 'Request rejected'
                  : 'Processing Time: 2–3 Business Days',
              color: isPaid
                  ? Colors.green
                  : isRejected
                  ? Colors.red
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: color ?? Colors.grey),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: AppFonts.popins,
              fontSize: 13,
              color: color ?? Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }

  String _formatAmount(num amount) {
    // Adds comma formatting: 25000 → 25,000
    final str = amount.toStringAsFixed(0);
    final result = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) result.write(',');
      result.write(str[i]);
      count++;
    }
    return result.toString().split('').reversed.join();
  }
}

class _StatusMeta {
  final String label;
  final Color color;
  const _StatusMeta(this.label, this.color);
}
