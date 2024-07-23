import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'appearance_page.dart';
import 'privacy_security_page.dart';
import 'help_page.dart';
import 'about_page.dart';
import '../helpers/bottom_bar.dart';
import '../helpers/settings_list.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SettingsList(
            page: AccountDetailsPage(),
            title: 'Account',
          ),
          const SettingsList(
              page: PrivacySecurityPage(), title: 'Privacy and Security'),
          SettingsList(page: AppearancePage(), title: 'Appearance'),
          SettingsList(page: HelpPage(), title: 'Help and Support'),
          SettingsList(page: AboutPage(), title: 'About'),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
