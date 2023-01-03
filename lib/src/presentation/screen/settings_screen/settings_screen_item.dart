import 'package:flutter/material.dart';

import '../../../common/color_constant.dart';

class SettingsScreenItem extends StatelessWidget {
  const SettingsScreenItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ColorConstant.colorPrimary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12.0)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
