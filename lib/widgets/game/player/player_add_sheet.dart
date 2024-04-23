import 'package:flutter/material.dart';
import 'package:jouks_app/widgets/game/player/player_create_sheet.dart';

class PlayerAddSheet extends StatelessWidget {
  const PlayerAddSheet({super.key});

  @override
  Widget build(BuildContext context) {
    createPlayerClicked() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return PlayerCreateSheet();
        },
      );
    }

    return Padding(
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Players",
                    style: Theme.of(context).textTheme.headlineSmall),
                ElevatedButton(
                  onPressed: createPlayerClicked,
                  child: Text("Create player"),
                )
              ]),
              const SizedBox(height: 16),
              Column(
                children: [Text("player1"), Text("Player2")],
              )
            ],
          ),
        ),
      ),
    );
  }
}
