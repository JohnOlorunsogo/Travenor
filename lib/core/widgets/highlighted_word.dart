import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Custom widget to show highlighted word with orange curve underline
class HighlightedWord extends StatelessWidget {
  final String word;
  final double fontSize;

  const HighlightedWord({super.key, required this.word, this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          word,
          style: AppTextStyles.accentText.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: AppColors.accentOrange,
          ),
        ),
        // Orange curve underline matching design
        CustomPaint(
          size: Size(fontSize * 2.5, fontSize * 0.25),
          painter: CurveUnderlinePainter(),
        ),
      ],
    );
  }
}

class CurveUnderlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create the curve path
    final path = Path();
    path.moveTo(size.width * 0.01, size.height * 1.25);
    path.quadraticBezierTo(
      size.width * 0.5,
      -size.height * 0.2,
      size.width * 0.99,
      size.height * 1.25,
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
