import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/models/room_model.dart';
import 'package:sawa_chat/models/user_model.dart';
import 'package:sawa_chat/services/room_service.dart';
import 'package:sawa_chat/services/user_service.dart';
import 'package:sawa_chat/providers/app_state.dart';
import 'package:sawa_chat/widgets/user_avatar.dart';

class RoomDetailScreen extends StatefulWidget {
  final String roomId;

  const RoomDetailScreen({super.key, required this.roomId});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  final _roomService = RoomService();
  final _userService = UserService();
  RoomModel? _room;
  Map<String, UserModel> _users = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRoom();
  }

  Future<void> _loadRoom() async {
    final room = await _roomService.getRoomById(widget.roomId);
    if (room != null) {
      final users = <String, UserModel>{};
      for (final seat in room.micSeats) {
        if (seat.userId != null) {
          final user = await _userService.getUserById(seat.userId!);
          if (user != null) {
            users[seat.userId!] = user;
          }
        }
      }
      setState(() {
        _room = room;
        _users = users;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _room == null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.darkBackground, AppColors.darkSurface],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.gold),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(_room!.coverImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildMicSeats(),
                      const SizedBox(height: 24),
                      _buildChatSection(),
                    ],
                  ),
                ),
              ),
              _buildBottomControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0.8),
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _room!.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'ID: ${_room!.id}  •  ${_room!.participants.length} مستخدم',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.gold),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.gold),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMicSeats() {
    final currentUser = context.read<AppState>().currentUser;
    final isHost = currentUser?.id == _room!.hostId;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.gold.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mic, color: AppColors.gold, size: 20),
              const SizedBox(width: 8),
              Text(
                'مقاعد الميكروفون',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              final seat = _room!.micSeats[index];
              return _buildSeat(seat, index, isHost);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSeat(MicSeat seat, int index, bool isHost) {
    final user = seat.userId != null ? _users[seat.userId] : null;
    final currentUser = context.read<AppState>().currentUser;
    final isCurrentUser = seat.userId == currentUser?.id;

    return GestureDetector(
      onTap: () async {
        if (seat.userId == null && !seat.isLocked) {
          await _roomService.takeSeat(_room!.id, currentUser!.id, index);
          await _loadRoom();
        } else if (isCurrentUser || isHost) {
          _showSeatOptions(seat, index, isHost);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              if (user != null)
                UserAvatar(
                  avatarUrl: user.avatarUrl,
                  size: 50,
                  vipLevel: user.vipLevel,
                  svipLevel: user.svipLevel,
                )
              else
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: seat.isLocked
                        ? AppColors.darkSurface
                        : AppColors.darkCard,
                    border: Border.all(
                      color: seat.isLocked
                          ? AppColors.textTertiary
                          : AppColors.neonBlue.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    seat.isLocked ? Icons.lock : Icons.add,
                    color: seat.isLocked
                        ? AppColors.textTertiary
                        : AppColors.neonBlue,
                    size: 24,
                  ),
                ),
              if (user != null && seat.isMuted)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mic_off,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              if (index == 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: AppColors.gold,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            user?.displayName ?? '${index + 1}',
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showSeatOptions(MicSeat seat, int index, bool isHost) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isHost) ...[
              ListTile(
                leading: Icon(
                  seat.isLocked ? Icons.lock_open : Icons.lock,
                  color: AppColors.gold,
                ),
                title: Text(seat.isLocked ? 'فتح المقعد' : 'قفل المقعد'),
                onTap: () async {
                  await _roomService.lockSeat(_room!.id, index, !seat.isLocked);
                  await _loadRoom();
                  if (mounted) Navigator.pop(context);
                },
              ),
              if (seat.userId != null)
                ListTile(
                  leading: const Icon(Icons.person_remove, color: AppColors.error),
                  title: const Text('إزالة من المقعد'),
                  onTap: () async {
                    await _roomService.leaveSeat(_room!.id, index);
                    await _loadRoom();
                    if (mounted) Navigator.pop(context);
                  },
                ),
            ],
            if (seat.userId == context.read<AppState>().currentUser?.id)
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: AppColors.neonBlue),
                title: const Text('مغادرة المقعد'),
                onTap: () async {
                  await _roomService.leaveSeat(_room!.id, index);
                  await _loadRoom();
                  if (mounted) Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatSection() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المحادثة',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                _buildChatMessage('أحمد', 'مرحباً بالجميع! 👋'),
                _buildChatMessage('فاطمة', 'أهلاً وسهلاً'),
                _buildChatMessage('محمد', 'كيف الحال؟'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessage(String username, String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$username: ',
              style: const TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            TextSpan(
              text: message,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildControlButton(Icons.card_giftcard, AppColors.pink, () {}),
          const SizedBox(width: 12),
          _buildControlButton(Icons.emoji_emotions, AppColors.gold, () {}),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'اكتب رسالة...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.gold, AppColors.neonBlue],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.darkCard,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }
}
