import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jouks_app/domain/player.dart';
import 'package:jouks_app/prodivers/player_provider.dart';
import 'package:provider/provider.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({super.key, required this.playerSelected});

  final Function playerSelected;

  playerRow(Player player) => Slidable(
        startActionPane: ActionPane(
          key: UniqueKey(),
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (_) => {},
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              // label: 'Delete',
            ),
            SlidableAction(
              onPressed: (_) => {playerSelected(player)},
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.add,
              // label: 'Add',
            ),
            SlidableAction(
              onPressed: (_) => {},
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              // label: 'Edit',
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (contextFromLayoutBuilder, constraints) {
            return GestureDetector(
              child: ListTile(
                  title: Text(player.name)), // <--- your list item in here
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

  @override
  Widget build(BuildContext context) {
    if (Provider.of<PlayerProvider>(context).players.isEmpty) {
      return Text("0 players");
    }

    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SingleChildScrollView(
            child: Consumer<PlayerProvider>(builder: (_, prov, __) {
          return Column(
              children: [...prov.players.map((player) => playerRow(player))]);
        })),
      ),
    ));
  }
}
