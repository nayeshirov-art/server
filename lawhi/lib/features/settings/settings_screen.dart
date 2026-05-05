import 'package:flutter/material.dart';
import 'package:lawhi/core/constants/app_constants.dart';
import 'package:lawhi/core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات', style: TextStyle(fontFamily: 'Amiri', fontSize: 22)),
      ),
      body: ListView(
        children: [
          _SectionHeader(title: 'القرآن الكريم'),
          _SettingsTile(icon: Icons.mic, title: 'القارئ الافتراضي', subtitle: 'مشاري العفاسي', onTap: () {}),
          _SettingsTile(icon: Icons.text_fields, title: 'حجم الخط', subtitle: 'متوسط', onTap: () {}),
          _SettingsTile(icon: Icons.translate, title: 'لغة الترجمة', subtitle: 'الفرنسية', onTap: () {}),
          _SectionHeader(title: 'التطبيق'),
          _SettingsTile(icon: Icons.dark_mode, title: 'المظهر', subtitle: 'داكن', onTap: () {}),
          _SettingsTile(icon: Icons.notifications, title: 'الإشعارات', subtitle: 'مفعّلة', onTap: () {}),
          _SectionHeader(title: 'حول التطبيق'),
          _SettingsTile(
            icon: Icons.info_outline,
            title: 'الإصدار',
            subtitle: '1.0.0 - النسخة التجريبية',
            onTap: () {},
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.gold.withValues(alpha:0.2), shape: BoxShape.circle),
              child: const Icon(Icons.favorite, color: AppTheme.gold),
            ),
            title: const Text('مشروع أمل الأمة', style: TextStyle(fontFamily: 'Amiri', fontSize: 18)),
            subtitle: const Text('ساهم في بناء مسجد بنواكشوط'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: Text(
                AppConstants.appName,
                style: TextStyle(fontFamily: 'Amiri', fontSize: 32, color: AppTheme.gold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        title,
        style: TextStyle(fontSize: 13, fontFamily: 'Amiri', color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha:0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(title, style: const TextStyle(fontFamily: 'Amiri', fontSize: 17)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
