import 'package:flutter/material.dart';
import 'package:jouks_app/main.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Theme mode"),
            ToggleSwitch(
              initialLabelIndex:
                  Theme.of(context).brightness == Brightness.light ? 0 : 1,
              icons: const [Icons.light_mode, Icons.dark_mode],
              onToggle: (index) {
                MyApp.of(context)
                    .changeTheme(index == 0 ? ThemeMode.light : ThemeMode.dark);
              },
            ),
          ],
        ),
      ),
    );
  }
}
