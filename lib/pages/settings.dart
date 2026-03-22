import 'package:flutter/material.dart';
import 'package:helm/dbconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _StringSettingTile(
            title: "Server Address",
            subtitle: "IP address of the Network Tables server.",
            leading: Icon(Icons.network_wifi_sharp),
            preferenceKey: DBConstants.ntServerAddrKey,
          ),
        ],
      ),
    );
  }
}

class _StringSettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon leading;
  final String preferenceKey;

  const _StringSettingTile({
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.preferenceKey,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: leading,
      trailing: const Icon(Icons.edit),
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        final newValue = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            String tempValue = prefs.getString(preferenceKey) ?? "";
            return AlertDialog(
              title: Text('Edit $title'),
              content: TextField(
                controller: TextEditingController(text: tempValue),
                onChanged: (value) {
                  tempValue = value;
                },
                decoration: InputDecoration(
                  label: Text('Enter new $title'),
                  hintText: tempValue,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(tempValue),
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
        if (newValue != null) {
          await prefs.setString(preferenceKey, newValue);
        }
      },
    );
  }
}
