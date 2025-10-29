import 'package:sawa_chat/models/user_model.dart';
import 'package:sawa_chat/services/storage_service.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final _storage = StorageService();
  static const String _usersKey = 'users';

  Future<void> init() async {
    await _storage.init();
    await _initializeSampleData();
  }

  Future<void> _initializeSampleData() async {
    final users = await getAllUsers();
    if (users.isEmpty) {
      final sampleUsers = _createSampleUsers();
      await _storage.saveJsonList(_usersKey, sampleUsers.map((u) => u.toJson()).toList());
    }
  }

  List<UserModel> _createSampleUsers() => [
    UserModel(
      id: '1',
      email: 'ahmad@example.com',
      username: 'أحمد محمد',
      displayName: 'أحمد محمد',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      countryCode: 'SA',
      countryFlag: '🇸🇦',
      goldCoins: 15000,
      diamonds: 500,
      level: 25,
      experience: 12500,
      vipLevel: 3,
      svipLevel: 1,
      followersCount: 1250,
      followingCount: 340,
      friendsCount: 89,
      visitorsCount: 5430,
      achievements: ['نجم الغرفة', 'ملك الميكروفون', 'مؤثر الأسبوع'],
      dailyLoginStreak: 15,
      isOnline: true,
      lastSeen: DateTime.now(),
      currentStatus: 'متاح للدردشة',
      createdAt: DateTime.now().subtract(const Duration(days: 180)),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: '2',
      email: 'fatima@example.com',
      username: 'فاطمة أحمد',
      displayName: 'فاطمة أحمد',
      avatarUrl: 'https://i.pravatar.cc/150?img=45',
      countryCode: 'EG',
      countryFlag: '🇪🇬',
      goldCoins: 8500,
      diamonds: 250,
      level: 18,
      experience: 8500,
      vipLevel: 2,
      svipLevel: 0,
      followersCount: 890,
      followingCount: 210,
      friendsCount: 56,
      visitorsCount: 3210,
      achievements: ['نجمة الأسبوع', 'صوت رائع'],
      dailyLoginStreak: 7,
      isOnline: true,
      lastSeen: DateTime.now().subtract(const Duration(minutes: 5)),
      currentStatus: 'مشغول',
      createdAt: DateTime.now().subtract(const Duration(days: 120)),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: '3',
      email: 'mohammed@example.com',
      username: 'محمد علي',
      displayName: 'محمد علي',
      avatarUrl: 'https://i.pravatar.cc/150?img=33',
      countryCode: 'AE',
      countryFlag: '🇦🇪',
      goldCoins: 22000,
      diamonds: 800,
      level: 32,
      experience: 18000,
      vipLevel: 5,
      svipLevel: 2,
      followersCount: 2150,
      followingCount: 450,
      friendsCount: 125,
      visitorsCount: 8900,
      achievements: ['ملك الغرف', 'أسطورة', 'نجم الشهر'],
      dailyLoginStreak: 30,
      isOnline: false,
      lastSeen: DateTime.now().subtract(const Duration(hours: 2)),
      currentStatus: 'غير متصل',
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: '4',
      email: 'sara@example.com',
      username: 'سارة خالد',
      displayName: 'سارة خالد',
      avatarUrl: 'https://i.pravatar.cc/150?img=47',
      countryCode: 'KW',
      countryFlag: '🇰🇼',
      goldCoins: 5600,
      diamonds: 150,
      level: 12,
      experience: 5200,
      vipLevel: 1,
      svipLevel: 0,
      followersCount: 450,
      followingCount: 180,
      friendsCount: 34,
      visitorsCount: 1890,
      achievements: ['صديقة الجميع'],
      dailyLoginStreak: 4,
      isOnline: true,
      lastSeen: DateTime.now(),
      currentStatus: 'متاح',
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: '5',
      email: 'omar@example.com',
      username: 'عمر حسن',
      displayName: 'عمر حسن',
      avatarUrl: 'https://i.pravatar.cc/150?img=52',
      countryCode: 'JO',
      countryFlag: '🇯🇴',
      goldCoins: 12500,
      diamonds: 400,
      level: 22,
      experience: 10500,
      vipLevel: 4,
      svipLevel: 1,
      followersCount: 1680,
      followingCount: 390,
      friendsCount: 92,
      visitorsCount: 6200,
      achievements: ['نجم متألق', 'محترم'],
      dailyLoginStreak: 12,
      isOnline: false,
      lastSeen: DateTime.now().subtract(const Duration(hours: 5)),
      currentStatus: 'غير متصل',
      createdAt: DateTime.now().subtract(const Duration(days: 200)),
      updatedAt: DateTime.now(),
    ),
  ];

  Future<List<UserModel>> getAllUsers() async {
    final jsonList = _storage.getJsonList(_usersKey);
    return jsonList.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<UserModel?> getUserById(String id) async {
    final users = await getAllUsers();
    try {
      return users.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> createUser(UserModel user) async {
    final users = await getAllUsers();
    users.add(user);
    await _storage.saveJsonList(_usersKey, users.map((u) => u.toJson()).toList());
  }

  Future<void> updateUser(UserModel user) async {
    final users = await getAllUsers();
    final index = users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      users[index] = user;
      await _storage.saveJsonList(_usersKey, users.map((u) => u.toJson()).toList());
    }
  }

  Future<void> deleteUser(String id) async {
    final users = await getAllUsers();
    users.removeWhere((u) => u.id == id);
    await _storage.saveJsonList(_usersKey, users.map((u) => u.toJson()).toList());
  }

  Future<void> updateUserStatus(String userId, {bool? isOnline, String? status}) async {
    final user = await getUserById(userId);
    if (user != null) {
      final updatedUser = user.copyWith(
        isOnline: isOnline ?? user.isOnline,
        currentStatus: status ?? user.currentStatus,
        lastSeen: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await updateUser(updatedUser);
    }
  }

  Future<void> updateCoins(String userId, int goldCoins, int diamonds) async {
    final user = await getUserById(userId);
    if (user != null) {
      final updatedUser = user.copyWith(
        goldCoins: goldCoins,
        diamonds: diamonds,
        updatedAt: DateTime.now(),
      );
      await updateUser(updatedUser);
    }
  }

  Future<void> addExperience(String userId, int exp) async {
    final user = await getUserById(userId);
    if (user != null) {
      final newExp = user.experience + exp;
      final newLevel = (newExp / 500).floor() + 1;
      final updatedUser = user.copyWith(
        experience: newExp,
        level: newLevel,
        updatedAt: DateTime.now(),
      );
      await updateUser(updatedUser);
    }
  }

  Future<void> updateFollowers(String userId, int count) async {
    final user = await getUserById(userId);
    if (user != null) {
      final updatedUser = user.copyWith(
        followersCount: count,
        updatedAt: DateTime.now(),
      );
      await updateUser(updatedUser);
    }
  }

  Future<void> addAchievement(String userId, String achievement) async {
    final user = await getUserById(userId);
    if (user != null) {
      final achievements = List<String>.from(user.achievements);
      if (!achievements.contains(achievement)) {
        achievements.add(achievement);
        final updatedUser = user.copyWith(
          achievements: achievements,
          updatedAt: DateTime.now(),
        );
        await updateUser(updatedUser);
      }
    }
  }
}
