import 'package:sawa_chat/models/room_model.dart';
import 'package:sawa_chat/services/storage_service.dart';

class RoomService {
  static final RoomService _instance = RoomService._internal();
  factory RoomService() => _instance;
  RoomService._internal();

  final _storage = StorageService();
  static const String _roomsKey = 'rooms';

  Future<void> init() async {
    await _storage.init();
    await _initializeSampleData();
  }

  Future<void> _initializeSampleData() async {
    final rooms = await getAllRooms();
    if (rooms.isEmpty) {
      final sampleRooms = _createSampleRooms();
      await _storage.saveJsonList(_roomsKey, sampleRooms.map((r) => r.toJson()).toList());
    }
  }

  List<RoomModel> _createSampleRooms() {
    final now = DateTime.now();
    return [
      RoomModel(
        id: '1',
        title: 'غرفة النجوم ⭐',
        coverImage: 'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=400',
        description: 'أهلاً بكم في غرفة النجوم',
        hostId: '1',
        coHosts: ['2'],
        admins: ['3'],
        theme: 'galaxy',
        participants: ['1', '2', '3', '4', '5'],
        micSeats: [
          MicSeat(seatNumber: 0, userId: '1'),
          MicSeat(seatNumber: 1, userId: '2'),
          MicSeat(seatNumber: 2, userId: '3'),
          MicSeat(seatNumber: 3, userId: null, isLocked: false),
          MicSeat(seatNumber: 4, userId: '4'),
          MicSeat(seatNumber: 5, userId: null, isLocked: true),
          MicSeat(seatNumber: 6, userId: null, isLocked: false),
          MicSeat(seatNumber: 7, userId: '5'),
          MicSeat(seatNumber: 8, userId: null, isLocked: false),
          MicSeat(seatNumber: 9, userId: null, isLocked: false),
        ],
        isActive: true,
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now,
      ),
      RoomModel(
        id: '2',
        title: 'صالون الليل 🌙',
        coverImage: 'https://images.unsplash.com/photo-1464802686167-b939a6910659?w=400',
        description: 'للأحاديث المسائية',
        hostId: '3',
        coHosts: ['5'],
        admins: [],
        theme: 'nightSky',
        participants: ['3', '5', '2'],
        micSeats: [
          MicSeat(seatNumber: 0, userId: '3'),
          MicSeat(seatNumber: 1, userId: '5'),
          MicSeat(seatNumber: 2, userId: null, isLocked: false),
          MicSeat(seatNumber: 3, userId: '2'),
          MicSeat(seatNumber: 4, userId: null, isLocked: false),
          MicSeat(seatNumber: 5, userId: null, isLocked: false),
          MicSeat(seatNumber: 6, userId: null, isLocked: true),
          MicSeat(seatNumber: 7, userId: null, isLocked: true),
          MicSeat(seatNumber: 8, userId: null, isLocked: false),
          MicSeat(seatNumber: 9, userId: null, isLocked: false),
        ],
        isActive: true,
        createdAt: now.subtract(const Duration(hours: 1)),
        updatedAt: now,
      ),
      RoomModel(
        id: '3',
        title: 'النيون الملكي 👑',
        coverImage: 'https://images.unsplash.com/photo-1528605248644-14dd04022da1?w=400',
        description: 'غرفة VIP فقط',
        hostId: '3',
        coHosts: [],
        admins: ['1'],
        theme: 'darkNeon',
        isPasswordProtected: true,
        password: '1234',
        participants: ['3', '1', '4'],
        micSeats: [
          MicSeat(seatNumber: 0, userId: '3'),
          MicSeat(seatNumber: 1, userId: '1'),
          MicSeat(seatNumber: 2, userId: null, isLocked: false),
          MicSeat(seatNumber: 3, userId: '4'),
          MicSeat(seatNumber: 4, userId: null, isLocked: false),
          MicSeat(seatNumber: 5, userId: null, isLocked: true),
          MicSeat(seatNumber: 6, userId: null, isLocked: true),
          MicSeat(seatNumber: 7, userId: null, isLocked: true),
          MicSeat(seatNumber: 8, userId: null, isLocked: true),
          MicSeat(seatNumber: 9, userId: null, isLocked: true),
        ],
        isActive: true,
        createdAt: now.subtract(const Duration(minutes: 45)),
        updatedAt: now,
      ),
      RoomModel(
        id: '4',
        title: 'صالة العرب 🎤',
        coverImage: 'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=400',
        description: 'للموسيقى والغناء',
        hostId: '2',
        coHosts: ['4'],
        admins: [],
        theme: 'arabicLounge',
        participants: ['2', '4', '5'],
        micSeats: [
          MicSeat(seatNumber: 0, userId: '2'),
          MicSeat(seatNumber: 1, userId: '4'),
          MicSeat(seatNumber: 2, userId: '5'),
          MicSeat(seatNumber: 3, userId: null, isLocked: false),
          MicSeat(seatNumber: 4, userId: null, isLocked: false),
          MicSeat(seatNumber: 5, userId: null, isLocked: false),
          MicSeat(seatNumber: 6, userId: null, isLocked: false),
          MicSeat(seatNumber: 7, userId: null, isLocked: false),
          MicSeat(seatNumber: 8, userId: null, isLocked: false),
          MicSeat(seatNumber: 9, userId: null, isLocked: false),
        ],
        isActive: true,
        createdAt: now.subtract(const Duration(hours: 3)),
        updatedAt: now,
      ),
      RoomModel(
        id: '5',
        title: 'ليالي الجمعة 🌟',
        coverImage: 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=400',
        description: 'لقاءات نهاية الأسبوع',
        hostId: '5',
        coHosts: [],
        admins: ['1', '2'],
        theme: 'galaxy',
        participants: ['5', '1', '2', '3', '4'],
        micSeats: [
          MicSeat(seatNumber: 0, userId: '5'),
          MicSeat(seatNumber: 1, userId: '1'),
          MicSeat(seatNumber: 2, userId: '2'),
          MicSeat(seatNumber: 3, userId: '3'),
          MicSeat(seatNumber: 4, userId: '4'),
          MicSeat(seatNumber: 5, userId: null, isLocked: false),
          MicSeat(seatNumber: 6, userId: null, isLocked: false),
          MicSeat(seatNumber: 7, userId: null, isLocked: false),
          MicSeat(seatNumber: 8, userId: null, isLocked: false),
          MicSeat(seatNumber: 9, userId: null, isLocked: false),
        ],
        isActive: true,
        createdAt: now.subtract(const Duration(minutes: 30)),
        updatedAt: now,
      ),
    ];
  }

