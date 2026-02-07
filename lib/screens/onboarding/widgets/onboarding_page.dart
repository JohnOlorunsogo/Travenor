import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/highlighted_word.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String highlightedWord;
  final String subtitle;
  final bool showSkip;
  final VoidCallback? onSkip;
  final VoidCallback onNext;
  final int currentPage;
  final int totalPages;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.highlightedWord,
    required this.subtitle,
    this.showSkip = false,
    this.onSkip,
    required this.onNext,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Illustration - Full Screen
        Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover)),

        // Foreground Text Section with Gradient
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          // Fixed bottom section height for content
          height: MediaQuery.of(context).size.height * 0.5,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.white.withValues(alpha: 0.0),
                  AppColors.white.withValues(alpha: 0.8),
                  AppColors.white,
                  AppColors.white,
                ],
                stops: const [0.0, 0.2, 0.4, 1.0],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const Spacer(flex: 3),
                // Title with highlighted word
                _buildTitle(),
                const SizedBox(height: 16),
                // Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    subtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(flex: 2),
                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    totalPages,
                    (index) => _buildDotIndicator(index),
                  ),
                ),
                const SizedBox(height: 32),
                // Get Started / Next button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentTeal,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      currentPage == 0 ? 'Get Started' : 'Next',
                      style: AppTextStyles.button.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),

        // Skip button overlay
        if (showSkip)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 10,
            child: GestureDetector(
              onTap: onSkip,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Text(
                  'Skip',
                  style: AppTextStyles.skipText.copyWith(
                    color: AppColors.white.withValues(alpha: 0.4),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitle() {
    // Split title at the highlighted word
    final parts = title.split(highlightedWord);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.heading1.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w800,
        ),
        children: [
          if (parts.isNotEmpty) TextSpan(text: parts[0]),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: HighlightedWord(word: highlightedWord),
          ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    final isActive = index == currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 35 : 13,
      height: 7,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.accentTeal
            : AppColors.accentTeal.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
