import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/images/onboarding_1.png',
      'title': 'Life is short and the world is wide',
      'highlight': 'wide',
      'subtitle':
          'At Friends tours and travel, we customize reliable and trustworthy educational tours to destinations all over the world',
    },
    {
      'image': 'assets/images/onboarding_2.png',
      'title': "It's a big world out there go explore",
      'highlight': 'explore',
      'subtitle':
          'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
    },
    {
      'image': 'assets/images/onboarding_3.png',
      'title': "People don't take trips, trips take people",
      'highlight': 'people',
      'subtitle':
          'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to home/login - for now just print
      debugPrint('Onboarding completed!');
    }
  }

  void _onSkipPressed() {
    // Navigate to home/login - for now just print
    debugPrint('Skip pressed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button (visible on pages 2 and 3)
            _buildSkipButton(),
            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];
                  return OnboardingPage(
                    imagePath: data['image']!,
                    title: data['title']!,
                    highlightedWord: data['highlight']!,
                    subtitle: data['subtitle']!,
                  );
                },
              ),
            ),
            // Bottom section with indicators and button
            _buildBottomSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Container(
      height: 56,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedOpacity(
        opacity: _currentPage > 0 ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: _onSkipPressed,
          child: Text('Skip', style: AppTextStyles.skipText),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingData.length,
              (index) => _buildDotIndicator(index),
            ),
          ),
          const SizedBox(height: 32),
          // Next/Get Started button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _onNextPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentTeal,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                _currentPage == 0 ? 'Get Started' : 'Next',
                style: AppTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    final isActive = index == _currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 35 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.accentTeal : AppColors.textLight,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
