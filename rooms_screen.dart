import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/models/room_model.dart';
import 'package:sawa_chat/services/room_service.dart';
import 'package:sawa_chat/screens/room_detail_screen.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  final _roomService = RoomService();
  List<RoomModel> _rooms = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    setState(() => _isLoading = true);
    final rooms = await _roomService.getActiveRooms();
    setState(() {
      _rooms = rooms;
      _isLoading = false;
    });
  }

  List<RoomModel> get _filteredRooms {
    if (_selectedFilter == 'all') return _rooms;
    return _rooms.where((r) => r.theme == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الغرف'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: AppColors.gold),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
                : _filteredRooms.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.group_off, size: 64, color: AppColors.textTertiary),
                            const SizedBox(height: 16),
                            Text(
                              'لا توجد غرف متاحة',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadRooms,
                        color: AppColors.gold,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredRooms.length,
                          itemBuilder: (context, index) => _buildRoomCard(_filteredRooms[index]),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      {'id': 'all', 'label': 'الكل', 'icon': Icons.all_inclusive},
      {'id': 'galaxy', 'label': 'مجرة', 'icon': Icons.stars},
      {'id': 'nightSky', 'label': 'ليل', 'icon': Icons.nightlight},
      {'id': 'darkNeon', 'label': 'نيون', 'icon': Icons.flash_on},
      {'id': 'arabicLounge', 'label': 'عربي', 'icon': Icons.music_note},
    ];

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter['id'];
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    filter['icon'] as IconData,
                    size: 16,
                    color: isSelected ? Colors.black : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(filter['label'] as String),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedFilter = filter['id'] as String);
              },
              backgroundColor: AppColors.darkCard,
              selectedColor: AppColors.gold,
              labelStyle: TextStyle(
                color: isSelected ? Colors.black : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? AppColors.gold : AppColors.darkCard,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRoomCard(RoomModel room) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RoomDetailScreen(roomId: room.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: room.coverImage,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.darkSurface),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.darkSurface,
                  child: const Icon(Icons.image, color: AppColors.textTertiary),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            room.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (room.isPasswordProtected)
                          const Icon(Icons.lock, color: AppColors.gold, size: 18),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      room.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.darkSurface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.person, color: AppColors.gold, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                '${room.participants.length}/${room.maxParticipants}',
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.neonBlue.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getThemeLabel(room.theme),
                            style: const TextStyle(
                              color: AppColors.neonBlue,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeLabel(String theme) {
    switch (theme) {
      case 'galaxy':
        return 'مجرة';
      case 'nightSky':
        return 'ليل';
      case 'darkNeon':
        return 'نيون';
      case 'arabicLounge':
        return 'عربي';
      default:
        return theme;
    }
  }
}
