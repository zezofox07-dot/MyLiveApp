import 'package:sawa_chat/models/message_model.dart';
import 'package:sawa_chat/services/storage_service.dart';

class MessageService {
  static final MessageService _instance = MessageService._internal();
  factory MessageService() => _instance;
  MessageService._internal();

  final _storage = StorageService();
  static const String _messagesKey = 'messages';

  Future<void> init() async {
    await _storage.init();
    await _initializeSampleData();
  }

  Future<void> _initializeSampleData() async {
    final messages = await getAllMessages();
    if (messages.isEmpty) {
      final sampleMessages = _createSampleMessages();
      await _storage.saveJsonList(_messagesKey, sampleMessages.map((m) => m.toJson()).toList());
    }
  }

  List<MessageModel> _createSampleMessages() {
    final now = DateTime.now();
    return [
      MessageModel(
        id: '1',
        senderId: '2',
        receiverId: '1',
        content: 'مرحباً، كيف حالك؟',
        messageType: 'text',
        isRead: true,
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
      MessageModel(
        id: '2',
        senderId: '1',
        receiverId: '2',
        content: 'الحمد لله، وأنت؟',
        messageType: 'text',
        isRead: true,
        createdAt: now.subtract(const Duration(hours: 1, minutes: 55)),
        updatedAt: now.subtract(const Duration(hours: 1, minutes: 55)),
      ),
      MessageModel(
        id: '3',
        senderId: '2',
        receiverId: '1',
        content: 'بخير، شكراً على السؤال',
        messageType: 'text',
        isRead: true,
        createdAt: now.subtract(const Duration(hours: 1, minutes: 50)),
        updatedAt: now.subtract(const Duration(hours: 1, minutes: 50)),
      ),
      MessageModel(
        id: '4',
        senderId: '3',
        receiverId: '1',
        content: 'هل أنت متاح للدردشة؟',
        messageType: 'text',
        isRead: false,
        createdAt: now.subtract(const Duration(minutes: 30)),
        updatedAt: now.subtract(const Duration(minutes: 30)),
      ),
      MessageModel(
        id: '5',
        senderId: '4',
        receiverId: '1',
        content: 'شكراً على الهدية! 🎁',
        messageType: 'text',
        isRead: false,
        createdAt: now.subtract(const Duration(minutes: 15)),
        updatedAt: now.subtract(const Duration(minutes: 15)),
      ),
      MessageModel(
        id: '6',
        senderId: '5',
        receiverId: '1',
        content: 'هل تريد الانضمام إلى غرفتي؟',
        messageType: 'text',
        isRead: false,
        createdAt: now.subtract(const Duration(minutes: 5)),
        updatedAt: now.subtract(const Duration(minutes: 5)),
      ),
    ];
  }

  Future<List<MessageModel>> getAllMessages() async {
    final jsonList = _storage.getJsonList(_messagesKey);
    return jsonList.map((json) => MessageModel.fromJson(json)).toList();
  }

  Future<List<MessageModel>> getConversation(String userId1, String userId2) async {
    final messages = await getAllMessages();
    return messages.where((m) =>
      (m.senderId == userId1 && m.receiverId == userId2) ||
      (m.senderId == userId2 && m.receiverId == userId1)
    ).toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  Future<List<Map<String, dynamic>>> getConversationsList(String userId) async {
    final messages = await getAllMessages();
    final userMessages = messages.where((m) =>
      m.senderId == userId || m.receiverId == userId
    ).toList();

    final Map<String, MessageModel> lastMessages = {};
    for (var message in userMessages) {
      final otherUserId = message.senderId == userId ? message.receiverId : message.senderId;
      if (!lastMessages.containsKey(otherUserId) ||
          message.createdAt.isAfter(lastMessages[otherUserId]!.createdAt)) {
        lastMessages[otherUserId] = message;
      }
    }

    final conversations = lastMessages.entries.map((entry) {
      final unreadCount = userMessages.where((m) =>
        m.senderId == entry.key && m.receiverId == userId && !m.isRead
      ).length;

      return {
        'userId': entry.key,
        'lastMessage': entry.value,
        'unreadCount': unreadCount,
      };
    }).toList();

    conversations.sort((a, b) => (b['lastMessage'] as MessageModel).createdAt
        .compareTo((a['lastMessage'] as MessageModel).createdAt));

    return conversations;
  }

  Future<void> sendMessage(MessageModel message) async {
    final messages = await getAllMessages();
    messages.add(message);
    await _storage.saveJsonList(_messagesKey, messages.map((m) => m.toJson()).toList());
  }

  Future<void> markAsRead(String messageId) async {
    final messages = await getAllMessages();
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index != -1) {
      messages[index] = messages[index].copyWith(
        isRead: true,
        updatedAt: DateTime.now(),
      );
      await _storage.saveJsonList(_messagesKey, messages.map((m) => m.toJson()).toList());
    }
  }

  Future<void> markConversationAsRead(String userId1, String userId2) async {
    final messages = await getAllMessages();
    bool updated = false;
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].senderId == userId2 &&
          messages[i].receiverId == userId1 &&
          !messages[i].isRead) {
        messages[i] = messages[i].copyWith(
          isRead: true,
          updatedAt: DateTime.now(),
        );
        updated = true;
      }
    }
    if (updated) {
      await _storage.saveJsonList(_messagesKey, messages.map((m) => m.toJson()).toList());
    }
  }

  Future<void> deleteMessage(String id) async {
    final messages = await getAllMessages();
    messages.removeWhere((m) => m.id == id);
    await _storage.saveJsonList(_messagesKey, messages.map((m) => m.toJson()).toList());
  }

  Future<int> getUnreadCount(String userId) async {
    final messages = await getAllMessages();
    return messages.where((m) => m.receiverId == userId && !m.isRead).length;
  }
}
