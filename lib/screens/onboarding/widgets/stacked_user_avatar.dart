import 'package:flutter/material.dart';

class OverlappingAvatars extends StatelessWidget {
  final List<ImageProvider> avatars;
  final int extraCount;
  final double size;
  final double overlap;

  const OverlappingAvatars({
    super.key,
    required this.avatars,
    required this.extraCount,
    this.size = 64,
    this.overlap = 20,
  });

  @override
  Widget build(BuildContext context) {
    final total = avatars.length + 1; // +1 for the "+50" bubble
    final width = size + (total - 1) * (size - overlap);

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          // Avatars
          for (int i = 0; i < avatars.length; i++)
            Positioned(
              left: i * (size - overlap),
              child: _AvatarCircle(
                size: size,
                backgroundColor: _bgColorForIndex(i),
                child: ClipOval(
                  child: Image(
                    image: avatars[i],
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          // +50 bubble
          Positioned(
            left: avatars.length * (size - overlap),
            child: _AvatarCircle(
              size: size,
              backgroundColor: const Color(0xFFDCEEFF),
              child: Center(
                child: Text(
                  "+$extraCount",
                  style: TextStyle(
                    fontSize: size * 0.4,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _bgColorForIndex(int i) {
    const colors = [
      Color(0xFFBEE7F8), // light blue
      Color(0xFFFFD9A8), // light orange
      Color(0xFFBFF2C8), // light green
    ];
    return colors[i % colors.length];
  }
}

class _AvatarCircle extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Widget child;

  const _AvatarCircle({
    required this.size,
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: child,
    );
  }
}
