import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Custom painter for the details screen bottom sheet with curved top edge
class DetailsBottomSheetPainter extends CustomPainter {
  final Color color;
  final Color? shadowColor;

  DetailsBottomSheetPainter({this.color = Colors.white, this.shadowColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Original SVG dimensions
    const double originalWidth = 375;
    const double originalHeight = 461;

    final double scaleX = size.width / originalWidth;
    final double scaleY = size.height / originalHeight;

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();

    // Start point
    path.moveTo(0, 54.4902 * scaleY);

    // Top-left curve
    path.cubicTo(
      0,
      40.9162 * scaleY,
      0,
      34.1292 * scaleY,
      2.17288 * scaleX,
      28.5375 * scaleY,
    );
    path.cubicTo(
      5.04241 * scaleX,
      21.1531 * scaleY,
      10.7227 * scaleX,
      14.948 * scaleY,
      17.8254 * scaleX,
      11.4388 * scaleY,
    );
    path.cubicTo(
      23.2038 * scaleX,
      8.78147 * scaleY,
      29.8585 * scaleX,
      8.19261 * scaleY,
      43.168 * scaleX,
      7.01489 * scaleY,
    );

    // Top curve (the wave)
    path.cubicTo(
      148.146 * scaleX,
      -2.27432 * scaleY,
      222.785 * scaleX,
      -2.4225 * scaleY,
      331.755 * scaleX,
      7.07588 * scaleY,
    );

    // Top-right curve
    path.cubicTo(
      345.092 * scaleX,
      8.23842 * scaleY,
      351.76 * scaleX,
      8.81969 * scaleY,
      357.146 * scaleX,
      11.4741 * scaleY,
    );
    path.cubicTo(
      364.261 * scaleX,
      14.9806 * scaleY,
      369.948 * scaleX,
      21.1846 * scaleY,
      372.823 * scaleX,
      28.577 * scaleY,
    );
    path.cubicTo(
      375 * scaleX,
      34.173 * scaleY,
      375 * scaleX,
      40.9706 * scaleY,
      375 * scaleX,
      54.5657 * scaleY,
    );

    // Right edge
    path.lineTo(375 * scaleX, 413 * scaleY);

    // Bottom-right corner
    path.cubicTo(
      375 * scaleX,
      427.91 * scaleY,
      375 * scaleX,
      435.365 * scaleY,
      372.564 * scaleX,
      441.246 * scaleY,
    );
    path.cubicTo(
      369.316 * scaleX,
      449.087 * scaleY,
      363.087 * scaleX,
      455.316 * scaleY,
      355.246 * scaleX,
      458.564 * scaleY,
    );
    path.cubicTo(
      349.365 * scaleX,
      461 * scaleY,
      341.91 * scaleX,
      461 * scaleY,
      327 * scaleX,
      461 * scaleY,
    );

    // Bottom edge
    path.lineTo(48 * scaleX, 461 * scaleY);

    // Bottom-left corner
    path.cubicTo(
      33.0899 * scaleX,
      461 * scaleY,
      25.6348 * scaleX,
      461 * scaleY,
      19.7541 * scaleX,
      458.564 * scaleY,
    );
    path.cubicTo(
      11.9132 * scaleX,
      455.316 * scaleY,
      5.68366 * scaleX,
      449.087 * scaleY,
      2.43585 * scaleX,
      441.246 * scaleY,
    );
    path.cubicTo(0, 435.365 * scaleY, 0, 427.91 * scaleY, 0, 413 * scaleY);

    // Left edge back to start
    path.lineTo(0, 54.4902 * scaleY);
    path.close();

    // Draw shadow
    if (shadowColor != null) {
      final shadowPaint = Paint()
        ..color = shadowColor!
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

      canvas.save();
      canvas.translate(0, -5);
      canvas.drawPath(path, shadowPaint);
      canvas.restore();
    }

    // Draw the main shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant DetailsBottomSheetPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.shadowColor != shadowColor;
  }
}

/// Widget wrapper for the custom painted bottom sheet
class DetailsBottomSheet extends StatelessWidget {
  final Widget child;
  final Color color;
  final double height;

  const DetailsBottomSheet({
    super.key,
    required this.child,
    this.color = Colors.white,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DetailsBottomSheetPainter(
        color: color,
        shadowColor: AppColors.shadow.withValues(alpha: 0.15),
      ),
      child: SizedBox(height: height, child: child),
    );
  }
}
