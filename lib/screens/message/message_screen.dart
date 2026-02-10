import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

enum MessageStatus { sent, delivered, read }

/// Mock message data model
class MockMessage {
  final String id;
  final String senderName;
  final String senderAvatar;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final bool isTyping;
  final bool isMe;
  final MessageStatus status;

  const MockMessage({
    required this.id,
    required this.senderName,
    required this.senderAvatar,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isTyping = false,
    this.isMe = false,
    this.status = MessageStatus.read,
  });
}

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  static const List<MockMessage> _mockMessages = [
    MockMessage(
      id: '1',
      senderName: 'Sajib Rahman',
      senderAvatar: 'assets/images/p.png',
      lastMessage: 'Hi, John! 👋 How are you doing?',
      time: '09:42',
      isOnline: true,
      status: MessageStatus.read,
    ),
    MockMessage(
      id: '2',
      senderName: 'Adom Shafi',
      senderAvatar: 'assets/images/p2.jpg',
      lastMessage: 'Typing...',
      time: '08:42',
      isOnline: false,
      isTyping: true,
      status: MessageStatus.delivered,
    ),
    MockMessage(
      id: '3',
      senderName: 'HR Rumen',
      senderAvatar: 'assets/images/p3.png',
      lastMessage: 'You: Cool! 😊 Let\'s meet at 18:00 near the traveling!',
      time: 'Yesterday',
      isOnline: true,
      isMe: true,
      status: MessageStatus.read,
    ),
    MockMessage(
      id: '4',
      senderName: 'Anjelina',
      senderAvatar: 'assets/images/p.png',
      lastMessage: 'You: Hey, will you come to the party on Saturday?',
      time: '07:56',
      isOnline: false,
      isMe: true,
      status: MessageStatus.read,
    ),
    MockMessage(
      id: '5',
      senderName: 'Alexa Shorna',
      senderAvatar: 'assets/images/p2.jpg',
      lastMessage: 'Thank you for coming! Your or...',
      time: '05:52',
      isOnline: true,
      status: MessageStatus.delivered,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildSearchBar(),
                    _buildMessageList(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleButton(icon: Icons.arrow_back_ios_new, onTap: () {}),
          Text(
            'Messages',
            style: AppTextStyles.heading2.copyWith(fontSize: 18),
          ),
          _buildCircleButton(icon: Icons.more_vert, onTap: () {}),
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
          color: AppColors.background,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Messages',
            style: AppTextStyles.heading1.copyWith(fontSize: 24),
          ),
          const Icon(IconsaxPlusLinear.edit_2, size: 24),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(
              IconsaxPlusLinear.search_normal_1,
              color: AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for chats & messages',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _mockMessages.length,
      itemBuilder: (context, index) {
        final message = _mockMessages[index];
        return _buildMessageTile(context, message);
      },
    );
  }

  Widget _buildMessageTile(BuildContext context, MockMessage message) {
    return InkWell(
      onTap: () => context.push('/chat', extra: message),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            _buildAvatar(message),
            const SizedBox(width: 15),
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
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (!message.isTyping)
                        _buildStatusIndicator(message.status),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          message.lastMessage,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: message.isTyping
                                ? AppColors.accentTeal
                                : AppColors.textSecondary,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!message.isTyping)
                        Text(
                          message.time,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(MockMessage message) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(message.senderAvatar),
        ),
        if (message.isOnline || message.isTyping)
          Positioned(
            right: 0,
            bottom: 2,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: message.isOnline ? Colors.orange : Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 3),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStatusIndicator(MessageStatus status) {
    IconData icon;
    Color color;

    switch (status) {
      case MessageStatus.sent:
        icon = Icons.check;
        color = AppColors.textSecondary;
        break;
      case MessageStatus.delivered:
        icon = IconsaxPlusBold.tick_circle;
        color = AppColors.textSecondary;
        break;
      case MessageStatus.read:
        icon = IconsaxPlusBold.tick_circle;
        color = Colors.green;
        break;
    }

    return Icon(icon, size: 16, color: color);
  }
}
