import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'message_screen.dart'; // To use MockMessage and MessageStatus

class ChatDetailsScreen extends StatelessWidget {
  final MockMessage contact;

  const ChatDetailsScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(child: _buildChatList()),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            _buildCircleButton(
              icon: Icons.arrow_back_ios_new,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: Column(
                children: [
                  Text(
                    contact.senderName,
                    style: AppTextStyles.heading2.copyWith(fontSize: 18),
                  ),
                  Text(
                    'Active Now',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            _buildCircleButton(icon: Icons.phone_outlined, onTap: () {}),
          ],
        ),
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

  Widget _buildChatList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: [
        _buildDateSeparator('Today'),
        const SizedBox(height: 20),
        _buildMessageBubble(
          message: 'Hello!',
          time: '9:24',
          isMe: false,
          showAvatar: false,
          status: MessageStatus.read,
        ),
        _buildMessageBubble(
          message:
              'Thank you very mouch for your traveling, we really like the apartments. we will stay here for anather 5 days...',
          time: '9:30',
          isMe: false,
          showAvatar:
              true, // Last message from them in a group usually has avatar in design
          status: MessageStatus.delivered,
        ),
        _buildMessageBubble(
          message: 'Hello!',
          time: '9:34',
          isMe: true,
          status: MessageStatus.read,
        ),
        _buildMessageBubble(
          message: 'I\'m very glab you like it👍',
          time: '9:35',
          isMe: true,
          showAvatar: true,
          status: MessageStatus.read,
        ),
        _buildMessageBubble(
          message: 'We are arriving today at 01:45, will someone be at home?',
          time: '9:37',
          isMe: false,
          showAvatar: true,
          status: MessageStatus.read,
        ),
        _buildMessageBubble(
          message: 'I will be at home',
          time: '9:39',
          isMe: true,
          status: MessageStatus.delivered,
        ),
      ],
    );
  }

  Widget _buildDateSeparator(String date) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          date,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble({
    required String message,
    required String time,
    required bool isMe,
    bool showAvatar = false,
    MessageStatus status = MessageStatus.read,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && showAvatar)
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(contact.senderAvatar),
            )
          else if (!isMe)
            const SizedBox(width: 40),
          const SizedBox(width: 10),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isMe
                    ? AppColors.accentTeal.withValues(alpha: 0.1)
                    : AppColors.background.withValues(alpha: 0.5),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isMe ? const Radius.circular(20) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : const Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (isMe) _buildStatusIcon(status),
                      if (!isMe)
                        _buildStatusIcon(
                          status,
                        ), // Design shows checkmarks for both? Double checking... Design shows green ticks for them?
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (isMe && showAvatar)
            CircleAvatar(
              radius: 20,
              backgroundImage: const AssetImage(
                'assets/images/p.png',
              ), // Current user avatar
            )
          else if (isMe)
            const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(MessageStatus status) {
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

    return Icon(icon, size: 12, color: color);
  }

  Widget _buildInputBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText:
                              'Type you message', // Match design typo? "Type you message"
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.attach_file,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.accentTeal,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mic_none_outlined,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
