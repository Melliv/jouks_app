import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jouks_app/domain/player.dart';
import 'package:jouks_app/prodivers/player_provider.dart';
import 'package:jouks_app/utils/enums/gender.dart';
import 'package:jouks_app/utils/enums/level.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PlayerCreateSheet extends StatefulWidget {
  const PlayerCreateSheet({super.key});

  @override
  State<PlayerCreateSheet> createState() => _PlayerCreateSheetState();
}

class _PlayerCreateSheetState extends State<PlayerCreateSheet> {
  Player player = Player();

  createPlayer() {
    if (player.name.isEmpty) {
      Fluttertoast.showToast(
          msg: "Player name is required!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      Provider.of<PlayerProvider>(context, listen: false).add(player);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget nameInput = TextFormField(
      initialValue: player.name,
      onChanged: (value) => player.name = value,
      decoration: const InputDecoration(label: Text("Name")),
    );

    Widget genderSwitch = ToggleSwitch(
      initialLabelIndex: player.gender == Gender.male ? 0 : 1,
      minWidth: double.maxFinite,
      cornerRadius: 10.0,
      totalSwitches: 2,
      labels: const ['Male', 'Female'],
      icons: const [Icons.male, Icons.female],
      activeBgColors: const [
        [Colors.blue, Colors.black],
        [Colors.black, Colors.pink]
      ],
      onToggle: (index) {
        player.gender = index == 0 ? Gender.male : Gender.female;
      },
    );
    Widget levelSwitch = ToggleSwitch(
      initialLabelIndex: Level.values.indexOf(player.level),
      minWidth: double.maxFinite,
      labels: [...Level.values.map((level) => level.toString())],
      activeBgColors: const [
        [Colors.lightGreen],
        [Colors.orange],
        [Colors.red],
        [Colors.black],
      ],
      onToggle: (index) {
        player.level = Level.values.elementAt(index!);
      },
    );

    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 340,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Create Player",
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    nameInput,
                    const SizedBox(height: 8),
                    const Text("Gender"),
                    genderSwitch,
                    const SizedBox(height: 8),
                    const Text("Level"),
                    levelSwitch,
                    const SizedBox(height: 20),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: createPlayer,
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: const Text("Create")))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
