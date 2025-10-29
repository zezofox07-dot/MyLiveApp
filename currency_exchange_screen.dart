import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/widgets/gradient_button.dart';

class CurrencyExchangeScreen extends StatefulWidget {
  const CurrencyExchangeScreen({super.key});

  @override
  State<CurrencyExchangeScreen> createState() => _CurrencyExchangeScreenState();
}

class _CurrencyExchangeScreenState extends State<CurrencyExchangeScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _exchangeType = 'diamonds_to_gold'; // diamonds_to_gold or gold_to_diamonds
  
  // Exchange rates
  final int _diamondsToGoldRate = 100; // 1 diamond = 100 gold
  final int _goldToDiamondsRate = 100; // 100 gold = 1 diamond

  int _currentDiamonds = 5000;
  int _currentGold = 50000;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تبديل العملات'),
        backgroundColor: AppColors.darkSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 24),
            _buildExchangeTypeSelector(),
            const SizedBox(height: 24),
            _buildExchangeCard(),
            const SizedBox(height: 24),
            _buildQuickAmounts(),
            const SizedBox(height: 24),
            _buildExchangeRateInfo(),
            const SizedBox(height: 24),
            GradientButton(
              text: 'تبديل الآن',
              onPressed: _processExchange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.purple, AppColors.neonBlue],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'رصيدك الحالي',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildBalanceItem('💎', '$_currentDiamonds', 'ماسة'),
              ),
              Container(width: 1, height: 40, color: Colors.white30),
              Expanded(
                child: _buildBalanceItem('🪙', '$_currentGold', 'عملة ذهبية'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String emoji, String amount, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 8),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildExchangeTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() {
                _exchangeType = 'diamonds_to_gold';
                _amountController.clear();
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: _exchangeType == 'diamonds_to_gold'
                      ? const LinearGradient(colors: [AppColors.neonBlue, AppColors.purple])
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('💎', style: TextStyle(fontSize: 24)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                        SizedBox(width: 8),
                        Text('🪙', style: TextStyle(fontSize: 24)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ماس ← ذهب',
                      style: TextStyle(
                        color: _exchangeType == 'diamonds_to_gold' ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() {
                _exchangeType = 'gold_to_diamonds';
                _amountController.clear();
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: _exchangeType == 'gold_to_diamonds'
                      ? const LinearGradient(colors: [AppColors.gold, Colors.orange])
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🪙', style: TextStyle(fontSize: 24)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                        SizedBox(width: 8),
                        Text('💎', style: TextStyle(fontSize: 24)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ذهب ← ماس',
                      style: TextStyle(
                        color: _exchangeType == 'gold_to_diamonds' ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeCard() {
    final isDiamondsToGold = _exchangeType == 'diamonds_to_gold';
    final fromEmoji = isDiamondsToGold ? '💎' : '🪙';
    final toEmoji = isDiamondsToGold ? '🪙' : '💎';
    final fromLabel = isDiamondsToGold ? 'ماسة' : 'عملة ذهبية';
    final toLabel = isDiamondsToGold ? 'عملة ذهبية' : 'ماسة';
    
    int convertedAmount = 0;
    if (_amountController.text.isNotEmpty) {
      final amount = int.tryParse(_amountController.text) ?? 0;
      if (isDiamondsToGold) {
        convertedAmount = amount * _diamondsToGoldRate;
      } else {
        convertedAmount = amount ~/ _goldToDiamondsRate;
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'المبلغ للتبديل',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(fromEmoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(color: AppColors.textTertiary),
                      border: InputBorder.none,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                Text(
                  fromLabel,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Icon(Icons.arrow_downward, color: AppColors.gold, size: 32),
          ),
          const SizedBox(height: 16),
          const Text(
            'ستحصل على',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(toEmoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '$convertedAmount',
                    style: const TextStyle(
                      color: AppColors.gold,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  toLabel,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmounts() {
    final isDiamondsToGold = _exchangeType == 'diamonds_to_gold';
    final amounts = isDiamondsToGold ? [10, 50, 100, 500] : [1000, 5000, 10000, 50000];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'مبالغ سريعة',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: amounts.map((amount) {
            return GestureDetector(
              onTap: () => setState(() => _amountController.text = '$amount'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
                ),
                child: Text(
                  '$amount',
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildExchangeRateInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neonBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppColors.neonBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'سعر الصرف',
                  style: TextStyle(
                    color: AppColors.neonBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '1 💎 = $_diamondsToGoldRate 🪙',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _processExchange() {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إدخال المبلغ المراد تبديله'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final amount = int.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إدخال مبلغ صحيح'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final isDiamondsToGold = _exchangeType == 'diamonds_to_gold';
    
    // Check if user has enough balance
    if (isDiamondsToGold && amount > _currentDiamonds) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('رصيد الماس غير كافٍ'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    } else if (!isDiamondsToGold && amount > _currentGold) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('رصيد العملات الذهبية غير كافٍ'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkCard,
        title: const Text('تأكيد التبديل', style: TextStyle(color: AppColors.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isDiamondsToGold
                  ? 'تبديل $amount 💎 إلى ${amount * _diamondsToGoldRate} 🪙'
                  : 'تبديل $amount 🪙 إلى ${amount ~/ _goldToDiamondsRate} 💎',
              style: const TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                if (isDiamondsToGold) {
                  _currentDiamonds -= amount;
                  _currentGold += amount * _diamondsToGoldRate;
                } else {
                  _currentGold -= amount;
                  _currentDiamonds += amount ~/ _goldToDiamondsRate;
                }
                _amountController.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم التبديل بنجاح! ✅'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold),
            child: const Text('تأكيد', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
