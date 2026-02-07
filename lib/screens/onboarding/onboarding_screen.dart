import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
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
      context.push('/sign-in');
    }
  }

  void _onSkipPressed() {
    context.push('/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: PageView.builder(
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
            showSkip: index > 0,
            onSkip: _onSkipPressed,
            onNext: _onNextPressed,
            currentPage: _currentPage,
            totalPages: _onboardingData.length,
          );
        },
      ),
    );
  }
}
