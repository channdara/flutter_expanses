import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../widget/custom_app_bar.dart';
import 'settings_screen_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseState<SettingsScreen> {
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
                    icon: Icons.check_circle,
                    title: 'Check Daily Documents',
                    subtitle: 'Check and create missing daily document',
                    onTap: () => firestoreService.checkAllDay(),
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
