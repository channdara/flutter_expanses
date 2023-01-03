import 'package:flutter/material.dart';

import '../../../common/extension/context_extension.dart';
import '../../widget/custom_app_bar.dart';
import 'setting_item_template_screen/setting_item_template_screen.dart';
import 'settings_screen_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(label: 'Settings'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SettingsScreenItem(
                    icon: Icons.note_alt,
                    title: 'Item Templates',
                    subtitle: 'Add or edit item template',
                    onTap: () =>
                        context.push(const SettingItemTemplateScreen()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
