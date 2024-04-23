import 'package:flutter/material.dart';
import 'package:jouks_app/widgets/game/player/player_body_create_sheet.dart';

class PlayerCreateSheet extends StatelessWidget {
  const PlayerCreateSheet({super.key});

  @override
  Widget build(BuildContext context) {
    createPlayerBodyClicked() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return PlayerBodyCreateSheet();
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
                  onPressed: createPlayerBodyClicked,
                  child: Text("Create body"),
                )
              ]),
              const SizedBox(height: 16),
              Column(
                children: [Text("field name"), Text("body")],
              )
            ],
          ),
        ),
      ),
    );
  }
}
