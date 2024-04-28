import 'package:flutter/material.dart';
import 'package:jouks_app/pages/exercise/exercises.dart';
import 'package:jouks_app/pages/game/game_setup.dart';
import 'package:jouks_app/pages/main_menu/main_menu.dart';
import 'package:jouks_app/pages/settings/settings.dart';
import 'package:jouks_app/prodivers/player_provider.dart';
import 'package:jouks_app/utils/route_url.dart';
import 'package:jouks_app/utils/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PlayerProvider())
        ],
        child: MaterialApp(
          title: 'Jouks card game',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themeMode,
          home: const MainMenuScreen(),
          routes: {
            RouteUrl.MAIN_MENU: (context) => const MainMenuScreen(),
            RouteUrl.EXERCISES: (context) => const ExercisesScreen(),
            RouteUrl.GAME_SETUP: (context) => const GameSetupScreen(),
            RouteUrl.SETTINGS: (context) => const SettingsScreen(),
          },
        ));
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
