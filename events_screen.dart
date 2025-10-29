import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/widgets/gradient_button.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الفعاليات'),
        backgroundColor: AppColors.darkSurface,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildActiveEvent(
            title: 'مسابقة أفضل غرفة',
            description: 'اجمع أكبر عدد من النقاط في غرفتك واربح جوائز قيمة!',
            endDate: 'تنتهي خلال 3 أيام',
            prize: '10,000 💎',
            participants: 1247,
            color: AppColors.gold,
            context: context,
          ),
          const SizedBox(height: 16),
          _buildActiveEvent(
            title: 'تحدي الإرسال اليومي',
            description: 'أرسل 100 هدية اليوم واحصل على مكافآت خاصة',
            endDate: 'ينتهي اليوم',
            prize: '5,000 🪙',
            participants: 823,
            color: AppColors.neonBlue,
            context: context,
          ),
          const SizedBox(height: 16),
          _buildActiveEvent(
            title: 'عيد ميلاد سوا شات',
            description: 'احتفل معنا بعيد ميلادنا الأول واحصل على هدايا يومية',
            endDate: 'تنتهي خلال أسبوع',
            prize: 'هدايا يومية',
            participants: 5432,
            color: AppColors.pink,
            context: context,
          ),
          const SizedBox(height: 16),
          _buildActiveEvent(
            title: 'بطولة الغناء',
            description: 'شارك في مسابقة الغناء واربح جوائز نقدية ضخمة',
            endDate: 'تنتهي خلال 5 أيام',
            prize: '50,000 💎',
            participants: 2891,
            color: AppColors.purple,
            context: context,
          ),
          const SizedBox(height: 24),
          const Text(
            'الفعاليات القادمة',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildUpcomingEvent(
            title: 'ليلة رمضان الخاصة',
            startDate: 'تبدأ بعد أسبوعين',
            icon: Icons.nightlight,
          ),
          _buildUpcomingEvent(
            title: 'مهرجان الصيف',
            startDate: 'تبدأ بعد شهر',
            icon: Icons.wb_sunny,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveEvent({
    required String title,
    required String description,
    required String endDate,
    required String prize,
    required int participants,
    required Color color,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.3), Colors.transparent],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.event, color: Colors.black),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.timer, color: AppColors.textSecondary, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            endDate,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoChip(
                        icon: Icons.emoji_events,
                        label: 'الجائزة',
                        value: prize,
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildInfoChip(
                        icon: Icons.people,
                        label: 'المشاركون',
                        value: '$participants',
                        color: AppColors.neonBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GradientButton(
                  text: 'المشاركة الآن',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم الانضمام للفعالية بنجاح! 🎉'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvent({
    required String title,
    required String startDate,
    required IconData icon,
  }) {
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
              color: AppColors.textTertiary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.textTertiary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  startDate,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.notifications_none, color: AppColors.textTertiary),
        ],
      ),
    );
  }
}
