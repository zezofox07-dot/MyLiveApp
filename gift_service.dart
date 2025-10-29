import 'package:sawa_chat/models/gift_model.dart';
import 'package:sawa_chat/services/storage_service.dart';

class GiftService {
  static final GiftService _instance = GiftService._internal();
  factory GiftService() => _instance;
  GiftService._internal();

  final _storage = StorageService();
  static const String _giftsKey = 'gifts';

  Future<void> init() async {
    await _storage.init();
    await _initializeSampleData();
  }

  Future<void> _initializeSampleData() async {
    final gifts = await getAllGifts();
    if (gifts.isEmpty) {
      final sampleGifts = _createSampleGifts();
      await _storage.saveJsonList(_giftsKey, sampleGifts.map((g) => g.toJson()).toList());
    }
  }

  List<GiftModel> _createSampleGifts() {
    final now = DateTime.now();
    return [
      GiftModel(
        id: '1',
        name: 'Rose',
        nameAr: 'وردة 🌹',
        price: 10,
        currency: 'gold',
        imageUrl: '🌹',
        category: 'romantic',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '2',
        name: 'Heart',
        nameAr: 'قلب 💖',
        price: 50,
        currency: 'gold',
        imageUrl: '💖',
        category: 'romantic',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '3',
        name: 'Crown',
        nameAr: 'تاج 👑',
        price: 200,
        currency: 'gold',
        imageUrl: '👑',
        category: 'luxury',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '4',
        name: 'Diamond',
        nameAr: 'ماسة 💎',
        price: 100,
        currency: 'diamond',
        imageUrl: '💎',
        category: 'luxury',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '5',
        name: 'Star',
        nameAr: 'نجمة ⭐',
        price: 30,
        currency: 'gold',
        imageUrl: '⭐',
        category: 'general',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '6',
        name: 'Gift Box',
        nameAr: 'صندوق هدية 🎁',
        price: 150,
        currency: 'gold',
        imageUrl: '🎁',
        category: 'general',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '7',
        name: 'Trophy',
        nameAr: 'كأس 🏆',
        price: 300,
        currency: 'gold',
        imageUrl: '🏆',
        category: 'achievement',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '8',
        name: 'Fire',
        nameAr: 'نار 🔥',
        price: 80,
        currency: 'gold',
        imageUrl: '🔥',
        category: 'general',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '9',
        name: 'Rocket',
        nameAr: 'صاروخ 🚀',
        price: 500,
        currency: 'gold',
        imageUrl: '🚀',
        category: 'luxury',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '10',
        name: 'Castle',
        nameAr: 'قصر 🏰',
        price: 200,
        currency: 'diamond',
        imageUrl: '🏰',
        category: 'luxury',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '11',
        name: 'Ring',
        nameAr: 'خاتم 💍',
        price: 250,
        currency: 'diamond',
        imageUrl: '💍',
        category: 'romantic',
        createdAt: now,
        updatedAt: now,
      ),
      GiftModel(
        id: '12',
        name: 'Fireworks',
        nameAr: 'ألعاب نارية 🎆',
        price: 400,
        currency: 'gold',
        imageUrl: '🎆',
        category: 'celebration',
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  Future<List<GiftModel>> getAllGifts() async {
    final jsonList = _storage.getJsonList(_giftsKey);
    return jsonList.map((json) => GiftModel.fromJson(json)).toList();
  }

  Future<List<GiftModel>> getGiftsByCategory(String category) async {
    final gifts = await getAllGifts();
    return gifts.where((g) => g.category == category).toList();
  }

  Future<List<GiftModel>> getGiftsByCurrency(String currency) async {
    final gifts = await getAllGifts();
    return gifts.where((g) => g.currency == currency).toList();
  }

  Future<GiftModel?> getGiftById(String id) async {
    final gifts = await getAllGifts();
    try {
      return gifts.firstWhere((g) => g.id == id);
    } catch (e) {
      return null;
    }
  }
}
