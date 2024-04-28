import 'package:flutter/material.dart';
import 'package:jouks_app/domain/player.dart';
import 'package:jouks_app/prodivers/player_provider.dart';
import 'package:jouks_app/widgets/game/player/player_create_sheet.dart';
import 'package:jouks_app/widgets/game/player/players_list.dart';
import 'package:provider/provider.dart';

class PlayerAddSheet extends StatelessWidget {
  const PlayerAddSheet({super.key});

  @override
  Widget build(BuildContext context) {
    createPlayerClicked() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return PlayerCreateSheet();
        },
      );
    }

    playerSelected(Player player) {
      Navigator.pop(context, player);
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text("Create player"),
                )
              ]),
              const SizedBox(height: 16),
              PlayersList(playerSelected: playerSelected)
            ],
          ),
        ),
      ),
    );
  }
}
