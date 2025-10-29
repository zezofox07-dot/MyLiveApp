import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _showOnlineStatus = true;
  bool _allowMessages = true;
  bool _allowRoomInvites = true;
  bool _showProfile = true;
  bool _allowGifts = true;
  bool _allowVoiceCalls = false;
  String _whoCanMessage = 'الجميع';
  String _whoCanViewProfile = 'الجميع';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات الخصوصية'),
        backgroundColor: AppColors.darkSurface,
      ),
      body: ListView(
        children: [
          _buildSection(
            title: 'الحالة والظهور',
            children: [
              _buildSwitchTile(
                title: 'إظهار حالة الاتصال',
                subtitle: 'السماح للآخرين برؤية حالتك (متصل/غير متصل)',
                value: _showOnlineStatus,
                onChanged: (val) => setState(() => _showOnlineStatus = val),
              ),
              _buildSwitchTile(
                title: 'إظهار الملف الشخصي',
                subtitle: 'السماح للآخرين بزيارة ملفك الشخصي',
                value: _showProfile,
                onChanged: (val) => setState(() => _showProfile = val),
              ),
            ],
          ),
          _buildSection(
            title: 'الرسائل',
            children: [
              _buildSwitchTile(
                title: 'استقبال الرسائل',
                subtitle: 'السماح للآخرين بإرسال رسائل إليك',
                value: _allowMessages,
                onChanged: (val) => setState(() => _allowMessages = val),
              ),
              _buildDropdownTile(
                title: 'من يمكنه مراسلتي',
                value: _whoCanMessage,
                items: ['الجميع', 'الأصدقاء فقط', 'لا أحد'],
                onChanged: (val) => setState(() => _whoCanMessage = val!),
              ),
            ],
          ),
          _buildSection(
            title: 'الغرف والمكالمات',
            children: [
              _buildSwitchTile(
                title: 'دعوات الغرف',
                subtitle: 'السماح للآخرين بدعوتك للغرف',
                value: _allowRoomInvites,
                onChanged: (val) => setState(() => _allowRoomInvites = val),
              ),
              _buildSwitchTile(
                title: 'المكالمات الصوتية',
                subtitle: 'السماح باستقبال مكالمات صوتية',
                value: _allowVoiceCalls,
                onChanged: (val) => setState(() => _allowVoiceCalls = val),
              ),
            ],
          ),
          _buildSection(
            title: 'الهدايا والتفاعل',
            children: [
              _buildSwitchTile(
                title: 'استقبال الهدايا',
                subtitle: 'السماح للآخرين بإرسال هدايا إليك',
                value: _allowGifts,
                onChanged: (val) => setState(() => _allowGifts = val),
              ),
              _buildDropdownTile(
                title: 'من يمكنه مشاهدة ملفي',
                value: _whoCanViewProfile,
                items: ['الجميع', 'الأصدقاء فقط', 'لا أحد'],
                onChanged: (val) => setState(() => _whoCanViewProfile = val!),
              ),
            ],
          ),
          _buildSection(
            title: 'الحساب',
            children: [
              ListTile(
                leading: const Icon(Icons.block, color: AppColors.error),
                title: const Text('المستخدمون المحظورون'),
                subtitle: const Text('إدارة قائمة الحظر'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textTertiary, fontSize: 12)),
      value: value,
      activeColor: AppColors.gold,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
      trailing: DropdownButton<String>(
        value: value,
        dropdownColor: AppColors.darkCard,
        style: const TextStyle(color: AppColors.gold),
        underline: const SizedBox(),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
