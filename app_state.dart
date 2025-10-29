import 'package:flutter/foundation.dart';
import 'package:sawa_chat/models/user_model.dart';
import 'package:sawa_chat/services/auth_service.dart';
import 'package:sawa_chat/services/user_service.dart';
import 'package:sawa_chat/services/room_service.dart';
import 'package:sawa_chat/services/message_service.dart';
import 'package:sawa_chat/services/gift_service.dart';
import 'package:sawa_chat/services/transaction_service.dart';

class AppState extends ChangeNotifier {
  final _authService = AuthService();
  final _userService = UserService();
  final _roomService = RoomService();
  final _messageService = MessageService();
  final _giftService = GiftService();
  final _transactionService = TransactionService();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  UserModel? get currentUser => _authService.currentUser;
  bool get isLoggedIn => _authService.isLoggedIn;

  Future<void> initialize() async {
    if (_isInitialized) return;

    await _authService.init();
    await _userService.init();
    await _roomService.init();
    await _messageService.init();
    await _giftService.init();
    await _transactionService.init();

    _isInitialized = true;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final user = await _authService.login(email, password);
    notifyListeners();
    return user != null;
  }

  Future<bool> signInWithGoogle() async {
    final user = await _authService.signInWithGoogle();
    notifyListeners();
    return user != null;
  }

  Future<bool> signInWithFacebook() async {
    final user = await _authService.signInWithFacebook();
    notifyListeners();
    return user != null;
  }

  Future<bool> signInWithPhone(String phone, String code) async {
    final user = await _authService.signInWithPhone(phone, code);
    notifyListeners();
    return user != null;
  }

  Future<bool> register(String email, String password, String username) async {
    final user = await _authService.register(email, password, username);
    notifyListeners();
    return user != null;
  }

  Future<void> logout() async {
    await _authService.logout();
    notifyListeners();
  }

  Future<void> refreshCurrentUser() async {
    if (currentUser != null) {
      final user = await _userService.getUserById(currentUser!.id);
      if (user != null) {
        await _authService.updateProfile(
          displayName: user.displayName,
          avatarUrl: user.avatarUrl,
          backgroundImageUrl: user.backgroundImageUrl,
          gender: user.gender,
          countryCode: user.countryCode,
          countryFlag: user.countryFlag,
          currentStatus: user.currentStatus,
        );
        notifyListeners();
      }
    }
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
    await _authService.updateProfile(
      displayName: displayName,
      avatarUrl: avatarUrl,
      backgroundImageUrl: backgroundImageUrl,
      gender: gender,
      countryCode: countryCode,
      countryFlag: countryFlag,
      currentStatus: currentStatus,
    );
    notifyListeners();
  }

  void notifyUpdate() {
    notifyListeners();
  }
}
