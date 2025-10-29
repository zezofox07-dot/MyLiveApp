class TransactionModel {
  final String id;
  final String userId;
  final String type;
  final int amount;
  final String currency;
  final String description;
  final String? relatedUserId;
  final String? relatedItemId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.currency,
    required this.description,
    this.relatedUserId,
    this.relatedItemId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'type': type,
    'amount': amount,
    'currency': currency,
    'description': description,
    'relatedUserId': relatedUserId,
    'relatedItemId': relatedItemId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    id: json['id'] ?? '',
    userId: json['userId'] ?? '',
    type: json['type'] ?? '',
    amount: json['amount'] ?? 0,
    currency: json['currency'] ?? 'gold',
    description: json['description'] ?? '',
    relatedUserId: json['relatedUserId'],
    relatedItemId: json['relatedItemId'],
    createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
  );

  TransactionModel copyWith({
    String? id,
    String? userId,
    String? type,
    int? amount,
    String? currency,
    String? description,
    String? relatedUserId,
    String? relatedItemId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TransactionModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    description: description ?? this.description,
    relatedUserId: relatedUserId ?? this.relatedUserId,
    relatedItemId: relatedItemId ?? this.relatedItemId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
