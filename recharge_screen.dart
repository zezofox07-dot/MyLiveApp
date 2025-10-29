import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/widgets/gradient_button.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  String _selectedCurrency = 'diamonds';
  int? _selectedPackage;
  String _selectedPayment = 'card';

  final _diamondPackages = [
    {'amount': 100, 'price': 4.99, 'bonus': 0},
    {'amount': 500, 'price': 19.99, 'bonus': 50},
    {'amount': 1200, 'price': 49.99, 'bonus': 200, 'popular': true},
    {'amount': 2500, 'price': 99.99, 'bonus': 500},
    {'amount': 6500, 'price': 249.99, 'bonus': 1500, 'best': true},
    {'amount': 13000, 'price': 499.99, 'bonus': 3500},
  ];

  final _goldPackages = [
    {'amount': 1000, 'price': 0.99, 'bonus': 0},
    {'amount': 5000, 'price': 3.99, 'bonus': 500},
    {'amount': 12000, 'price': 9.99, 'bonus': 2000, 'popular': true},
    {'amount': 25000, 'price': 19.99, 'bonus': 5000},
    {'amount': 65000, 'price': 49.99, 'bonus': 15000, 'best': true},
    {'amount': 130000, 'price': 99.99, 'bonus': 35000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعادة الشحن'),
        backgroundColor: AppColors.darkSurface,
      ),
      body: Column(
        children: [
          _buildCurrencySelector(),
          Expanded(
            child: _buildPackagesList(),
          ),
          _buildPaymentSection(),
        ],
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedCurrency = 'diamonds'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: _selectedCurrency == 'diamonds'
                      ? const LinearGradient(colors: [AppColors.neonBlue, AppColors.purple])
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text('💎', style: TextStyle(fontSize: 32)),
                    const SizedBox(height: 4),
                    Text(
                      'الماس',
                      style: TextStyle(
                        color: _selectedCurrency == 'diamonds' ? Colors.white : AppColors.textSecondary,
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
              onTap: () => setState(() => _selectedCurrency = 'gold'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: _selectedCurrency == 'gold'
                      ? const LinearGradient(colors: [AppColors.gold, Colors.orange])
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text('🪙', style: TextStyle(fontSize: 32)),
                    const SizedBox(height: 4),
                    Text(
                      'العملات الذهبية',
                      style: TextStyle(
                        color: _selectedCurrency == 'gold' ? Colors.white : AppColors.textSecondary,
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

  Widget _buildPackagesList() {
    final packages = _selectedCurrency == 'diamonds' ? _diamondPackages : _goldPackages;
    
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: packages.length,
      itemBuilder: (context, index) {
        final package = packages[index];
        final isSelected = _selectedPackage == index;
        final isPopular = package['popular'] == true;
        final isBest = package['best'] == true;
        
        return GestureDetector(
          onTap: () => setState(() => _selectedPackage = index),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.darkCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? AppColors.gold
                    : (isBest ? AppColors.neonBlue : Colors.transparent),
                width: 2,
              ),
            ),
            child: Stack(
              children: [
                if (isPopular || isBest)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isBest ? AppColors.neonBlue : AppColors.purple,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                      ),
                      child: Text(
                        isBest ? '🔥 الأفضل' : '⭐ الأكثر شعبية',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: isPopular || isBest ? 28 : 16, left: 16, right: 16, bottom: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _selectedCurrency == 'diamonds' ? '💎' : '🪙',
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${package['amount']}',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if ((package['bonus'] as int) > 0) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '+${package['bonus']} مكافأة',
                            style: const TextStyle(
                              color: AppColors.success,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '\$${package['price']}',
                          style: const TextStyle(
                            color: AppColors.gold,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.check_circle, color: AppColors.gold, size: 24),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'طريقة الدفع',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildPaymentMethod('card', Icons.credit_card, 'بطاقة')),
                const SizedBox(width: 8),
                Expanded(child: _buildPaymentMethod('apple', Icons.apple, 'Apple Pay')),
                const SizedBox(width: 8),
                Expanded(child: _buildPaymentMethod('google', Icons.android, 'Google Pay')),
              ],
            ),
            const SizedBox(height: 16),
            _selectedPackage != null
                ? GradientButton(
                    text: 'شراء الآن',
                    onPressed: _processPurchase,
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.textTertiary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'اختر باقة',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(String id, IconData icon, String label) {
    final isSelected = _selectedPayment == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gold.withValues(alpha: 0.2) : AppColors.darkSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.gold : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? AppColors.gold : AppColors.textSecondary),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.gold : AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _processPurchase() {
    if (_selectedPackage == null) return;
    
    final packages = _selectedCurrency == 'diamonds' ? _diamondPackages : _goldPackages;
    final package = packages[_selectedPackage!];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkCard,
        title: const Text('تأكيد الشراء', style: TextStyle(color: AppColors.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedCurrency == 'diamonds' ? '💎' : '🪙',
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 12),
            Text(
              '${package['amount']} ${_selectedCurrency == 'diamonds' ? 'ماسة' : 'عملة ذهبية'}',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if ((package['bonus'] as int) > 0)
              Text(
                '+ ${package['bonus']} مكافأة',
                style: const TextStyle(color: AppColors.success),
              ),
            const SizedBox(height: 12),
            Text(
              'السعر: \$${package['price']}',
              style: const TextStyle(color: AppColors.gold, fontSize: 18),
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تمت عملية الشراء بنجاح! ✅'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold),
            child: const Text('تأكيد الدفع', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
