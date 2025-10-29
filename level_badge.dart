import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';

class LevelBadge extends StatelessWidget {
  final int level;
  final double size;

  const LevelBadge({
    super.key,
    required this.level,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.4,
        vertical: size * 0.2,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.neonBlue, AppColors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.4),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonBlue.withValues(alpha: 0.3),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: size * 0.8,
            color: Colors.white,
          ),
          SizedBox(width: size * 0.2),
          Text(
            'Lv.$level',
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.6,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
