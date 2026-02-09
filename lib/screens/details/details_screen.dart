import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/destination.dart';
import 'widgets/details_bottom_sheet_painter.dart';

class DetailsScreen extends StatelessWidget {
  final Destination destination;

  const DetailsScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.52;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Image - Full screen behind
          Positioned.fill(
            child: Image.asset(destination.pictures.first, fit: BoxFit.cover),
          ),

          // Top Action Buttons
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.pop(context),
                ),
                Text(
                  'Details',
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
                _buildCircleButton(
                  icon: destination.isFavorite
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // Bottom Sheet with Custom Painter
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DetailsBottomSheet(
              height: bottomSheetHeight,
              color: AppColors.white,
              child: _buildBottomContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.accentTeal.withValues(alpha: 0.7),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.white, size: 18),
      ),
    );
  }

  Widget _buildBottomContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Avatar Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      style: AppTextStyles.heading1.copyWith(fontSize: 24),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      destination.location,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/p.png'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Location, Rating, Price Row
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                destination.location,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                '${destination.rating.rate} (${destination.rating.people})',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '\$${destination.price.toInt()}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.accentTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '/Person',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accentTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Mini Gallery
          SizedBox(
            height: 56,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _getGalleryItems().length,
              itemBuilder: (context, index) {
                final items = _getGalleryItems();
                if (index == items.length - 1 && items.length >= 5) {
                  return _buildGalleryItem(
                    items[index],
                    overlay: '+${destination.rating.people ~/ 100}',
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _buildGalleryItem(items[index]),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // About Section Header
          Text(
            'About Destination',
            style: AppTextStyles.heading2.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 10),

          // Scrollable About Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                destination.about,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Book Now Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentTeal,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Book Now',
                style: AppTextStyles.button.copyWith(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getGalleryItems() {
    // Use destination pictures plus some fallback images
    final List<String> gallery = [...destination.pictures];

    // Add placeholder images if less than 5
    final placeholders = [
      'assets/images/onboarding_1.png',
      'assets/images/onboarding_2.png',
      'assets/images/onboarding_3.png',
    ];

    while (gallery.length < 5) {
      gallery.add(placeholders[gallery.length % placeholders.length]);
    }

    return gallery.take(5).toList();
  }

  Widget _buildGalleryItem(String imagePath, {String? overlay}) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: overlay != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  overlay,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
