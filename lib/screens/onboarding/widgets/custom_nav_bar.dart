import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:travenor/core/theme/app_colors.dart';
import 'package:travenor/core/theme/app_text_styles.dart';

class CurvedNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CurvedNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  State<CurvedNavigationBar> createState() => _CurvedNavigationBarState();
}

class _CurvedNavigationBarState extends State<CurvedNavigationBar> {
  final List<NavItem> _items = [
    NavItem(
      icon: IconsaxPlusLinear.home,
      activeIcon: IconsaxPlusBold.home,
      label: 'Home',
    ),
    NavItem(
      icon: IconsaxPlusLinear.calendar,
      activeIcon: IconsaxPlusBold.calendar,
      label: 'Calendar',
    ),
    NavItem(
      icon: Icons.search,
      activeIcon: Icons.search,
      label: '',
    ), // Center button
    NavItem(
      icon: IconsaxPlusLinear.message,
      activeIcon: IconsaxPlusBold.message,
      label: 'Messages',
    ),
    NavItem(
      icon: IconsaxPlusLinear.profile,
      activeIcon: IconsaxPlusBold.profile,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 130),
            painter: CurvePainter(color: Colors.white),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 27,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(_items.length, (index) {
                  final isSelected = index == widget.selectedIndex;
                  final isCenter = index == 2;

                  if (isCenter) {
                    return GestureDetector(
                      onTap: () => widget.onTap(index),
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColors.accentTeal,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentTeal.withValues(
                                alpha: 0.4,
                              ),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () => widget.onTap(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected
                              ? _items[index].activeIcon
                              : _items[index].icon,
                          color: isSelected
                              ? AppColors.accentTeal
                              : Colors.grey,
                          size: 26,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _items[index].label,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 12,
                            color: isSelected
                                ? AppColors.accentTeal
                                : Colors.grey,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final Color color;

  CurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    //   final path = Path();

    //   final scaleX = size.width / 375;
    //   final scaleY = size.height / 114;

    //   path.moveTo(0, 56.9996 * scaleY);

    //   // Left edge
    //   path.lineTo(0, 84 * scaleY);

    //   // Bottom-left corner (radius 50)
    //   path.arcToPoint(
    //     Offset(30 * scaleX, 114 * scaleY),
    //     radius: Radius.circular(30 * scaleX),
    //     clockwise: false,
    //   );

    //   // Bottom edge
    //   path.lineTo(345 * scaleX, 114 * scaleY);

    //   // Bottom-right corner (radius 50)
    //   path.arcToPoint(
    //     Offset(375 * scaleX, 84 * scaleY),
    //     radius: Radius.circular(30 * scaleX),
    //     clockwise: false,
    //   );

    //   // Right edge
    //   path.lineTo(375 * scaleX, 57.3033 * scaleY);

    //   // Top-right curve (reverse of the equation)
    //   // Using the bezier curve data from the path
    //   path.cubicTo(
    //     375 * scaleX,
    //     42.2381 * scaleY,
    //     363.809 * scaleX,
    //     29.4853 * scaleY,
    //     348.854 * scaleX,
    //     27.6659 * scaleY,
    //   );

    //   path.cubicTo(
    //     285 * scaleX,
    //     20 * scaleY, // Control point 1 (right side)
    //     240 * scaleX,
    //     12 * scaleY, // Control point 2 (approaching peak)
    //     187.5 * scaleX,
    //     12 * scaleY, // Peak point (center)
    //   );

    //   path.cubicTo(
    //     135 * scaleX,
    //     12 * scaleY, // Control point 3 (leaving peak)
    //     90 * scaleX,
    //     20 * scaleY, // Control point 4 (left side)
    //     25.7905 * scaleX,
    //     27.4401 * scaleY, // End point (left)
    //   );

    //   // Top-left curve
    //   path.cubicTo(
    //     10.9827 * scaleX,
    //     29.3777 * scaleY,
    //     0,
    //     42.0656 * scaleY,
    //     0,
    //     56.9996 * scaleY,
    //   );

    //   path.close();

    //   // Draw shadow using a manual blur for a more "premium" look
    //   final shadowPaint = Paint()
    //     ..color = AppColors.shadow.withValues(alpha: 0.15)
    //     ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    //   // Offset the shadow slightly downwards
    //   canvas.save();
    //   canvas.translate(0, 4);
    //   canvas.drawPath(path, shadowPaint);
    //   canvas.restore();

    //   // Draw the main path
    //   canvas.drawPath(path, paint);
    // }

    // @override
    // bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

    // Original SVG dimensions
    const double originalWidth = 375;
    const double originalHeight = 114;

    // Calculate scale factors
    final double scaleX = size.width / originalWidth;
    final double scaleY = size.height / originalHeight;

    Path path_0 = Path();
    path_0.moveTo(0, 56.9996 * scaleY);
    path_0.cubicTo(
      0,
      42.0656 * scaleY,
      10.9827 * scaleX,
      29.3777 * scaleY,
      25.7905 * scaleX,
      27.4401 * scaleY,
    );
    path_0.cubicTo(
      142.999 * scaleX,
      12.1034 * scaleY,
      221.685 * scaleX,
      12.1954 * scaleY,
      348.854 * scaleX,
      27.6659 * scaleY,
    );
    path_0.cubicTo(
      363.809 * scaleX,
      29.4853 * scaleY,
      375 * scaleX,
      42.2381 * scaleY,
      375 * scaleX,
      57.3033 * scaleY,
    );
    path_0.lineTo(375 * scaleX, 84 * scaleY);
    path_0.cubicTo(
      375 * scaleX,
      100.569 * scaleY,
      361.569 * scaleX,
      114 * scaleY,
      345 * scaleX,
      114 * scaleY,
    );
    path_0.lineTo(30 * scaleX, 114 * scaleY);
    path_0.cubicTo(
      13.4315 * scaleX,
      114 * scaleY,
      0,
      100.569 * scaleY,
      0,
      84 * scaleY,
    );
    path_0.lineTo(0, 56.9996 * scaleY);
    path_0.close();

    // Draw shadow using a manual blur for a more "premium" look
    final shadowPaint = Paint()
      ..color = AppColors.shadow.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    // Offset the shadow slightly downwards
    canvas.save();
    canvas.translate(0, 4);
    canvas.drawPath(path_0, shadowPaint);
    canvas.restore();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color;

    // Add shadow for depth (from the SVG filter)
    canvas.drawShadow(path_0, color, 8.0, false);

    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Changed to false for better performance
  }
}

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavItem({required this.icon, required this.activeIcon, required this.label});
}
