import 'package:flutter/material.dart';
import 'package:jouks_app/widgets/main_menu/main_menu_content.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainMenuContent(),
    );
  }
}
