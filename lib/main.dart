import 'package:flutter/material.dart';
import 'package:jouks_app/pages/exercise/exercises.dart';
import 'package:jouks_app/utils/route_url.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '52 Card Deck',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ExercisesScreen(),
      routes: {
        RouteUrl.EXERCISES: (context) => const ExercisesScreen(),
      },
    );
  }
}
