import 'package:flutter/material.dart';
import 'package:jouks_app/pages/exercise/exercises.dart';
import 'package:jouks_app/pages/game/game_setup.dart';
import 'package:jouks_app/pages/main_menu/main_menu.dart';
import 'package:jouks_app/utils/route_url.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jouks card game',
      theme: ThemeData(
          primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.red,
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))))),
      home: const MainMenuScreen(),
      routes: {
        RouteUrl.MAIN_MENU: (context) => const MainMenuScreen(),
        RouteUrl.EXERCISES: (context) => const ExercisesScreen(),
        RouteUrl.GAME_SETUP: (context) => const GameSetupScreen(),
      },
    );
  }
}
