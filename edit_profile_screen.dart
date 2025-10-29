import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/providers/app_state.dart';
import 'package:sawa_chat/widgets/gradient_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  String _selectedGender = 'ذكر';
  String _selectedCountry = '🇸🇦';
  Uint8List? _selectedAvatarImage;
  Uint8List? _selectedBackgroundImage;
  String? _avatarUrl;
  String? _backgroundUrl;

  final _countries = ['🇸🇦', '🇦🇪', '🇪🇬', '🇰🇼', '🇶🇦', '🇴🇲', '🇧🇭', '🇯🇴', '🇱🇧', '🇮🇶'];
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final user = context.read<AppState>().currentUser;
    _nameController = TextEditingController(text: user?.displayName ?? '');
    _bioController = TextEditingController(text: user?.currentStatus ?? '');
    _selectedGender = user?.gender ?? 'ذكر';
    _selectedCountry = user?.countryFlag ?? '🇸🇦';
    _avatarUrl = user?.avatarUrl;
    _backgroundUrl = user?.backgroundImageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatarImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _selectedAvatarImage = bytes;
          _avatarUrl = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل اختيار الصورة: $e')),
        );
      }
    }
  }

  Future<void> _pickBackgroundImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _selectedBackgroundImage = bytes;
          _backgroundUrl = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل اختيار الصورة: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الملف الشخصي'),
        backgroundColor: AppColors.darkSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    'صورة الملف الشخصي',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.gold, width: 3),
                          image: _selectedAvatarImage != null
                              ? DecorationImage(
                                  image: MemoryImage(_selectedAvatarImage!),
                                  fit: BoxFit.cover,
                                )
                              : _avatarUrl != null
                                  ? DecorationImage(
                                      image: NetworkImage(_avatarUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                        ),
                        child: _selectedAvatarImage == null && _avatarUrl == null
                            ? const Icon(
                                Icons.person,
                                size: 60,
                                color: AppColors.textTertiary,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickAvatarImage,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.gold,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.black, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  const Text(
                    'خلفية الملف الشخصي',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _pickBackgroundImage,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.darkCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3), width: 2),
                        image: _selectedBackgroundImage != null
                            ? DecorationImage(
                                image: MemoryImage(_selectedBackgroundImage!),
                                fit: BoxFit.cover,
                              )
                            : _backgroundUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(_backgroundUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                      ),
                      child: _selectedBackgroundImage == null && _backgroundUrl == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate,
                                  size: 48,
                                  color: AppColors.textTertiary,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'اضغط لاختيار خلفية',
                                  style: TextStyle(
                                    color: AppColors.textTertiary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              children: [
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(
              controller: _nameController,
              label: 'الاسم',
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _bioController,
              label: 'النبذة الشخصية',
              icon: Icons.info_outline,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            _buildGenderSelector(),
            const SizedBox(height: 16),
            _buildCountrySelector(),
            const SizedBox(height: 30),
            GradientButton(
              text: 'حفظ التغييرات',
              onPressed: _saveChanges,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.textSecondary),
          icon: Icon(icon, color: AppColors.gold),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.wc, color: AppColors.gold),
          const SizedBox(width: 16),
          const Text('الجنس:', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(width: 20),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('ذكر', style: TextStyle(color: AppColors.textPrimary)),
                    value: 'ذكر',
                    groupValue: _selectedGender,
                    activeColor: AppColors.gold,
                    onChanged: (value) => setState(() => _selectedGender = value!),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('أنثى', style: TextStyle(color: AppColors.textPrimary)),
                    value: 'أنثى',
                    groupValue: _selectedGender,
                    activeColor: AppColors.gold,
                    onChanged: (value) => setState(() => _selectedGender = value!),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountrySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.flag, color: AppColors.gold),
          const SizedBox(width: 16),
          const Text('الدولة:', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(width: 20),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCountry,
                dropdownColor: AppColors.darkCard,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 24),
                items: _countries.map((country) {
                  return DropdownMenuItem(value: country, child: Text(country));
                }).toList(),
                onChanged: (value) => setState(() => _selectedCountry = value!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveChanges() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إدخال الاسم'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    String? newAvatarUrl = _avatarUrl;
    if (_selectedAvatarImage != null) {
      newAvatarUrl = 'data:image/png;base64,${_selectedAvatarImage!.toString()}';
    }

    String? newBackgroundUrl = _backgroundUrl;
    if (_selectedBackgroundImage != null) {
      newBackgroundUrl = 'data:image/png;base64,${_selectedBackgroundImage!.toString()}';
    }

    final countryCode = _getCountryCode(_selectedCountry);

    try {
      await context.read<AppState>().updateProfile(
            displayName: _nameController.text.trim(),
            currentStatus: _bioController.text.trim(),
            gender: _selectedGender,
            countryCode: countryCode,
            countryFlag: _selectedCountry,
            avatarUrl: newAvatarUrl,
            backgroundImageUrl: newBackgroundUrl,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حفظ التغييرات بنجاح'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل حفظ التغييرات: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  String _getCountryCode(String flag) {
    final Map<String, String> flagToCode = {
      '🇸🇦': 'SA',
      '🇦🇪': 'AE',
      '🇪🇬': 'EG',
      '🇰🇼': 'KW',
      '🇶🇦': 'QA',
      '🇴🇲': 'OM',
      '🇧🇭': 'BH',
      '🇯🇴': 'JO',
      '🇱🇧': 'LB',
      '🇮🇶': 'IQ',
    };
    return flagToCode[flag] ?? 'SA';
  }
}
