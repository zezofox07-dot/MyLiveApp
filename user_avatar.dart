import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sawa_chat/theme.dart';

class UserAvatar extends StatelessWidget {
  final String avatarUrl;
  final double size;
  final int vipLevel;
  final int svipLevel;
  final bool showOnlineStatus;
  final bool isOnline;

  const UserAvatar({
    super.key,
    required this.avatarUrl,
    this.size = 50,
    this.vipLevel = 0,
    this.svipLevel = 0,
    this.showOnlineStatus = false,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: _getFrameGradient(),
            boxShadow: [
              if (vipLevel > 0 || svipLevel > 0)
                BoxShadow(
                  color: _getFrameColor().withValues(alpha: 0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
            ],
          ),
          padding: const EdgeInsets.all(3),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: avatarUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                color: AppColors.darkCard,
                child: const Icon(Icons.person, color: AppColors.textTertiary),
              ),
              errorWidget: (_, __, ___) => Container(
                color: AppColors.darkCard,
                child: const Icon(Icons.person, color: AppColors.textTertiary),
              ),
            ),
          ),
        ),
        if (showOnlineStatus)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: size * 0.25,
              height: size * 0.25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOnline ? AppColors.online : AppColors.offline,
                border: Border.all(
                  color: AppColors.darkBackground,
                  width: 2,
                ),
              ),
            ),
          ),
        if (vipLevel > 0 || svipLevel > 0)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: _getFrameColor(),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.darkBackground, width: 1),
              ),
              child: Text(
                svipLevel > 0 ? 'S$svipLevel' : 'V$vipLevel',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  LinearGradient _getFrameGradient() {
    if (svipLevel > 0) {
      return const LinearGradient(
        colors: [AppColors.gold, AppColors.purple, AppColors.gold],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (vipLevel > 0) {
      return const LinearGradient(
        colors: [AppColors.gold, AppColors.neonBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return const LinearGradient(
      colors: [AppColors.darkCard, AppColors.darkCard],
    );
  }

  Color _getFrameColor() {
    if (svipLevel > 0) return AppColors.purple;
    if (vipLevel > 0) return AppColors.gold;
    return AppColors.darkCard;
  }
}
