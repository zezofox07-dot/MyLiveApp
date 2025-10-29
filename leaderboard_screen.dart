import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/widgets/user_avatar.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('لوحة المتصدرين'),
        backgroundColor: AppColors.darkSurface,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.gold,
          labelColor: AppColors.gold,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: const [
            Tab(text: 'اليوم'),
            Tab(text: 'هذا الأسبوع'),
            Tab(text: 'هذا الشهر'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLeaderboardList('daily'),
          _buildLeaderboardList('weekly'),
          _buildLeaderboardList('monthly'),
        ],
      ),
    );
  }

  Widget _buildLeaderboardList(String period) {
    final leaders = _generateLeaders(period);
    
    return Column(
      children: [
        _buildTopThree(leaders.take(3).toList()),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: leaders.length - 3,
            itemBuilder: (context, index) {
              final leader = leaders[index + 3];
              return _buildLeaderCard(leader, index + 4);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopThree(List<Map<String, dynamic>> topThree) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.gold.withValues(alpha: 0.2),
            AppColors.darkBackground,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (topThree.length > 1) _buildTopUser(topThree[1], 2, 180),
          if (topThree.isNotEmpty) _buildTopUser(topThree[0], 1, 200),
          if (topThree.length > 2) _buildTopUser(topThree[2], 3, 160),
        ],
      ),
    );
  }

  Widget _buildTopUser(Map<String, dynamic> user, int rank, double height) {
    final medals = ['🥇', '🥈', '🥉'];
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(medals[rank - 1], style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          UserAvatar(
            avatarUrl: user['avatar'],
            size: rank == 1 ? 70 : 60,
            vipLevel: user['vipLevel'],
            svipLevel: user['svipLevel'],
          ),
          const SizedBox(height: 8),
          Text(
            user['name'],
            style: TextStyle(
              color: rank == 1 ? AppColors.gold : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: rank == 1 ? AppColors.gold : AppColors.darkCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('💎', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 4),
                Text(
                  '${user['coins']}',
                  style: TextStyle(
                    color: rank == 1 ? Colors.black : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderCard(Map<String, dynamic> user, int rank) {
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
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$rank',
                style: const TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          UserAvatar(
            avatarUrl: user['avatar'],
            size: 40,
            vipLevel: user['vipLevel'],
            svipLevel: user['svipLevel'],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name'],
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user['country']} المستوى ${user['level']}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text('💎', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                    '${user['coins']}',
                    style: const TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _generateLeaders(String period) {
    return List.generate(20, (index) {
      return {
        'name': 'مستخدم ${index + 1}',
        'avatar': 'https://i.pravatar.cc/150?img=${index + 1}',
        'level': 50 - index * 2,
        'coins': 10000 - index * 500,
        'country': ['🇸🇦', '🇦🇪', '🇪🇬', '🇰🇼'][index % 4],
        'vipLevel': index < 5 ? 1 : 0,
        'svipLevel': index < 2 ? 1 : 0,
      };
    });
  }
}
