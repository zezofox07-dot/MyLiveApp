import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';
import 'package:intl/intl.dart';

class CurrencyDisplay extends StatelessWidget {
  final int goldCoins;
  final int diamonds;
  final bool showLabels;
  final bool vertical;

  const CurrencyDisplay({
    super.key,
    required this.goldCoins,
    required this.diamonds,
    this.showLabels = true,
    this.vertical = false,
  });

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return NumberFormat('#,###').format(number);
  }

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCoinItem('🪙', goldCoins, AppColors.gold, 'ذهب'),
          const SizedBox(height: 8),
          _buildCoinItem('💎', diamonds, AppColors.neonBlue, 'ماس'),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCoinItem('🪙', goldCoins, AppColors.gold, 'ذهب'),
        const SizedBox(width: 16),
        _buildCoinItem('💎', diamonds, AppColors.neonBlue, 'ماس'),
      ],
    );
  }

  Widget _buildCoinItem(String emoji, int amount, Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(
            _formatNumber(amount),
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (showLabels) ...[
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textTertiary,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
