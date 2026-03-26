import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../blocs/INVESTORPANEL/updateProfile/update_profile_bloc.dart';
import '../../../blocs/INVESTORPANEL/userProfile/user_profile_bloc.dart';
import '../../../config/routes/routes_name.dart';
import '../../../main.dart';
import '../../../model/INVESTORPANEL/userProfile/user_profile_model.dart';
import '../../../res/color/app_colors.dart';
import '../../../res/customeWidgets/custom_app_bar.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../service/storage/local_storage.dart';
import '../../../utils/enums.dart';

class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({super.key});

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  late UserProfileBloc userProfileBloc;
  late UpdateProfileBloc updateProfileBloc;

  @override
  void initState() {
    super.initState();
    userProfileBloc = UserProfileBloc(userProfileRepository: getIt());
    updateProfileBloc = UpdateProfileBloc(updateProfileRepository: getIt());
  }

  @override
  void dispose() {
    userProfileBloc.close();
    updateProfileBloc.close();
    super.dispose();
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

  Future<void> _showLogoutDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontFamily: AppFonts.popins,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontFamily: AppFonts.popins),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: const Text(
                'Cancel',
                style: TextStyle(fontFamily: AppFonts.popins),
              ),
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
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: AppFonts.popins,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Shows bottom sheet with Gallery / Camera options
  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Update Profile Photo',
                  style: TextStyle(
                    fontFamily: AppFonts.popins,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F1FB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.photo_library_outlined,
                      color: Color(0xFF185FA5),
                    ),
                  ),
                  title: const Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      fontFamily: AppFonts.popins,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F1FB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xFF185FA5),
                    ),
                  ),
                  title: const Text(
                    'Take a Photo',
                    style: TextStyle(
                      fontFamily: AppFonts.popins,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      // Dispatch image picked event — path stored in bloc state
      updateProfileBloc.add(ProfileImagePicked(imagePath: pickedFile.path));
      // Immediately submit
      updateProfileBloc.add(const SubmitUpdateProfile());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: userProfileBloc..add(UserProfileFetched())),
        BlocProvider.value(value: updateProfileBloc),
      ],
      child: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state) {
          if (state.postApiStatus == PostApiStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(fontFamily: AppFonts.popins),
                ),
                backgroundColor: const Color(0xFF3B6D11),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            // Refresh profile after successful update
            userProfileBloc.add(UserProfileFetched());
          } else if (state.postApiStatus == PostApiStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(fontFamily: AppFonts.popins),
                ),
                backgroundColor: AppColors.redColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xffF7F8FA),
          appBar: CustomAppBar(
            title: 'My Profile',
            automaticallyImplyLeading: true,
            gradient: const LinearGradient(
              colors: [Color(0xff34A853), Color(0xff0D47A1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                    onPressed: _showLogoutDialog,
                    icon: Icon(Icons.logout, color: AppColors.redColor),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.workerSettingScreen,
                      );
                    },
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
            ],
          ),
          body: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              switch (state.userProfile.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());

                case Status.error:
                  if (state.userProfile.message == 'No Internet Connection') {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.wifi_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No Internet Connection',
                            style: TextStyle(
                              fontFamily: AppFonts.popins,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () =>
                                userProfileBloc.add(UserProfileFetched()),
                            child: const Text(
                              'Retry',
                              style: TextStyle(fontFamily: AppFonts.popins),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.userProfile.message ?? "Something went wrong",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              userProfileBloc.add(UserProfileFetched()),
                          child: const Text(
                            "Retry",
                            style: TextStyle(
                              fontFamily: AppFonts.popins,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                case Status.completed:
                  if (state.userProfile.data == null) {
                    return const Center(
                      child: Text(
                        'No profile data found',
                        style: TextStyle(fontFamily: AppFonts.popins),
                      ),
                    );
                  }
                  final UserProfileModel response = state.userProfile.data!;
                  final User user = response.user!;
                  return _buildBody(user);

                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(User user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _ProfileHeader(user: user, onCameraTap: _showImagePickerSheet),
          const SizedBox(height: 12),

          _SectionCard(
            title: 'PERSONAL INFORMATION',
            children: [
              _InfoRow(
                icon: Icons.phone_outlined,
                label: 'Mobile',
                value: user.mobileNumber ?? '-',
              ),
              _InfoRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: user.email ?? 'Not provided',
                valueColor: Colors.grey.shade400,
                isItalic: user.email == null,
              ),
              _InfoRow(
                icon: Icons.cake_outlined,
                label: 'Date of Birth',
                value: _formatDate(user.dateOfBirth),
                isLast: true,
              ),
            ],
          ),

          const SizedBox(height: 12),

          _SectionCard(
            title: 'KYC DETAILS',
            children: [
              _InfoRow(
                icon: Icons.credit_card_outlined,
                label: 'PAN Number',
                value: user.panNumber ?? '-',
                isMonospace: true,
              ),
              _InfoRow(
                icon: Icons.fingerprint,
                label: 'Aadhaar',
                value: user.aadhaarNumber ?? '-',
                isMonospace: true,
                isLast: true,
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (user.address != null) ...[
            _SectionCard(
              title: 'ADDRESS',
              children: [_AddressRow(address: user.address!)],
            ),
            const SizedBox(height: 12),
          ],

          _SectionCard(
            title: 'ACCOUNT DETAILS',
            children: [
              _InfoRow(
                icon: Icons.verified_user_outlined,
                label: 'Status',
                value: '',
                valueWidget: _StatusBadge(status: user.status ?? ''),
              ),
              _InfoRow(
                icon: Icons.check_circle_outline,
                label: 'Approval',
                value: '',
                valueWidget: _ApprovalBadge(
                  isApproved: user.isApproved ?? false,
                ),
              ),
              _InfoRow(
                icon: Icons.calendar_today_outlined,
                label: 'Member Since',
                value: _formatDate(user.createdAt),
              ),
              _InfoRow(
                icon: Icons.update_outlined,
                label: 'Last Updated',
                value: _formatDate(user.updatedAt),
                isLast: true,
              ),
            ],
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '-';
    try {
      final dt = DateTime.parse(dateStr);
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
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
    } catch (_) {
      return dateStr;
    }
  }
}

// ---------------------------------------------------------------------------
// HEADER — now accepts onCameraTap + shows upload loading overlay
// ---------------------------------------------------------------------------

class _ProfileHeader extends StatelessWidget {
  final User user;
  final VoidCallback onCameraTap;

  const _ProfileHeader({required this.user, required this.onCameraTap});

  String get _initials {
    final name = (user.fullName ?? '').trim();
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.length >= 2
        ? name.substring(0, 2).toUpperCase()
        : name.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              // Avatar — shows local picked image while uploading
              BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                builder: (context, updateState) {
                  final isUploading =
                      updateState.postApiStatus == PostApiStatus.loading;
                  final hasLocalImage = updateState.imagePath.isNotEmpty;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: const Color(0xFFE6F1FB),
                        backgroundImage: hasLocalImage
                            ? FileImage(File(updateState.imagePath))
                            : (user.profileImage != null &&
                                  user.profileImage!.isNotEmpty)
                            ? NetworkImage(user.profileImage!)
                            : null,
                        child:
                            (hasLocalImage ||
                                (user.profileImage != null &&
                                    user.profileImage!.isNotEmpty))
                            ? null
                            : Text(
                                _initials,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF185FA5),
                                ),
                              ),
                      ),
                      // Upload loading overlay
                      if (isUploading)
                        Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.45),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              // Camera button
              GestureDetector(
                onTap: onCameraTap,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: const Color(0xFF185FA5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            user.fullName ?? '-',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            user.mobileNumber ?? '',
            style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              if (user.role != null)
                _Chip(
                  label: user.role!,
                  bgColor: const Color(0xFFE6F1FB),
                  textColor: const Color(0xFF185FA5),
                ),
              if (user.status != null)
                _Chip(
                  label: user.status!,
                  bgColor: user.status == 'ACTIVE'
                      ? const Color(0xFFEAF3DE)
                      : const Color(0xFFFCEBEB),
                  textColor: user.status == 'ACTIVE'
                      ? const Color(0xFF3B6D11)
                      : const Color(0xFFA32D2D),
                ),
              if (user.isApproved == true)
                const _Chip(
                  label: 'Approved',
                  bgColor: Color(0xFFEAF3DE),
                  textColor: Color(0xFF3B6D11),
                  icon: Icons.verified,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final IconData? icon;

  const _Chip({
    required this.label,
    required this.bgColor,
    required this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION CARD
// ---------------------------------------------------------------------------

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9E9E9E),
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(height: 4),
          ...children,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// INFO ROW
// ---------------------------------------------------------------------------

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final bool isMonospace;
  final bool isItalic;
  final bool isLast;
  final Widget? valueWidget;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.isMonospace = false,
    this.isItalic = false,
    this.isLast = false,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF185FA5)),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
              ),
              const Spacer(),
              valueWidget ??
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: valueColor ?? const Color(0xFF1A1A1A),
                      fontFamily: isMonospace ? 'monospace' : null,
                      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 0, indent: 46, color: Color(0xFFF0F0F0)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// ADDRESS ROW
// ---------------------------------------------------------------------------

class _AddressRow extends StatelessWidget {
  final Address address;

  const _AddressRow({required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 18,
            color: Color(0xFF185FA5),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${address.houseNumber ?? ''}, ${address.street ?? ''}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${address.area ?? ''}, ${address.city ?? ''}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF757575),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${address.state ?? ''} – ${address.pinCode ?? ''}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// STATUS BADGE
// ---------------------------------------------------------------------------

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isActive = status == 'ACTIVE';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFEAF3DE) : const Color(0xFFFCEBEB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF3B6D11)
                  : const Color(0xFFA32D2D),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive
                  ? const Color(0xFF3B6D11)
                  : const Color(0xFFA32D2D),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// APPROVAL BADGE
// ---------------------------------------------------------------------------

class _ApprovalBadge extends StatelessWidget {
  final bool isApproved;

  const _ApprovalBadge({required this.isApproved});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isApproved ? const Color(0xFFEAF3DE) : const Color(0xFFFAEEDA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isApproved ? 'Approved' : 'Pending',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isApproved ? const Color(0xFF3B6D11) : const Color(0xFF854F0B),
        ),
      ),
    );
  }
}
