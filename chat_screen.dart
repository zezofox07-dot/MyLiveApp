import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/models/user_model.dart';
import 'package:sawa_chat/models/message_model.dart';
import 'package:sawa_chat/services/message_service.dart';
import 'package:sawa_chat/providers/app_state.dart';
import 'package:sawa_chat/widgets/user_avatar.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final UserModel otherUser;

  const ChatScreen({super.key, required this.otherUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageService = MessageService();
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  List<MessageModel> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    final currentUser = context.read<AppState>().currentUser;
    if (currentUser == null) return;

    final messages = await _messageService.getConversation(
      currentUser.id,
      widget.otherUser.id,
    );

    await _messageService.markConversationAsRead(
      currentUser.id,
      widget.otherUser.id,
    );

    setState(() {
      _messages = messages;
      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final currentUser = context.read<AppState>().currentUser;
    if (currentUser == null) return;

    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: currentUser.id,
      receiverId: widget.otherUser.id,
      content: _messageController.text.trim(),
      messageType: 'text',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _messageService.sendMessage(message);
    _messageController.clear();
    await _loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              UserAvatar(
                avatarUrl: widget.otherUser.avatarUrl,
                size: 40,
                vipLevel: widget.otherUser.vipLevel,
                svipLevel: widget.otherUser.svipLevel,
                showOnlineStatus: true,
                isOnline: widget.otherUser.isOnline,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.otherUser.displayName,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.otherUser.isOnline ? 'متصل' : 'غير متصل',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: widget.otherUser.isOnline
                            ? AppColors.online
                            : AppColors.offline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.call, color: AppColors.gold),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.gold),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
                  : _messages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.chat_bubble_outline, size: 64, color: AppColors.textTertiary),
                              const SizedBox(height: 16),
                              Text(
                                'لا توجد رسائل بعد',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'ابدأ المحادثة بإرسال رسالة',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) => _buildMessageBubble(_messages[index]),
                        ),
            ),
            _buildMessageInput(),
          ],
        ),
      );
  }

  Widget _buildMessageBubble(MessageModel message) {
    final currentUser = context.read<AppState>().currentUser;
    final isMe = message.senderId == currentUser?.id;

    return Align(
      alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: isMe
                    ? const LinearGradient(
                        colors: [AppColors.gold, AppColors.neonBlue],
                      )
                    : null,
                color: isMe ? null : AppColors.darkCard,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isMe ? const Radius.circular(4) : const Radius.circular(16),
                  bottomRight: isMe ? const Radius.circular(16) : const Radius.circular(4),
                ),
                boxShadow: [
                  if (isMe)
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.3),
                      blurRadius: 8,
                    ),
                ],
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: isMe ? Colors.black : AppColors.textPrimary,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                DateFormat.jm('ar').format(message.createdAt),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: AppColors.neonBlue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: AppColors.gold),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'اكتب رسالة...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.gold, AppColors.neonBlue],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.black),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
