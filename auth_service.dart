import 'package:sawa_chat/models/user_model.dart';
import 'package:sawa_chat/services/storage_service.dart';
import 'package:sawa_chat/services/user_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final _storage = StorageService();
  final _userService = UserService();

  static const String _currentUserIdKey = 'current_user_id';
  static const String _isLoggedInKey = 'is_logged_in';

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<void> init() async {
    await _storage.init();
    await _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final isLoggedIn = _storage.getBool(_isLoggedInKey) ?? false;
    if (isLoggedIn) {
      final userId = _storage.getString(_currentUserIdKey);
      if (userId != null) {
        _currentUser = await _userService.getUserById(userId);
        if (_currentUser != null) {
          await _userService.updateUserStatus(_currentUser!.id, isOnline: true);
        }
      }
    }
  }

  Future<UserModel?> login(String email, String password) async {
    final users = await _userService.getAllUsers();
    final user = users.firstWhere(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
      orElse: () => users.first,
    );

    await _setCurrentUser(user);
    return user;
  }

  Future<UserModel?> signInWithGoogle() async {
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: 'user@gmail.com',
      username: 'مستخدم جديد',
      displayName: 'مستخدم جديد',
      avatarUrl: 'https://i.pravatar.cc/150?img=${DateTime.now().millisecond % 70}',
      countryCode: 'SA',
      countryFlag: '🇸🇦',
      goldCoins: 500,
      diamonds: 100,
      lastSeen: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _userService.createUser(user);
    await _setCurrentUser(user);
    return user;
  }

  Future<UserModel?> signInWithFacebook() async {
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: 'user@facebook.com',
      username: 'مستخدم فيسبوك',
      displayName: 'مستخدم فيسبوك',
      avatarUrl: 'https://i.pravatar.cc/150?img=${DateTime.now().millisecond % 70}',
      countryCode: 'SA',
      countryFlag: '🇸🇦',
      goldCoins: 500,
      diamonds: 100,
      lastSeen: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _userService.createUser(user);
    await _setCurrentUser(user);
    return user;
  }

  Future<UserModel?> signInWithPhone(String phone, String code) async {
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: '$phone@phone.com',
      username: 'مستخدم $phone',
      displayName: 'مستخدم $phone',
      avatarUrl: 'https://i.pravatar.cc/150?img=${DateTime.now().millisecond % 70}',
      countryCode: 'SA',
      countryFlag: '🇸🇦',
      goldCoins: 500,
      diamonds: 100,
      lastSeen: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _userService.createUser(user);
    await _setCurrentUser(user);
    return user;
  }

  Future<UserModel?> register(String email, String password, String username) async {
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      username: username,
      displayName: username,
      avatarUrl: 'https://i.pravatar.cc/150?img=${DateTime.now().millisecond % 70}',
      countryCode: 'SA',
      countryFlag: '🇸🇦',
      goldCoins: 500,
      diamonds: 100,
      lastSeen: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _userService.createUser(user);
    await _setCurrentUser(user);
    return user;
  }

  Future<void> _setCurrentUser(UserModel user) async {
    _currentUser = user;
    await _storage.saveString(_currentUserIdKey, user.id);
    await _storage.saveBool(_isLoggedInKey, true);
    await _userService.updateUserStatus(user.id, isOnline: true);
  }

  Future<void> logout() async {
    if (_currentUser != null) {
      await _userService.updateUserStatus(_currentUser!.id, isOnline: false);
    }
    _currentUser = null;
    await _storage.remove(_currentUserIdKey);
    await _storage.saveBool(_isLoggedInKey, false);
  }

  Future<void> updateProfile({
    String? displayName,
    String? avatarUrl,
    String? backgroundImageUrl,
    String? gender,
    String? countryCode,
    String? countryFlag,
    String? currentStatus,
  }) async {
    if (_currentUser == null) return;

    final updatedUser = _currentUser!.copyWith(
      displayName: displayName,
      avatarUrl: avatarUrl,
      backgroundImageUrl: backgroundImageUrl,
      gender: gender,
      countryCode: countryCode,
      countryFlag: countryFlag,
      currentStatus: currentStatus,
      updatedAt: DateTime.now(),
    );

    await _userService.updateUser(updatedUser);
    _currentUser = updatedUser;
  }
}
