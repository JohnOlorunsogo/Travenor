import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String highlightedWord;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.highlightedWord,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 60),
          // Illustration
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Title with highlighted word
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _buildTitle(),
                const SizedBox(height: 20),
                // Subtitle
                Text(
                  subtitle,
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    // Split title at the highlighted word
    final parts = title.split(highlightedWord);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.heading1,
        children: [
          if (parts.isNotEmpty) TextSpan(text: parts[0]),
          TextSpan(text: highlightedWord, style: AppTextStyles.accentText),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }
}
