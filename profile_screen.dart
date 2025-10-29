import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/providers/app_state.dart';
import 'package:sawa_chat/widgets/user_avatar.dart';
import 'package:sawa_chat/widgets/currency_display.dart';
import 'package:sawa_chat/widgets/level_badge.dart';
import 'package:sawa_chat/screens/auth_screen.dart';
import 'package:sawa_chat/screens/edit_profile_screen.dart';
import 'package:sawa_chat/screens/privacy_settings_screen.dart';
import 'package:sawa_chat/screens/help_support_screen.dart';
import 'package:sawa_chat/screens/recharge_screen.dart';
import 'package:sawa_chat/screens/currency_exchange_screen.dart';
import 'package:sawa_chat/screens/daily_tasks_screen.dart';
import 'package:sawa_chat/screens/invite_friends_screen.dart';
import 'package:sawa_chat/screens/store_screen.dart';
import 'package:sawa_chat/screens/leaderboard_screen.dart';
import 'package:sawa_chat/screens/transaction_history_screen.dart';
import 'package:sawa_chat/screens/events_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('لم يتم تسجيل الدخول')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.darkSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  if (user.backgroundImageUrl != null)
                    Positioned.fill(
                      child: Image.network(
                        user.backgroundImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gold.withValues(alpha: 0.3),
                                AppColors.darkBackground,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.gold.withValues(alpha: 0.3),
                            AppColors.darkBackground,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.darkBackground.withValues(alpha: 0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        UserAvatar(
                          avatarUrl: user.avatarUrl,
                          size: 100,
                          vipLevel: user.vipLevel,
                          svipLevel: user.svipLevel,
                          showOnlineStatus: true,
                          isOnline: user.isOnline,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          user.displayName,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${user.countryFlag} ID: ${user.id}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        LevelBadge(level: user.level),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: AppColors.gold),
                onPressed: () {
                  _showSettingsDialog(context);
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildStatsRow(user),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CurrencyDisplay(
                    goldCoins: user.goldCoins,
                    diamonds: user.diamonds,
                    showLabels: true,
                  ),
                ),
                const SizedBox(height: 24),
                _buildMenuSection(context, user),
                const SizedBox(height: 16),
                _buildAchievementsSection(user),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(user) {
    return Row(
      children: [
        Expanded(child: _buildStatItem('المتابعون', user.followersCount)),
        Expanded(child: _buildStatItem('المتابَعون', user.followingCount)),
        Expanded(child: _buildStatItem('الأصدقاء', user.friendsCount)),
        Expanded(child: _buildStatItem('الزوار', user.visitorsCount)),
      ],
    );
  }

  Widget _buildStatItem(String label, int count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '$count',
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, user) {
    final menuItems = [
      {'icon': Icons.account_balance_wallet, 'label': 'إعادة الشحن', 'color': AppColors.gold, 'screen': const RechargeScreen()},
      {'icon': Icons.swap_horiz, 'label': 'تبديل العملات', 'color': AppColors.neonBlue, 'screen': const CurrencyExchangeScreen()},
      {'icon': Icons.task_alt, 'label': 'المهام اليومية', 'color': AppColors.purple, 'screen': const DailyTasksScreen()},
      {'icon': Icons.group_add, 'label': 'دعوة الأصدقاء', 'color': AppColors.pink, 'screen': const InviteFriendsScreen()},
      {'icon': Icons.shopping_bag, 'label': 'المتجر', 'color': AppColors.gold, 'screen': const StoreScreen()},
      {'icon': Icons.leaderboard, 'label': 'لوحة المتصدرين', 'color': AppColors.neonBlue, 'screen': const LeaderboardScreen()},
      {'icon': Icons.history, 'label': 'سجل المعاملات', 'color': AppColors.purple, 'screen': const TransactionHistoryScreen()},
      {'icon': Icons.event, 'label': 'الفعاليات', 'color': AppColors.pink, 'screen': const EventsScreen()},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.85,
          crossAxisSpacing: 8,
          mainAxisSpacing: 16,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item['screen'] as Widget),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: item['color'] as Color,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['label'] as String,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAchievementsSection(user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.emoji_events, color: AppColors.gold, size: 20),
              const SizedBox(width: 8),
              const Text(
                'الإنجازات',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (user.achievements.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'لم تحصل على أي إنجازات بعد',
                  style: TextStyle(color: AppColors.textTertiary),
                ),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: user.achievements.map<Widget>((achievement) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.gold, AppColors.neonBlue],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    achievement,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.local_fire_department, color: AppColors.gold, size: 16),
              const SizedBox(width: 4),
              Text(
                'سلسلة تسجيل دخول: ${user.dailyLoginStreak} يوم',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
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
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textTertiary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'الإعدادات',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.edit, color: AppColors.gold),
              title: const Text('تعديل الملف الشخصي'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: AppColors.neonBlue),
              title: const Text('الخصوصية'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacySettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: AppColors.purple),
              title: const Text('المساعدة والدعم'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: const Text('تسجيل الخروج'),
              onTap: () async {
                await context.read<AppState>().logout();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const AuthScreen()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
