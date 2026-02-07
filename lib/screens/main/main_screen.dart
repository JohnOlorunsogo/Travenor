import 'package:flutter/material.dart';
import 'package:travenor/screens/onboarding/widgets/custom_nav_bar.dart';
import '../../core/theme/app_colors.dart';
import '../home/home_screen.dart';
import '../schedule/schedule_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ScheduleScreen(),
    const Center(child: Text('Search')), // Placeholder for Search
    const Center(child: Text('Messages')), // Placeholder for Messages
    const Center(child: Text('Profile')), // Placeholder for Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      // bottomNavigationBar: Container(
      //   height: 90,
      //   decoration: BoxDecoration(
      //     color: AppColors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: AppColors.shadow.withValues(alpha: 0.1),
      //         blurRadius: 20,
      //         offset: const Offset(0, -5),
      //       ),
      //     ],
      //   ),
      //   child: BottomNavigationBar(
      //     currentIndex: _selectedIndex,
      //     onTap: _onItemTapped,
      //     type: BottomNavigationBarType.fixed,
      //     backgroundColor: AppColors.white,
      //     selectedItemColor: AppColors.accentTeal,
      //     unselectedItemColor: AppColors.textSecondary,
      //     showSelectedLabels: true,
      //     showUnselectedLabels: true,
      //     selectedLabelStyle: AppTextStyles.bodyMedium.copyWith(
      //       fontSize: 12,
      //       fontWeight: FontWeight.w600,
      //     ),
      //     unselectedLabelStyle: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
      //     items: [
      //       const BottomNavigationBarItem(
      //         icon: Icon(Icons.home_outlined),
      //         activeIcon: Icon(Icons.home),
      //         label: 'Home',
      //       ),
      //       const BottomNavigationBarItem(
      //         icon: Icon(Icons.calendar_today_outlined),
      //         activeIcon: Icon(Icons.calendar_today),
      //         label: 'Calendar',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Container(
      //           padding: const EdgeInsets.all(12),
      //           decoration: const BoxDecoration(
      //             color: AppColors.accentTeal,
      //             shape: BoxShape.circle,
      //           ),
      //           child: const Icon(Icons.search, color: AppColors.white),
      //         ),
      //         label: '',
      //       ),
      //       const BottomNavigationBarItem(
      //         icon: Icon(Icons.chat_bubble_outline),
      //         activeIcon: Icon(Icons.chat_bubble),
      //         label: 'Messages',
      //       ),
      //       const BottomNavigationBarItem(
      //         icon: Icon(Icons.person_outline),
      //         activeIcon: Icon(Icons.person),
      //         label: 'Profile',
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