  Future<List<RoomModel>> getAllRooms() async {
    final jsonList = _storage.getJsonList(_roomsKey);
    return jsonList.map((json) => RoomModel.fromJson(json)).toList();
  }

  Future<List<RoomModel>> getActiveRooms() async {
    final rooms = await getAllRooms();
    return rooms.where((r) => r.isActive).toList();
  }

  Future<RoomModel?> getRoomById(String id) async {
    final rooms = await getAllRooms();
    try {
      return rooms.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> createRoom(RoomModel room) async {
    final rooms = await getAllRooms();
    rooms.add(room);
    await _storage.saveJsonList(_roomsKey, rooms.map((r) => r.toJson()).toList());
  }

  Future<void> updateRoom(RoomModel room) async {
    final rooms = await getAllRooms();
    final index = rooms.indexWhere((r) => r.id == room.id);
    if (index != -1) {
      rooms[index] = room;
      await _storage.saveJsonList(_roomsKey, rooms.map((r) => r.toJson()).toList());
    }
  }

  Future<void> deleteRoom(String id) async {
    final rooms = await getAllRooms();
    rooms.removeWhere((r) => r.id == id);
    await _storage.saveJsonList(_roomsKey, rooms.map((r) => r.toJson()).toList());
  }

  Future<void> joinRoom(String roomId, String userId) async {
    final room = await getRoomById(roomId);
    if (room != null) {
      final participants = List<String>.from(room.participants);
      if (!participants.contains(userId)) {
        participants.add(userId);
        final updatedRoom = room.copyWith(
          participants: participants,
          updatedAt: DateTime.now(),
        );
        await updateRoom(updatedRoom);
      }
    }
  }

  Future<void> leaveRoom(String roomId, String userId) async {
    final room = await getRoomById(roomId);
    if (room != null) {
      final participants = List<String>.from(room.participants);
      participants.remove(userId);
      
      final seats = List<MicSeat>.from(room.micSeats);
      final seatIndex = seats.indexWhere((s) => s.userId == userId);
      if (seatIndex != -1) {
        seats[seatIndex] = seats[seatIndex].copyWith(userId: null);
      }

      final updatedRoom = room.copyWith(
        participants: participants,
        micSeats: seats,
        updatedAt: DateTime.now(),
      );
      await updateRoom(updatedRoom);
    }
  }

  Future<void> takeSeat(String roomId, String userId, int seatNumber) async {
    final room = await getRoomById(roomId);
    if (room != null) {
      final seats = List<MicSeat>.from(room.micSeats);
      if (seatNumber >= 0 && seatNumber < seats.length) {
        final seat = seats[seatNumber];
        if (seat.userId == null && !seat.isLocked) {
          seats[seatNumber] = seat.copyWith(userId: userId);
          final updatedRoom = room.copyWith(
            micSeats: seats,
            updatedAt: DateTime.now(),
          );
          await updateRoom(updatedRoom);
        }
      }
    }
  }

  Future<void> leaveSeat(String roomId, int seatNumber) async {
    final room = await getRoomById(roomId);
    if (room != null) {
      final seats = List<MicSeat>.from(room.micSeats);
      if (seatNumber >= 0 && seatNumber < seats.length) {
        seats[seatNumber] = seats[seatNumber].copyWith(userId: null);
        final updatedRoom = room.copyWith(
          micSeats: seats,
          updatedAt: DateTime.now(),
        );
        await updateRoom(updatedRoom);
      }
    }
  }

  Future<void> lockSeat(String roomId, int seatNumber, bool locked) async {
    final room = await getRoomById(roomId);
    if (room != null) {
      final seats = List<MicSeat>.from(room.micSeats);
      if (seatNumber >= 0 && seatNumber < seats.length) {
        seats[seatNumber] = seats[seatNumber].copyWith(isLocked: locked, userId: null);
        final updatedRoom = room.copyWith(
          micSeats: seats,
          updatedAt: DateTime.now(),
        );
        await updateRoom(updatedRoom);
      }
    }
  }
}
