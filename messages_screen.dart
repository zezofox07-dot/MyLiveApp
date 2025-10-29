import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/models/user_model.dart';
import 'package:sawa_chat/models/message_model.dart';
import 'package:sawa_chat/services/message_service.dart';
import 'package:sawa_chat/services/user_service.dart';
import 'package:sawa_chat/providers/app_state.dart';
import 'package:sawa_chat/widgets/user_avatar.dart';
import 'package:sawa_chat/screens/chat_screen.dart';
import 'package:intl/intl.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _messageService = MessageService();
  final _userService = UserService();
  List<Map<String, dynamic>> _conversations = [];
  Map<String, UserModel> _users = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    final currentUser = context.read<AppState>().currentUser;
    if (currentUser == null) return;

    final conversations = await _messageService.getConversationsList(currentUser.id);
    final users = <String, UserModel>{};

    for (var conv in conversations) {
      final userId = conv['userId'] as String;
      final user = await _userService.getUserById(userId);
      if (user != null) {
        users[userId] = user;
      }
    }

    setState(() {
      _conversations = conversations;
      _users = users;
      _isLoading = false;
    });
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} د';
    } else if (difference.inDays < 1) {
      return DateFormat.Hm('ar').format(dateTime);
    } else if (difference.inDays < 7) {
      return '${difference.inDays} يوم';
    } else {
      return DateFormat.MMMd('ar').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرسائل'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.gold),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add_comment, color: AppColors.gold),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
          : _conversations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.chat_bubble_outline, size: 64, color: AppColors.textTertiary),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد محادثات بعد',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'ابدأ محادثة جديدة',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadConversations,
                  color: AppColors.gold,
                  child: ListView.builder(
                    itemCount: _conversations.length,
                    itemBuilder: (context, index) {
                      final conv = _conversations[index];
                      final userId = conv['userId'] as String;
                      final lastMessage = conv['lastMessage'] as MessageModel;
                      final unreadCount = conv['unreadCount'] as int;
                      final user = _users[userId];

                      if (user == null) return const SizedBox.shrink();

                      return _buildConversationTile(user, lastMessage, unreadCount);
                    },
                  ),
                ),
    );
  }

  Widget _buildConversationTile(UserModel user, MessageModel lastMessage, int unreadCount) {
    final currentUser = context.read<AppState>().currentUser;
    final isMyMessage = lastMessage.senderId == currentUser?.id;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(otherUser: user),
          ),
        ).then((_) => _loadConversations());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.darkCard,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            UserAvatar(
              avatarUrl: user.avatarUrl,
              size: 56,
              vipLevel: user.vipLevel,
              svipLevel: user.svipLevel,
              showOnlineStatus: true,
              isOnline: user.isOnline,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          user.displayName,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatTime(lastMessage.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (isMyMessage)
                        const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.done_all,
                            size: 16,
                            color: AppColors.neonBlue,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          lastMessage.content,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: unreadCount > 0 ? AppColors.textPrimary : AppColors.textSecondary,
                            fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.gold,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  unreadCount > 99 ? '99+' : '$unreadCount',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
