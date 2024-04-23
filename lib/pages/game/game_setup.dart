import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jouks_app/domain/game_options.dart';
import 'package:jouks_app/pages/game/game_playground.dart';
import 'package:jouks_app/widgets/game/player/player_add_sheet.dart';

class GameSetupScreen extends StatefulWidget {
  const GameSetupScreen({super.key});

  @override
  State<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends State<GameSetupScreen> {
  GameOptions gameOptions = GameOptions();

  startGameClicked() {
    if (gameOptions.players.isEmpty) {
      Fluttertoast.showToast(
          msg: "Atleast 1 player is required to start a game!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GamePlaygroundScreen(
            gameOptions: gameOptions,
          ),
        ),
      );
    }
  }

  addPlayerClicked() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PlayerAddSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text("Options", style: Theme.of(context).textTheme.displaySmall),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Players",
                        style: Theme.of(context).textTheme.titleLarge),
                    ElevatedButton(
                        onPressed: addPlayerClicked, child: Text("Add player"))
                  ],
                ),
                Column(
                  children: [
                    ...gameOptions.players
                        .map((player) => Row(
                              children: [
                                Container(
                                  height: 64,
                                  width: 64,
                                  decoration:
                                      BoxDecoration(color: Colors.purple),
                                ),
                                SizedBox(width: 20),
                                Text(player.name)
                              ],
                            ))
                        .toList()
                  ],
                )
              ]),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: startGameClicked, child: Text("Start game")),
            ],
          )),
    );
  }
}
