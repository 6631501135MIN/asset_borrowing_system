import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF0C1851),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile.adaptive(
            value: notifications,
            onChanged: (v) => setState(() => notifications = v),
            title: const Text(
              'Notifications',
              style: TextStyle(color: Colors.white),
            ),
            activeColor: Colors.green,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Account'),
                  content: const Text(
                    'Are you sure you want to delete your account?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirmed == true) {
                // WHY: keep scope isolated; after deletion, send back to staff login.
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/staff-login',
                  (r) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}
