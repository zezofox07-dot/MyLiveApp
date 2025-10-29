import 'package:sawa_chat/models/transaction_model.dart';
import 'package:sawa_chat/services/storage_service.dart';
import 'package:sawa_chat/services/user_service.dart';

class TransactionService {
  static final TransactionService _instance = TransactionService._internal();
  factory TransactionService() => _instance;
  TransactionService._internal();

  final _storage = StorageService();
  final _userService = UserService();
  static const String _transactionsKey = 'transactions';

  Future<void> init() async {
    await _storage.init();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final jsonList = _storage.getJsonList(_transactionsKey);
    return jsonList.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<List<TransactionModel>> getUserTransactions(String userId) async {
    final transactions = await getAllTransactions();
    return transactions.where((t) => t.userId == userId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    final transactions = await getAllTransactions();
    transactions.add(transaction);
    await _storage.saveJsonList(_transactionsKey, transactions.map((t) => t.toJson()).toList());
  }

  Future<bool> rechargeCoins(String userId, int amount, String currency) async {
    final user = await _userService.getUserById(userId);
    if (user == null) return false;

    final newGold = currency == 'gold' ? user.goldCoins + amount : user.goldCoins;
    final newDiamonds = currency == 'diamond' ? user.diamonds + amount : user.diamonds;

    await _userService.updateCoins(userId, newGold, newDiamonds);

    final transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      type: 'recharge',
      amount: amount,
      currency: currency,
      description: 'شحن ${currency == 'gold' ? 'ذهب' : 'ماس'}',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await addTransaction(transaction);
    return true;
  }

  Future<bool> exchangeCurrency(String userId, int amount, String fromCurrency) async {
    final user = await _userService.getUserById(userId);
    if (user == null) return false;

    final toCurrency = fromCurrency == 'gold' ? 'diamond' : 'gold';
    final exchangeRate = fromCurrency == 'gold' ? 10 : 10;
    final convertedAmount = amount ~/ exchangeRate;

    if (fromCurrency == 'gold') {
      if (user.goldCoins < amount) return false;
      await _userService.updateCoins(userId, user.goldCoins - amount, user.diamonds + convertedAmount);
    } else {
      if (user.diamonds < amount) return false;
      await _userService.updateCoins(userId, user.goldCoins + convertedAmount, user.diamonds - amount);
    }

    final transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      type: 'exchange',
      amount: amount,
      currency: fromCurrency,
      description: 'تبديل $amount ${fromCurrency == 'gold' ? 'ذهب' : 'ماس'} إلى $convertedAmount ${toCurrency == 'gold' ? 'ذهب' : 'ماس'}',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await addTransaction(transaction);
    return true;
  }

  Future<bool> sendGift(String senderId, String receiverId, String giftId, int price, String currency) async {
    final sender = await _userService.getUserById(senderId);
    if (sender == null) return false;

    if (currency == 'gold' && sender.goldCoins < price) return false;
    if (currency == 'diamond' && sender.diamonds < price) return false;

    final newGold = currency == 'gold' ? sender.goldCoins - price : sender.goldCoins;
    final newDiamonds = currency == 'diamond' ? sender.diamonds - price : sender.diamonds;

    await _userService.updateCoins(senderId, newGold, newDiamonds);

    final transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: senderId,
      type: 'gift',
      amount: -price,
      currency: currency,
      description: 'إرسال هدية',
      relatedUserId: receiverId,
      relatedItemId: giftId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await addTransaction(transaction);
    await _userService.addExperience(senderId, price ~/ 10);
    return true;
  }

  Future<void> giveDailyReward(String userId, int goldAmount, int diamondAmount) async {
    final user = await _userService.getUserById(userId);
    if (user == null) return;

    await _userService.updateCoins(userId, user.goldCoins + goldAmount, user.diamonds + diamondAmount);

    final transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      type: 'reward',
      amount: goldAmount,
      currency: 'gold',
      description: 'مكافأة يومية',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await addTransaction(transaction);
  }
}
