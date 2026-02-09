import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Mock message data model
class MockMessage {
  final String id;
  final String senderName;
  final String senderAvatar;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;

  const MockMessage({
    required this.id,
    required this.senderName,
    required this.senderAvatar,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  static const List<MockMessage> _mockMessages = [
    MockMessage(
      id: '1',
      senderName: 'Sarah Wilson',
      senderAvatar: 'assets/images/p.png',
      lastMessage: 'Hey! Are you ready for the Bali trip next week?',
      time: '2m ago',
      unreadCount: 3,
      isOnline: true,
    ),
    MockMessage(
      id: '2',
      senderName: 'Travel Guide Mike',
      senderAvatar: 'assets/images/p2.jpg',
      lastMessage: 'Your booking for Santorini has been confirmed! 🎉',
      time: '15m ago',
      unreadCount: 1,
      isOnline: true,
    ),
    MockMessage(
      id: '3',
      senderName: 'Emily Chen',
      senderAvatar: 'assets/images/p3.png',
      lastMessage: 'The photos from our trip are amazing!',
      time: '1h ago',
      unreadCount: 0,
      isOnline: false,
    ),
    MockMessage(
      id: '4',
      senderName: 'Travenor Support',
      senderAvatar: 'assets/images/logo.png',
      lastMessage: 'Thank you for contacting us. How can we help?',
      time: '3h ago',
      unreadCount: 0,
      isOnline: true,
    ),
    MockMessage(
      id: '5',
      senderName: 'Alex Thompson',
      senderAvatar: 'assets/images/p.png',
      lastMessage: 'Did you see the new destinations added?',
      time: 'Yesterday',
      unreadCount: 0,
      isOnline: false,
    ),
    MockMessage(
      id: '6',
      senderName: 'Maria Garcia',
      senderAvatar: 'assets/images/p2.jpg',
      lastMessage: 'Let\'s plan our next adventure together!',
      time: 'Yesterday',
      unreadCount: 0,
      isOnline: false,
    ),
    MockMessage(
      id: '7',
      senderName: 'Hotel Maldives',
      senderAvatar: 'assets/images/destinations/maldives_beach.png',
      lastMessage: 'We have a special offer for you! 20% off...',
      time: '2 days ago',
      unreadCount: 0,
      isOnline: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Messages',
                        style: AppTextStyles.heading1.copyWith(fontSize: 28),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_mockMessages.where((m) => m.unreadCount > 0).length} unread messages',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.accentTeal,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Search messages...',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Online Now Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Online Now',
                style: AppTextStyles.heading2.copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),

            // Online Users Avatars
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _mockMessages.where((m) => m.isOnline).length,
                itemBuilder: (context, index) {
                  final onlineUsers = _mockMessages
                      .where((m) => m.isOnline)
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: AssetImage(
                                onlineUsers[index].senderAvatar,
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 56,
                          child: Text(
                            onlineUsers[index].senderName.split(' ').first,
                            style: AppTextStyles.bodySmall,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Messages List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Recent Messages',
                style: AppTextStyles.heading2.copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _mockMessages.length,
                itemBuilder: (context, index) {
                  return _buildMessageTile(_mockMessages[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageTile(MockMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar with online indicator
          Stack(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: AssetImage(message.senderAvatar),
              ),
              if (message.isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),

          // Message Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message.senderName,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      message.time,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: message.unreadCount > 0
                            ? AppColors.accentTeal
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        message.lastMessage,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: message.unreadCount > 0
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (message.unreadCount > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentTeal,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message.unreadCount.toString(),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
