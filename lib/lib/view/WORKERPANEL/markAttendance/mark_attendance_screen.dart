import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen>
    with SingleTickerProviderStateMixin {
  bool _isCheckedIn = false;
  bool _isLoading = false;
  String? _currentLocation;
  String? _currentTime;
  String? _currentDate;
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  // Check-in/out times
  DateTime? _checkInTime;
  DateTime? _checkOutTime;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = _formatTime(now);
      _currentDate = _formatDate(now);
    });
  }

  String _formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    String second = time.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  String _formatDate(DateTime date) {
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
    const weekdays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];

    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationDialog(
        'Location services are disabled. Please enable them to mark attendance.',
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationDialog(
          'Location permissions are denied. Please grant permission to mark attendance.',
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationDialog(
        'Location permissions are permanently denied. Please enable them in app settings.',
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation =
            '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
      });
    } catch (e) {
      _showLocationDialog('Unable to get location. Please try again.');
    }
  }

  void _showLocationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Location Required',
          style: TextStyle(fontFamily: AppFonts.popins),
        ),
        content: Text(
          message,
          style: const TextStyle(fontFamily: AppFonts.popins),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(fontFamily: AppFonts.popins),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAttendance(bool isCheckIn) async {
    setState(() => _isLoading = true);

    try {
      await _getCurrentLocation();

      // Simulate API call - only token goes in header
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        if (isCheckIn) {
          _isCheckedIn = true;
          _checkInTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '✓ Check-in successful at ${_formatTime(DateTime.now())}',
                      style: const TextStyle(fontFamily: AppFonts.popins),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        } else {
          _isCheckedIn = false;
          _checkOutTime = DateTime.now();

          // Calculate total hours worked
          if (_checkInTime != null) {
            Duration worked = _checkOutTime!.difference(_checkInTime!);
            String hoursWorked =
                '${worked.inHours}h ${worked.inMinutes.remainder(60)}m';

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '✓ Check-out successful',
                            style: const TextStyle(fontFamily: AppFonts.popins),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 34),
                      child: Text(
                        'Total hours worked: $hoursWorked',
                        style: const TextStyle(
                          fontFamily: AppFonts.popins,
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.orange,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                duration: const Duration(seconds: 4),
              ),
            );
          }
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: ${e.toString()}',
            style: const TextStyle(fontFamily: AppFonts.popins),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xffF4F6F9),
      appBar: CustomAppBar(
        title: "Mark Attendance",
        gradient: const LinearGradient(
          colors: [Color(0xff1E88E5), Color(0xff2BB673)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          children: [
            /// ================= ANIMATED CLOCK CARD =================
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isTablet ? 30 : 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff1E88E5), Color(0xff2BB673)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff1E88E5).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// Date
                  Text(
                    _currentDate ?? 'Loading...',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: AppFonts.popins,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 15),

                  /// Animated Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _currentTime ?? '--:--:--',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.popins,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// Location Indicator (if available)
                  if (_currentLocation != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _currentLocation!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: AppFonts.popins,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// ================= ATTENDANCE STATUS CARD =================
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isTablet ? 24 : 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// Status Icon
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _isCheckedIn
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _isCheckedIn ? 1.0 : _pulseAnimation.value,
                          child: Icon(
                            _isCheckedIn
                                ? Icons.check_circle
                                : Icons.radio_button_checked,
                            size: 80,
                            color: _isCheckedIn ? Colors.green : Colors.orange,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Status Text
                  Text(
                    _isCheckedIn ? 'You are Checked In' : 'You are Checked Out',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _isCheckedIn ? Colors.green : Colors.orange,
                      fontFamily: AppFonts.popins,
                    ),
                  ),
                  const SizedBox(height: 8),

                  /// Subtitle
                  Text(
                    _isCheckedIn
                        ? 'Your attendance has been marked for today'
                        : 'Please check in to start your work day',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: AppFonts.popins,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Time Logs
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        /// Check-in Time
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.login,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Check In',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _checkInTime != null
                                    ? _formatTime(_checkInTime!)
                                    : '--:--',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Divider
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.grey[300],
                        ),

                        /// Check-out Time
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.logout,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Check Out',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _checkOutTime != null
                                    ? _formatTime(_checkOutTime!)
                                    : '--:--',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: AppFonts.popins,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// ================= ACTION BUTTONS =================
            Row(
              children: [
                /// Check In Button
                Expanded(
                  child: _buildActionButton(
                    title: 'CHECK IN',
                    icon: Icons.login,
                    color: Colors.green,
                    onTap: !_isCheckedIn && !_isLoading
                        ? () => _handleAttendance(true)
                        : null,
                    isLoading: _isLoading && !_isCheckedIn,
                  ),
                ),
                const SizedBox(width: 16),

                /// Check Out Button
                Expanded(
                  child: _buildActionButton(
                    title: 'CHECK OUT',
                    icon: Icons.logout,
                    color: Colors.orange,
                    onTap: _isCheckedIn && !_isLoading
                        ? () => _handleAttendance(false)
                        : null,
                    isLoading: _isLoading && _isCheckedIn,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// ================= ATTENDANCE HISTORY =================
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
    required bool isLoading,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: AppFonts.popins,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
