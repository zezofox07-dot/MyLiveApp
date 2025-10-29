import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample transactions for demo
    final transactions = _generateSampleTransactions();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل المعاملات'),
        backgroundColor: AppColors.darkSurface,
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: AppColors.textTertiary),
                  SizedBox(height: 16),
                  Text(
                    'لا توجد معاملات بعد',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 18),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return _buildTransactionCard(transaction);
              },
            ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final type = transaction['type'] as String;
    final isIncome = type == 'received' || type == 'recharge';
    
    IconData icon;
    Color color;
    String typeText;
    
    switch (type) {
      case 'sent':
        icon = Icons.arrow_upward;
        color = AppColors.error;
        typeText = 'إرسال';
        break;
      case 'received':
        icon = Icons.arrow_downward;
        color = AppColors.success;
        typeText = 'استلام';
        break;
      case 'giftSent':
        icon = Icons.card_giftcard;
        color = AppColors.pink;
        typeText = 'إرسال هدية';
        break;
      case 'giftReceived':
        icon = Icons.card_giftcard;
        color = AppColors.purple;
        typeText = 'استلام هدية';
        break;
      case 'purchase':
        icon = Icons.shopping_bag;
        color = AppColors.neonBlue;
        typeText = 'شراء';
        break;
      case 'recharge':
      default:
        icon = Icons.account_balance_wallet;
        color = AppColors.gold;
        typeText = 'إعادة شحن';
        break;
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  typeText,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction['description'] as String,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(transaction['timestamp'] as DateTime),
                  style: const TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isIncome ? '+' : '-'}${transaction['amount']}',
                style: TextStyle(
                  color: isIncome ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction['currency'] == 'gold' ? '🪙 عملة' : '💎 ماس',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return 'منذ ${difference.inMinutes} دقيقة';
      }
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  List<Map<String, dynamic>> _generateSampleTransactions() {
    return [
      {
        'type': 'recharge',
        'description': 'شراء 500 ماسة',
        'amount': 500,
        'currency': 'diamonds',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'type': 'giftSent',
        'description': 'إرسال هدية وردة إلى أحمد',
        'amount': 100,
        'currency': 'gold',
        'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
      },
      {
        'type': 'giftReceived',
        'description': 'استلام هدية من سارة',
        'amount': 50,
        'currency': 'diamonds',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        'type': 'purchase',
        'description': 'شراء إطار VIP',
        'amount': 200,
        'currency': 'diamonds',
        'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      },
      {
        'type': 'received',
        'description': 'مكافأة تسجيل دخول يومي',
        'amount': 100,
        'currency': 'gold',
        'timestamp': DateTime.now().subtract(const Duration(days: 3)),
      },
      {
        'type': 'sent',
        'description': 'تحويل عملات إلى محمد',
        'amount': 500,
        'currency': 'gold',
        'timestamp': DateTime.now().subtract(const Duration(days: 5)),
      },
    ];
  }
}
