import 'package:digifarmer/blocs/appTheme/theme_bloc.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes_name.dart';
import '../../../res/color/app_colors.dart';
import '../../../service/storage/local_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state.isDark;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        actions: [
          // Logout Button
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.redColor.withOpacity(0.1),
            ),
            child: IconButton(
              onPressed: _showLogoutDialog,
              icon: Icon(Icons.logout, color: AppColors.redColor, size: 22),
              tooltip: 'Logout',
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.greenColor,
                          AppColors.redColor.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'U',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // User Name
                  const Text(
                    'User Name',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // User Email
                  Text(
                    'user@example.com',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),

                  // Edit Profile Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to edit profile
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Profile Options
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.greenColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.brightness_6_sharp,
                    color: AppColors.greenColor,
                    size: 22,
                  ),
                ),

                title: Text('Theme'),
                trailing: Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Switch.adaptive(
                    value: isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeBloc>().add(ToggleThemeEvent());
                    },
                    activeColor: AppColors.redColor,
                    activeTrackColor: AppColors.greenColor.withOpacity(0.5),
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.withOpacity(0.3),
                  ),
                ),
              ),
            ),

            _buildProfileOption(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () {
                // Navigate to orders
              },
            ),

            _buildProfileOption(
              icon: Icons.favorite_border,
              title: 'Favorites',
              onTap: () {
                // Navigate to favorites
              },
            ),

            _buildProfileOption(
              icon: Icons.location_on_outlined,
              title: 'Saved Addresses',
              onTap: () {
                // Navigate to addresses
              },
            ),

            _buildProfileOption(
              icon: Icons.payment_outlined,
              title: 'Payment Methods',
              onTap: () {
                // Navigate to payment methods
              },
            ),

            _buildProfileOption(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                // Navigate to settings
              },
            ),

            _buildProfileOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                // Navigate to help
              },
            ),

            const SizedBox(height: 20),

            // App Version
            Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.greenColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.greenColor, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: onTap,
      ),
    );
  }
}
