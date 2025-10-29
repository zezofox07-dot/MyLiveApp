import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';

class DailyTasksScreen extends StatefulWidget {
  const DailyTasksScreen({super.key});

  @override
  State<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'تسجيل الدخول اليومي', 'reward': 50, 'current': 1, 'target': 1, 'completed': true},
    {'title': 'أرسل 10 رسائل', 'reward': 100, 'current': 7, 'target': 10, 'completed': false},
    {'title': 'انضم لـ 3 غرف', 'reward': 150, 'current': 2, 'target': 3, 'completed': false},
    {'title': 'أرسل 5 هدايا', 'reward': 200, 'current': 0, 'target': 5, 'completed': false},
    {'title': 'ابقَ متصلاً لمدة 30 دقيقة', 'reward': 300, 'current': 18, 'target': 30, 'completed': false},
    {'title': 'احصل على 100 إعجاب', 'reward': 250, 'current': 45, 'target': 100, 'completed': false},
  ];

  @override
  Widget build(BuildContext context) {
    final completedCount = _tasks.where((t) => t['completed']).length;
    final totalReward = _tasks.fold<int>(0, (sum, task) => sum + (task['completed'] ? task['reward'] as int : 0));
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('المهام اليومية'),
        backgroundColor: AppColors.darkSurface,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.gold, AppColors.neonBlue],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('المهام المكتملة', '$completedCount/${_tasks.length}'),
                Container(width: 1, height: 40, color: Colors.white30),
                _buildStatItem('المكافآت المكتسبة', '$totalReward 🪙'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return _buildTaskCard(task);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.darkCard,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const Text(
                    'أكمل جميع المهام للحصول على مكافأة إضافية!',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.purple, AppColors.pink],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.card_giftcard, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'مكافأة إضافية: 1000 🪙',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
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

  Widget _buildTaskCard(Map<String, dynamic> task) {
    final isCompleted = task['completed'] as bool;
    final progress = (task['current'] as int) / (task['target'] as int);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: isCompleted ? Border.all(color: AppColors.success, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.success.withValues(alpha: 0.2)
                      : AppColors.gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isCompleted ? Icons.check_circle : Icons.assignment,
                  color: isCompleted ? AppColors.success : AppColors.gold,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task['title'],
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'مكافأة: ${task['reward']} 🪙',
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم استلام ${task['reward']} 🪙'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('استلام', style: TextStyle(color: Colors.white)),
                ),
            ],
          ),
          if (!isCompleted) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColors.darkSurface,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.neonBlue),
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${task['current']}/${task['target']}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
