import 'package:flutter/material.dart';

import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';

class WorkerNotificationScreen extends StatelessWidget {
  WorkerNotificationScreen({super.key});

  // Notification item model
  final List<Map<String, dynamic>> notifications = [
    {
      'id': '1',
      'category': 'Investment',
      'title': 'Payment Failed',
      'description':
          'Your investment payment of ₹50,000 failed. Please update your payment method.',
      'time': '2 min ago',
      'actionLabel': 'Retry Payment',
      'highlight': true,
    },
    {
      'id': '2',
      'category': 'Farming',
      'title': 'Crop Progress Update',
      'description':
          'Your investment in Plot A1 shows 85% crop growth. Expected harvest in 2 weeks.',
      'time': '15 min ago',
      'actionLabel': 'View Progress',
    },
    {
      'id': '3',
      'category': 'Investment',
      'title': 'Investment Matured',
      'description':
          'Your 2-year investment has matured. Total return: ₹1,20,000 (20% ROI).',
      'time': '1 hour ago',
      'actionLabel': 'Withdraw',
    },
    {
      'id': '4',
      'category': 'Tasks',
      'title': 'Task Reminder',
      'description':
          'Irrigation check for Plot B2 is due in 30 minutes. Don’t miss your scheduled task.',
      'time': '2 hours ago',
      'actionLabel': 'Start Task',
    },
    {
      'id': '5',
      'category': 'Farming',
      'title': 'Land Approved',
      'description':
          'Your submitted land (5.2 acres) has been approved for agricultural investment.',
      'time': '3 hours ago',
      'actionLabel': 'View Details',
    },
    {
      'id': '6',
      'category': 'Farming',
      'title': 'Bonus Credited',
      'description':
          'Quality bonus of ₹2,500 added to your account for excellent farm management.',
      'time': '5 hours ago',
      'actionLabel': 'View Wallet',
    },
    {
      'id': '7',
      'category': 'Tasks',
      'title': 'Photo Verification Required',
      'description':
          'Please upload progress photos for yesterday’s pesticide application task.',
      'time': '6 hours ago',
      'actionLabel': 'Upload Photos',
    },
  ];

  // Category colors mapping
  final Map<String, Color> categoryColors = {
    'Investment': const Color(0xFFE6F0FA),
    'Farming': const Color(0xFFE8F5E9),
    'Tasks': const Color(0xFFFFF4E5),
  };

  final Map<String, Color> categoryBorderColors = {
    'Investment': const Color(0xFF007AFF),
    'Farming': const Color(0xFF2E7D32),
    'Tasks': const Color(0xFFED6A2E),
  };

  void _handleActionPress(String action, String id) {
    debugPrint('Action: $action on notification $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: CustomAppBar(
        title: "Notification",
        gradient: LinearGradient(
          colors: [Color(0xff34A853), Color(0xff0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final category = notification['category'] as String;
          final backgroundColor =
              categoryColors[category] ?? const Color(0xFFF5F5F5);
          final borderColor =
              categoryBorderColors[category] ?? const Color(0xFF007AFF);

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 1),
                  blurRadius: 4,
                ),
              ],
              border: Border.all(
                color: Colors.black.withOpacity(0.03),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with category and time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Category pill
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 1.5),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: borderColor,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      // Time
                      Text(
                        notification['time'] as String,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF6C6C6C),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    notification['title'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Description
                  Text(
                    notification['description'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF3A3A3A),
                      fontFamily: AppFonts.popins,
                      height: 1.43, // 20/14
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Action button
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    elevation: 1,
                    shadowColor: Colors.black.withOpacity(0.03),
                    child: InkWell(
                      onTap: () => _handleActionPress(
                        notification['actionLabel'] as String,
                        notification['id'] as String,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFDADADA),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          notification['actionLabel'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
