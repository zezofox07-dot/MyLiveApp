class GiftModel {
  final String id;
  final String name;
  final String nameAr;
  final int price;
  final String currency;
  final String imageUrl;
  final String? animationUrl;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;

  GiftModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.price,
    this.currency = 'gold',
    required this.imageUrl,
    this.animationUrl,
    this.category = 'general',
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nameAr': nameAr,
    'price': price,
    'currency': currency,
    'imageUrl': imageUrl,
    'animationUrl': animationUrl,
    'category': category,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory GiftModel.fromJson(Map<String, dynamic> json) => GiftModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    nameAr: json['nameAr'] ?? '',
    price: json['price'] ?? 0,
    currency: json['currency'] ?? 'gold',
    imageUrl: json['imageUrl'] ?? '',
    animationUrl: json['animationUrl'],
    category: json['category'] ?? 'general',
    createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
  );

  GiftModel copyWith({
    String? id,
    String? name,
    String? nameAr,
    int? price,
    String? currency,
    String? imageUrl,
    String? animationUrl,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => GiftModel(
    id: id ?? this.id,
    name: name ?? this.name,
    nameAr: nameAr ?? this.nameAr,
    price: price ?? this.price,
    currency: currency ?? this.currency,
    imageUrl: imageUrl ?? this.imageUrl,
    animationUrl: animationUrl ?? this.animationUrl,
    category: category ?? this.category,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
