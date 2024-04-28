import 'package:flutter/material.dart';
import 'package:jouks_app/domain/player.dart';

class PlayerProvider extends ChangeNotifier {
  final List<Player> players = [];

  void add(Player item) {
    players.add(item);
    notifyListeners();
  }

  void removeAll() {
    players.clear();
    notifyListeners();
  }
}
