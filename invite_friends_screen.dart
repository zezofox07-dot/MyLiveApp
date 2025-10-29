import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/widgets/gradient_button.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  final String _inviteCode = 'SAWA2024';
  final String _inviteLink = 'https://sawachat.app/invite/SAWA2024';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دعوة الأصدقاء'),
        backgroundColor: AppColors.darkSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.purple, AppColors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(Icons.card_giftcard, color: Colors.white, size: 60),
                  const SizedBox(height: 16),
                  const Text(
                    'ادعُ أصدقاءك واحصل على مكافآت!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'احصل على 500 🪙 لكل صديق ينضم',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildRewardSection(),
            const SizedBox(height: 30),
            _buildInviteCodeSection(context),
            const SizedBox(height: 20),
            _buildInviteLinkSection(context),
            const SizedBox(height: 30),
            _buildShareButtons(context),
            const SizedBox(height: 30),
            _buildInvitedFriends(),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'مكافآتك',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildRewardItem(
                  icon: Icons.people,
                  label: 'الأصدقاء المدعوون',
                  value: '5',
                  color: AppColors.neonBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildRewardItem(
                  icon: Icons.monetization_on,
                  label: 'إجمالي المكافآت',
                  value: '2,500 🪙',
                  color: AppColors.gold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRewardItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInviteCodeSection(BuildContext context) {
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
            'كود الدعوة الخاص بك',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _inviteCode,
                    style: const TextStyle(
                      color: AppColors.gold,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => _copyToClipboard(context, _inviteCode, 'تم نسخ الكود'),
                icon: const Icon(Icons.copy, color: AppColors.gold),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.gold.withValues(alpha: 0.2),
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInviteLinkSection(BuildContext context) {
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
            'رابط الدعوة',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _inviteLink,
                    style: const TextStyle(
                      color: AppColors.neonBlue,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => _copyToClipboard(context, _inviteLink, 'تم نسخ الرابط'),
                icon: const Icon(Icons.copy, color: AppColors.neonBlue),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.neonBlue.withValues(alpha: 0.2),
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShareButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'مشاركة عبر',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GradientButton(
                text: 'WhatsApp',
                onPressed: () => _share(context, 'WhatsApp'),
                icon: Icons.message,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GradientButton(
                text: 'المزيد',
                onPressed: () => _share(context, 'other'),
                icon: Icons.share,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInvitedFriends() {
    final friends = [
      {'name': 'أحمد محمد', 'date': 'منذ يومين', 'status': 'مكتمل'},
      {'name': 'فاطمة علي', 'date': 'منذ 3 أيام', 'status': 'مكتمل'},
      {'name': 'سارة خالد', 'date': 'منذ 5 أيام', 'status': 'مكتمل'},
      {'name': 'محمد حسن', 'date': 'منذ أسبوع', 'status': 'قيد الانتظار'},
      {'name': 'ليلى يوسف', 'date': 'منذ أسبوعين', 'status': 'مكتمل'},
    ];

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
            'الأصدقاء المدعوون',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...friends.map((friend) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.gold,
                      child: Icon(Icons.person, color: Colors.black, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            friend['name']!,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            friend['date']!,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: friend['status'] == 'مكتمل'
                            ? AppColors.success.withValues(alpha: 0.2)
                            : AppColors.textTertiary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        friend['status']!,
                        style: TextStyle(
                          color: friend['status'] == 'مكتمل' ? AppColors.success : AppColors.textTertiary,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _share(BuildContext context, String platform) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('مشاركة عبر $platform...'),
        backgroundColor: AppColors.neonBlue,
      ),
    );
  }
}
