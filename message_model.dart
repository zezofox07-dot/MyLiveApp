class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String messageType;
  final String? mediaUrl;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    this.messageType = 'text',
    this.mediaUrl,
    this.isRead = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'senderId': senderId,
    'receiverId': receiverId,
    'content': content,
    'messageType': messageType,
    'mediaUrl': mediaUrl,
    'isRead': isRead,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'] ?? '',
    senderId: json['senderId'] ?? '',
    receiverId: json['receiverId'] ?? '',
    content: json['content'] ?? '',
    messageType: json['messageType'] ?? 'text',
    mediaUrl: json['mediaUrl'],
    isRead: json['isRead'] ?? false,
    createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
  );

  MessageModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? content,
    String? messageType,
    String? mediaUrl,
    bool? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MessageModel(
    id: id ?? this.id,
    senderId: senderId ?? this.senderId,
    receiverId: receiverId ?? this.receiverId,
    content: content ?? this.content,
    messageType: messageType ?? this.messageType,
    mediaUrl: mediaUrl ?? this.mediaUrl,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
