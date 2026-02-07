import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

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
            child: _HighlightedWord(word: highlightedWord),
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

/// Custom widget to show highlighted word with orange curve underline
class _HighlightedWord extends StatelessWidget {
  final String word;

  const _HighlightedWord({required this.word});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          word,
          style: AppTextStyles.accentText.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.accentOrange,
          ),
        ),
        // Orange curve underline matching design
        CustomPaint(size: const Size(80, 8), painter: _CurveUnderlinePainter()),
      ],
    );
  }
}

/// Custom painter for the orange curve underline (smile shape)
// class _CurveUnderlinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = AppColors.accentOrange
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3.0
//       ..strokeCap = StrokeCap.round;

//     final path = Path();
//     // Start slightly to the left and end slightly to the right of central point
//     path.moveTo(size.width * 0.1, 0);
//     path.quadraticBezierTo(
//       size.width * 0.5,
//       size.height * 1.2,
//       size.width * 0.9,
//       0,
//     );

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

class _CurveUnderlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create the curve path
    final path = Path();
    path.moveTo(size.width * 0.01, 10);
    path.quadraticBezierTo(
      size.width * 0.5,
      -size.height * 1.2,
      size.width * 0.99,
      10,
    );

    // Extract path metrics to draw with varying thickness
    final pathMetrics = path.computeMetrics().first;
    final totalLength = pathMetrics.length;

    // Draw the path in segments with varying thickness
    for (double i = 0; i < totalLength; i += 0.01) {
      final t = i / totalLength; // Progress from 0 to 1

      // Quadratic thickness variation
      // Thinnest at ends (0 and 1), thickest at center (0.5)
      final thickness = _getQuadraticThickness(t);

      final tangent = pathMetrics.getTangentForOffset(i);
      if (tangent != null) {
        final paint = Paint()
          ..color = AppColors.accentOrange
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.round;

        canvas.drawCircle(tangent.position, thickness / 2, paint);
      }
    }
  }

  // Quadratic easing function for thickness
  // Creates smooth transition: thin -> thick -> thin
  double _getQuadraticThickness(double t) {
    const minThickness = 1.5;
    const maxThickness = 3.5;

    // Inverted parabola: peaks at t=0.5
    final normalized = 1 - 4 * (t - 0.5) * (t - 0.5);

    return minThickness + (maxThickness - minThickness) * normalized;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
