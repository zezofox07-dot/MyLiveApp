class UserModel {
  final String id;
  final String email;
  final String username;
  final String displayName;
  final String avatarUrl;
  final String? backgroundImageUrl;
  final String? gender;
  final String countryCode;
  final String countryFlag;
  final int goldCoins;
  final int diamonds;
  final int level;
  final int experience;
  final int vipLevel;
  final int svipLevel;
  final int followersCount;
  final int followingCount;
  final int friendsCount;
  final int visitorsCount;
  final List<String> achievements;
  final int dailyLoginStreak;
  final bool isOnline;
  final DateTime lastSeen;
  final String currentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.displayName,
    required this.avatarUrl,
    this.backgroundImageUrl,
    this.gender,
    required this.countryCode,
    required this.countryFlag,
    this.goldCoins = 0,
    this.diamonds = 0,
    this.level = 1,
    this.experience = 0,
    this.vipLevel = 0,
    this.svipLevel = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.friendsCount = 0,
    this.visitorsCount = 0,
    this.achievements = const [],
    this.dailyLoginStreak = 0,
    this.isOnline = false,
    required this.lastSeen,
    this.currentStatus = 'متاح',
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'username': username,
    'displayName': displayName,
    'avatarUrl': avatarUrl,
    'backgroundImageUrl': backgroundImageUrl,
    'gender': gender,
    'countryCode': countryCode,
    'countryFlag': countryFlag,
    'goldCoins': goldCoins,
    'diamonds': diamonds,
    'level': level,
    'experience': experience,
    'vipLevel': vipLevel,
    'svipLevel': svipLevel,
    'followersCount': followersCount,
    'followingCount': followingCount,
    'friendsCount': friendsCount,
    'visitorsCount': visitorsCount,
    'achievements': achievements,
    'dailyLoginStreak': dailyLoginStreak,
    'isOnline': isOnline,
    'lastSeen': lastSeen.toIso8601String(),
    'currentStatus': currentStatus,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? '',
    email: json['email'] ?? '',
    username: json['username'] ?? '',
    displayName: json['displayName'] ?? '',
    avatarUrl: json['avatarUrl'] ?? '',
    backgroundImageUrl: json['backgroundImageUrl'],
    gender: json['gender'],
    countryCode: json['countryCode'] ?? 'SA',
    countryFlag: json['countryFlag'] ?? '🇸🇦',
    goldCoins: json['goldCoins'] ?? 0,
    diamonds: json['diamonds'] ?? 0,
    level: json['level'] ?? 1,
    experience: json['experience'] ?? 0,
    vipLevel: json['vipLevel'] ?? 0,
    svipLevel: json['svipLevel'] ?? 0,
    followersCount: json['followersCount'] ?? 0,
    followingCount: json['followingCount'] ?? 0,
    friendsCount: json['friendsCount'] ?? 0,
    visitorsCount: json['visitorsCount'] ?? 0,
    achievements: List<String>.from(json['achievements'] ?? []),
    dailyLoginStreak: json['dailyLoginStreak'] ?? 0,
    isOnline: json['isOnline'] ?? false,
    lastSeen: DateTime.parse(json['lastSeen'] ?? DateTime.now().toIso8601String()),
    currentStatus: json['currentStatus'] ?? 'متاح',
    createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
  );

  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? displayName,
    String? avatarUrl,
    String? backgroundImageUrl,
    String? gender,
    String? countryCode,
    String? countryFlag,
    int? goldCoins,
    int? diamonds,
    int? level,
    int? experience,
    int? vipLevel,
    int? svipLevel,
    int? followersCount,
    int? followingCount,
    int? friendsCount,
    int? visitorsCount,
    List<String>? achievements,
    int? dailyLoginStreak,
    bool? isOnline,
    DateTime? lastSeen,
    String? currentStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    username: username ?? this.username,
    displayName: displayName ?? this.displayName,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    backgroundImageUrl: backgroundImageUrl ?? this.backgroundImageUrl,
    gender: gender ?? this.gender,
    countryCode: countryCode ?? this.countryCode,
    countryFlag: countryFlag ?? this.countryFlag,
    goldCoins: goldCoins ?? this.goldCoins,
    diamonds: diamonds ?? this.diamonds,
    level: level ?? this.level,
    experience: experience ?? this.experience,
    vipLevel: vipLevel ?? this.vipLevel,
    svipLevel: svipLevel ?? this.svipLevel,
    followersCount: followersCount ?? this.followersCount,
    followingCount: followingCount ?? this.followingCount,
    friendsCount: friendsCount ?? this.friendsCount,
    visitorsCount: visitorsCount ?? this.visitorsCount,
    achievements: achievements ?? this.achievements,
    dailyLoginStreak: dailyLoginStreak ?? this.dailyLoginStreak,
    isOnline: isOnline ?? this.isOnline,
    lastSeen: lastSeen ?? this.lastSeen,
    currentStatus: currentStatus ?? this.currentStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
