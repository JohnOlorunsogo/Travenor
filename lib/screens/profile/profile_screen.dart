import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Mock user profile data
class MockUserProfile {
  final String name;
  final String email;
  final String avatar;
  final int tripsCompleted;
  final int bucketList;
  final int reviews;

  const MockUserProfile({
    required this.name,
    required this.email,
    required this.avatar,
    required this.tripsCompleted,
    required this.bucketList,
    required this.reviews,
  });
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const MockUserProfile _user = MockUserProfile(
    name: 'Leonardo',
    email: 'leonardo@example.com',
    avatar: 'assets/images/p.png',
    tripsCompleted: 12,
    bucketList: 24,
    reviews: 38,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: AppTextStyles.heading1.copyWith(fontSize: 28),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        IconsaxPlusLinear.edit_2,
                        color: AppColors.accentTeal,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Profile Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Avatar
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.accentTeal,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(_user.avatar),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.accentTeal,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Name & Email
                    Text(
                      _user.name,
                      style: AppTextStyles.heading1.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _user.email,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem(
                          'Trips',
                          _user.tripsCompleted.toString(),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.divider,
                        ),
                        _buildStatItem(
                          'Bucket List',
                          _user.bucketList.toString(),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.divider,
                        ),
                        _buildStatItem('Reviews', _user.reviews.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Menu Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: IconsaxPlusLinear.user,
                      title: 'Personal Information',
                      subtitle: 'Your account details',
                    ),
                    _buildMenuItem(
                      icon: IconsaxPlusLinear.notification,
                      title: 'Notifications',
                      subtitle: 'Manage your alerts',
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentOrange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '3',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    _buildMenuItem(
                      icon: IconsaxPlusLinear.wallet_1,
                      title: 'Payment Methods',
                      subtitle: 'Add or remove cards',
                    ),
                    _buildMenuItem(
                      icon: IconsaxPlusLinear.security_safe,
                      title: 'Privacy & Security',
                      subtitle: 'Password, 2FA, data',
                    ),
                    _buildMenuItem(
                      icon: IconsaxPlusLinear.heart,
                      title: 'Favorites',
                      subtitle: 'Your saved destinations',
                    ),
                    _buildMenuItem(
                      icon: IconsaxPlusLinear.setting_2,
                      title: 'Settings',
                      subtitle: 'App preferences',
                    ),
                    _buildMenuItem(
                      icon: IconsaxPlusLinear.message_question,
                      title: 'Help & Support',
                      subtitle: 'FAQs and contact us',
                    ),
                    const SizedBox(height: 10),
                    _buildMenuItem(
                      icon: IconsaxPlusLinear.logout,
                      title: 'Log Out',
                      subtitle: 'Sign out of your account',
                      isDestructive: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // App Version
              Text(
                'Version 1.0.0',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.heading1.copyWith(
            fontSize: 22,
            color: AppColors.accentTeal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDestructive
                  ? Colors.red.withValues(alpha: 0.1)
                  : AppColors.accentTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isDestructive ? Colors.red : AppColors.accentTeal,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDestructive ? Colors.red : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          trailing ??
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
                size: 16,
              ),
        ],
      ),
    );
  }
}
