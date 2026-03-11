import 'package:digifarmer/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../../res/color/app_colors.dart';
import '../../../service/storage/local_storage.dart';

class WorkerProfileScreen extends StatefulWidget {
  WorkerProfileScreen({super.key});

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  Future<void> _showLogoutDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _performLogout() async {
    LocalStorage localStorage = LocalStorage();
    await localStorage.clearValue('token');
    await localStorage.clearValue('isLogin');
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.userLoginScreen,
        (route) => false,
      );
    }
  }

  // User data
  final Map<String, dynamic> userData = {
    'name': 'Priya Sharma',
    'role': 'Investor',
    'kycStatus': 'KYC Verified',
    'personalDetails': {
      'fullName': 'Priya Sharma',
      'dob': '15/08/1990',
      'mobile': '+91 98765 43210',
      'email': 'priya.sharma@email.com',
      'address': '123 Green Valley, Sector 15, Gurgaon, Haryana - 122001',
    },
    'documents': {'pan': 'ABCDE1234F', 'aadhaar': '**** **** 5678'},
    'bankDetails': {
      'accountNumber': '****1234',
      'bankName': 'HDFC Bank',
      'ifsc': 'HDFC0001234',
      'upiId': 'priya@hdfc',
    },
  };

  // KYC Status items
  final List<Map<String, dynamic>> kycItems = [
    {'label': 'Approved', 'completed': false},
    {'label': 'Personal Details', 'completed': true},
    {'label': 'Bank Details', 'completed': true},
    {'label': 'Document Upload', 'completed': true},
  ];

  void _handleEdit() {
    debugPrint('Edit profile tapped');
  }

  void _handleChangePIN() {
    debugPrint('Change PIN tapped');
  }

  void _handleBiometricToggle(bool value) {
    debugPrint('Biometric login toggled: $value');
  }

  void _handleNotificationSettings() {
    debugPrint('Notification settings tapped');
  }

  void _handleLanguageChange() {
    debugPrint('Language change tapped');
  }

  void _handleLogout() {
    debugPrint('Logout tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E1E1E),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.workerSettingScreen);
            },
            color: const Color(0xFF666666),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Header Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF2E7D32).withOpacity(0.8),
                        const Color(0xFF1B5E20),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'PS',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['name'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            userData['role'],
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF666666),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFCCCCCC),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.verified,
                                  size: 14,
                                  color: Color(0xFF2E7D32),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  userData['kycStatus'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                              ],
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

          // KYC Status Section
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'KYC Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
                const SizedBox(height: 16),
                ...kycItems.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: item['completed']
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFCCCCCC),
                              width: 2,
                            ),
                            color: item['completed']
                                ? const Color(0xFF2E7D32)
                                : Colors.transparent,
                          ),
                          child: item['completed']
                              ? const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item['label'],
                          style: TextStyle(
                            fontSize: 14,
                            color: item['completed']
                                ? const Color(0xFF1E1E1E)
                                : const Color(0xFF999999),
                            fontWeight: item['completed']
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Personal Details Section
          _buildSection(
            title: 'Personal Details',
            showEdit: true,
            onEdit: _handleEdit,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                _buildDetailRow(
                  'Full Name',
                  userData['personalDetails']['fullName'],
                ),
                _buildDetailRow(
                  'Date of Birth',
                  userData['personalDetails']['dob'],
                ),
                _buildDetailRow(
                  'Mobile Number',
                  userData['personalDetails']['mobile'],
                ),
                _buildDetailRow(
                  'Email Address',
                  userData['personalDetails']['email'],
                ),
                _buildDetailRow(
                  'Address',
                  userData['personalDetails']['address'],
                  isAddress: true,
                ),
              ],
            ),
          ),

          // Documents Section
          _buildSection(
            title: 'Documents',
            child: Column(
              children: [
                _buildDocumentRow('PAN Card', userData['documents']['pan']),
                _buildDocumentRow(
                  'Aadhaar Card',
                  userData['documents']['aadhaar'],
                ),
              ],
            ),
          ),

          // Bank Details Section
          _buildSection(
            title: 'Bank Details',
            child: Column(
              crossAxisAlignment: .start,
              children: [
                _buildDetailRow(
                  'Account Number',
                  userData['bankDetails']['accountNumber'],
                ),
                _buildDetailRow(
                  'Bank Name',
                  userData['bankDetails']['bankName'],
                ),
                _buildDetailRow('IFSC Code', userData['bankDetails']['ifsc']),
                _buildDetailRow('UPI ID', userData['bankDetails']['upiId']),
              ],
            ),
          ),

          // Security & Privacy Section
          _buildSection(
            title: 'Security & Privacy',
            child: Column(
              children: [
                _buildSettingRow(
                  icon: Icons.lock_outline,
                  title: 'Change PIN',
                  trailing: TextButton(
                    onPressed: _handleChangePIN,
                    child: const Text(
                      'Change PIN',
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                _buildSettingRow(
                  icon: Icons.fingerprint,
                  title: 'Biometric Login',
                  trailing: Switch(
                    value: false,
                    onChanged: _handleBiometricToggle,
                    activeColor: const Color(0xFF2E7D32),
                  ),
                ),
                const Divider(height: 1),
                _buildSettingRow(
                  icon: Icons.notifications_none,
                  title: 'Notification Settings',
                  trailing: TextButton(
                    onPressed: _handleNotificationSettings,
                    child: const Text(
                      'Settings',
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // App Settings Section
          _buildSection(
            title: 'App Settings',
            child: Column(
              children: [
                _buildSettingRow(
                  icon: Icons.language,
                  title: 'Language',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'English',
                        style: TextStyle(color: Color(0xFF666666)),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, size: 16),
                        onPressed: _handleLanguageChange,
                        color: const Color(0xFF999999),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                _buildSettingRow(
                  icon: Icons.logout,
                  title: 'Logout',
                  titleColor: const Color(0xFFD32F2F),
                  trailing: TextButton(
                    onPressed: _handleLogout,
                    child: IconButton(
                      onPressed: () {
                        _showLogoutDialog();
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
    bool showEdit = false,
    VoidCallback? onEdit,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1E1E),
                ),
              ),
              if (showEdit)
                TextButton(
                  onPressed: onEdit,
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isAddress = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: isAddress ? 14 : 15,
              fontWeight: isAddress ? FontWeight.w400 : FontWeight.w500,
              color: const Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    required Widget trailing,
    Color? titleColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: titleColor ?? const Color(0xFF666666)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: titleColor ?? const Color(0xFF1E1E1E),
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
