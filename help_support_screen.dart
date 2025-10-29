import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/widgets/gradient_button.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعدة والدعم'),
        backgroundColor: AppColors.darkSurface,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'الأسئلة الشائعة',
            icon: Icons.help_outline,
            color: AppColors.gold,
            items: [
              _FAQItem(
                question: 'كيف يمكنني شحن الرصيد؟',
                answer: 'يمكنك شحن الرصيد من خلال قسم "إعادة الشحن" في الملف الشخصي واختيار طريقة الدفع المناسبة.',
              ),
              _FAQItem(
                question: 'كيف أرسل هدية؟',
                answer: 'اضغط على أيقونة الهدية في الغرفة أو المحادثة، واختر الهدية المناسبة وقم بتأكيد الإرسال.',
              ),
              _FAQItem(
                question: 'ما هو الفرق بين VIP و SVIP؟',
                answer: 'VIP يوفر مزايا أساسية مثل الشارات والأيقونات الخاصة، بينما SVIP يوفر مزايا إضافية متقدمة.',
              ),
              _FAQItem(
                question: 'كيف يمكنني إنشاء غرفة خاصة؟',
                answer: 'اذهب إلى قسم الغرف واضغط على زر "+" ثم اختر إعدادات الغرفة واسمها.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildContactSection(context),
          const SizedBox(height: 20),
          _buildInfoSection(),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<_FAQItem> items,
  }) {
    return Container(
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
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map((item) => _buildFAQItem(item)),
        ],
      ),
    );
  }

  Widget _buildFAQItem(_FAQItem item) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        item.question,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      ),
      iconColor: AppColors.gold,
      collapsedIconColor: AppColors.textSecondary,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            item.answer,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.support_agent, color: AppColors.neonBlue, size: 48),
          const SizedBox(height: 12),
          const Text(
            'تواصل معنا',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'فريق الدعم متاح على مدار الساعة لمساعدتك',
            style: TextStyle(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          GradientButton(
            text: 'إرسال رسالة للدعم',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('سيتم فتح نافذة الدعم قريباً'),
                  backgroundColor: AppColors.neonBlue,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.email, 'البريد الإلكتروني', 'support@sawachat.com'),
          const Divider(color: AppColors.textTertiary),
          _buildInfoRow(Icons.language, 'الموقع الإلكتروني', 'www.sawachat.com'),
          const Divider(color: AppColors.textTertiary),
          _buildInfoRow(Icons.info, 'الإصدار', '1.0.0'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FAQItem {
  final String question;
  final String answer;

  _FAQItem({required this.question, required this.answer});
}
