import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/widgets/gradient_button.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المتجر'),
        backgroundColor: AppColors.darkSurface,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.gold,
          labelColor: AppColors.gold,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: const [
            Tab(text: 'VIP'),
            Tab(text: 'الإطارات'),
            Tab(text: 'الشارات'),
            Tab(text: 'الثيمات'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVIPTab(),
          _buildFramesTab(),
          _buildBadgesTab(),
          _buildThemesTab(),
        ],
      ),
    );
  }

  Widget _buildVIPTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildVIPCard(
          title: 'VIP عادي',
          price: '50',
          duration: 'شهر واحد',
          benefits: [
            'شارة VIP مميزة',
            'إطار ذهبي للصورة',
            'دخول مجاني للغرف الخاصة',
            'أولوية في قائمة الغرفة',
          ],
          color: AppColors.gold,
        ),
        const SizedBox(height: 16),
        _buildVIPCard(
          title: 'SVIP متقدم',
          price: '150',
          duration: 'شهر واحد',
          benefits: [
            'جميع مزايا VIP',
            'شارة SVIP حصرية',
            'إطار بلاتيني متحرك',
            'تأثيرات دخول خاصة',
            'غرفة خاصة مجانية',
            '500 عملة ذهبية هدية',
          ],
          color: AppColors.neonBlue,
          isRecommended: true,
        ),
      ],
    );
  }

  Widget _buildVIPCard({
    required String title,
    required String price,
    required String duration,
    required List<String> benefits,
    required Color color,
    bool isRecommended = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: isRecommended ? Border.all(color: color, width: 2) : null,
      ),
      child: Column(
        children: [
          if (isRecommended)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              ),
              child: const Text(
                '⭐ الأكثر شعبية',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('💎', style: TextStyle(fontSize: 24)),
                  ],
                ),
                Text(
                  duration,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 20),
                ...benefits.map((benefit) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: color, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              benefit,
                              style: const TextStyle(color: AppColors.textPrimary),
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                GradientButton(
                  text: 'شراء الآن',
                  onPressed: () {
                    _showPurchaseDialog(title, price);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFramesTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final frames = [
          {'name': 'إطار ذهبي', 'price': '20', 'color': AppColors.gold},
          {'name': 'إطار فضي', 'price': '15', 'color': AppColors.textSecondary},
          {'name': 'إطار نيون', 'price': '25', 'color': AppColors.neonBlue},
          {'name': 'إطار وردي', 'price': '18', 'color': AppColors.pink},
          {'name': 'إطار بنفسجي', 'price': '22', 'color': AppColors.purple},
          {'name': 'إطار قوس قزح', 'price': '30', 'color': AppColors.gold},
        ];
        final frame = frames[index];
        return _buildStoreItem(
          name: frame['name'] as String,
          price: frame['price'] as String,
          color: frame['color'] as Color,
        );
      },
    );
  }

  Widget _buildBadgesTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final badges = [
          {'name': 'شارة النجم', 'price': '10', 'emoji': '⭐'},
          {'name': 'شارة التاج', 'price': '15', 'emoji': '👑'},
          {'name': 'شارة القلب', 'price': '12', 'emoji': '💖'},
          {'name': 'شارة الماس', 'price': '20', 'emoji': '💎'},
          {'name': 'شارة النار', 'price': '18', 'emoji': '🔥'},
          {'name': 'شارة البرق', 'price': '25', 'emoji': '⚡'},
        ];
        final badge = badges[index];
        return _buildBadgeItem(
          name: badge['name'] as String,
          price: badge['price'] as String,
          emoji: badge['emoji'] as String,
        );
      },
    );
  }

  Widget _buildThemesTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        final themes = [
          {'name': 'ثيم الليل', 'price': '30', 'color': AppColors.darkBackground},
          {'name': 'ثيم النيون', 'price': '35', 'color': AppColors.neonBlue},
          {'name': 'ثيم الذهب', 'price': '40', 'color': AppColors.gold},
          {'name': 'ثيم الوردي', 'price': '32', 'color': AppColors.pink},
        ];
        final theme = themes[index];
        return _buildStoreItem(
          name: theme['name'] as String,
          price: theme['price'] as String,
          color: theme['color'] as Color,
        );
      },
    );
  }

  Widget _buildStoreItem({
    required String name,
    required String price,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 3),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                price,
                style: const TextStyle(color: AppColors.gold, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              const Text('💎', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _showPurchaseDialog(name, price),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('شراء'),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem({
    required String name,
    required String price,
    required String emoji,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 60)),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                price,
                style: const TextStyle(color: AppColors.gold, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              const Text('💎', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _showPurchaseDialog(name, price),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('شراء'),
          ),
        ],
      ),
    );
  }

  void _showPurchaseDialog(String item, String price) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkCard,
        title: const Text('تأكيد الشراء', style: TextStyle(color: AppColors.textPrimary)),
        content: Text(
          'هل تريد شراء $item مقابل $price 💎؟',
          style: const TextStyle(color: AppColors.textSecondary),
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
                  content: Text('تم الشراء بنجاح! ✅'),
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
