import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jouks_app/domain/game_options.dart';
import 'package:jouks_app/domain/player.dart';
import 'package:jouks_app/pages/game/game_playground.dart';
import 'package:jouks_app/widgets/game/player/player_add_sheet.dart';
import 'package:jouks_app/widgets/game/player/players_list.dart';
import 'package:collection/collection.dart';

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
    ).then((player) => {
          print("player:" + (player as Player).name),
          gameOptions.players.add(player),
          setState(() {})
        });
  }

  @override
  Widget build(BuildContext context) {
    playerRow(Player player) => Slidable(
          startActionPane: ActionPane(
            key: const ValueKey(0),
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (_) =>
                    {gameOptions.players.remove(player), setState(() {})},
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.remove,
              ),
              SlidableAction(
                onPressed: (_) => {},
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.white,
                icon: Icons.edit,
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (contextFromLayoutBuilder, constraints) {
              return GestureDetector(
                child: ListTile(title: Text(player.name)),
                onTap: () {
                  final slidable = Slidable.of(contextFromLayoutBuilder);
                  if (slidable != null) {
                    final isClosed =
                        slidable.actionPaneType.value == ActionPaneType.none;
                    if (isClosed) {
                      slidable.openStartActionPane();
                    } else {
                      slidable.close();
                    }
                  }
                },
              );
            },
          ),
        );

    Widget playersWidget = gameOptions.players.isEmpty
        ? Text("0 Players added")
        : Column(
            children: [
              ...gameOptions.players
                  .mapIndexed((index, player) => Row(children: [
                        Container(
                          width: 20,
                          child: Text((index + 1).toString() + "."),
                        ),
                        Container(width: 260, child: playerRow(player))
                      ]))
            ],
          );
    return Scaffold(
      appBar: AppBar(title: Text("Game options")),
      body: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            children: [
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Players",
                        style: Theme.of(context).textTheme.titleLarge),
                    ElevatedButton(
                        onPressed: addPlayerClicked,
                        child: const Text("Add player"))
                  ],
                ),
                playersWidget
              ]),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: startGameClicked, child: const Text("Start game")),
            ],
          )),
    );
  }
}
