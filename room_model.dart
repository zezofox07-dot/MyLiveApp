class MicSeat {
  final int seatNumber;
  final String? userId;
  final bool isLocked;
  final bool isMuted;

  MicSeat({
    required this.seatNumber,
    this.userId,
    this.isLocked = false,
    this.isMuted = false,
  });

  Map<String, dynamic> toJson() => {
    'seatNumber': seatNumber,
    'userId': userId,
    'isLocked': isLocked,
    'isMuted': isMuted,
  };

  factory MicSeat.fromJson(Map<String, dynamic> json) => MicSeat(
    seatNumber: json['seatNumber'] ?? 0,
    userId: json['userId'],
    isLocked: json['isLocked'] ?? false,
    isMuted: json['isMuted'] ?? false,
  );

  MicSeat copyWith({
    int? seatNumber,
    String? userId,
    bool? isLocked,
    bool? isMuted,
  }) => MicSeat(
    seatNumber: seatNumber ?? this.seatNumber,
    userId: userId ?? this.userId,
    isLocked: isLocked ?? this.isLocked,
    isMuted: isMuted ?? this.isMuted,
  );
}

class RoomModel {
  final String id;
  final String title;
  final String coverImage;
  final String description;
  final String hostId;
  final List<String> coHosts;
  final List<String> admins;
  final String theme;
  final bool isPasswordProtected;
  final String? password;
  final List<String> participants;
  final int maxParticipants;
  final List<MicSeat> micSeats;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  RoomModel({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.description,
    required this.hostId,
    this.coHosts = const [],
    this.admins = const [],
    this.theme = 'galaxy',
    this.isPasswordProtected = false,
    this.password,
    this.participants = const [],
    this.maxParticipants = 10,
    required this.micSeats,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'coverImage': coverImage,
    'description': description,
    'hostId': hostId,
    'coHosts': coHosts,
    'admins': admins,
    'theme': theme,
    'isPasswordProtected': isPasswordProtected,
    'password': password,
    'participants': participants,
    'maxParticipants': maxParticipants,
    'micSeats': micSeats.map((s) => s.toJson()).toList(),
    'isActive': isActive,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
    id: json['id'] ?? '',
    title: json['title'] ?? '',
    coverImage: json['coverImage'] ?? '',
    description: json['description'] ?? '',
    hostId: json['hostId'] ?? '',
    coHosts: List<String>.from(json['coHosts'] ?? []),
    admins: List<String>.from(json['admins'] ?? []),
    theme: json['theme'] ?? 'galaxy',
    isPasswordProtected: json['isPasswordProtected'] ?? false,
    password: json['password'],
    participants: List<String>.from(json['participants'] ?? []),
    maxParticipants: json['maxParticipants'] ?? 10,
    micSeats: (json['micSeats'] as List?)?.map((s) => MicSeat.fromJson(s)).toList() ?? [],
    isActive: json['isActive'] ?? true,
    createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
  );

  RoomModel copyWith({
    String? id,
    String? title,
    String? coverImage,
    String? description,
    String? hostId,
    List<String>? coHosts,
    List<String>? admins,
    String? theme,
    bool? isPasswordProtected,
    String? password,
    List<String>? participants,
    int? maxParticipants,
    List<MicSeat>? micSeats,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RoomModel(
    id: id ?? this.id,
    title: title ?? this.title,
    coverImage: coverImage ?? this.coverImage,
    description: description ?? this.description,
    hostId: hostId ?? this.hostId,
    coHosts: coHosts ?? this.coHosts,
    admins: admins ?? this.admins,
    theme: theme ?? this.theme,
    isPasswordProtected: isPasswordProtected ?? this.isPasswordProtected,
    password: password ?? this.password,
    participants: participants ?? this.participants,
    maxParticipants: maxParticipants ?? this.maxParticipants,
    micSeats: micSeats ?? this.micSeats,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
