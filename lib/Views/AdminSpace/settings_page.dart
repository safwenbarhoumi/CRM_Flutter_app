import 'package:flutter/material.dart';

class AdminSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _settingTile("Account Settings", Icons.person, () {}),
        _settingTile("System Preferences", Icons.settings, () {}),
        _settingTile("Change Password", Icons.lock, () {}),
        _settingTile("Logout", Icons.logout, () {
          // perform logout
        }),
      ],
    );
  }

  Widget _settingTile(String title, IconData icon, VoidCallback onTap) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
