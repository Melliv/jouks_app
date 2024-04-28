import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jouks_app/domain/exercise.dart';
import 'package:jouks_app/domain/game_options.dart';
import 'package:jouks_app/widgets/exercise/exercise_card.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

const TextStyle kTitleTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

class GamePlaygroundScreen extends StatefulWidget {
  const GamePlaygroundScreen({super.key, required this.gameOptions});

  final GameOptions gameOptions;

  @override
  createState() => _GamePlaygroundState();
}

class _GamePlaygroundState extends State<GamePlaygroundScreen> {
  List<Exercise> exercises = [];
  MatchEngine? _matchEngine;
  List<SwipeItem> _swipeItems = <SwipeItem>[];

  @override
  void initState() {
    initExercises();

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  Future<void> initExercises() async {
    String exercisesJson = await rootBundle.loadString('assets/exercises.json');
    exercises = (json.decode(exercisesJson) as List<dynamic>)
        .map((val) => Exercise.fromJson(val))
        .toList();

    exercises = exercises + exercises + exercises + exercises + exercises;

    setState(() {});

    for (int i = 0; i < exercises.length; i++) {
      _swipeItems.add(SwipeItem(
          content: ExerciseCard(exercise: exercises[i]),
          likeAction: () {
            print("Done");
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Failed ${exercises[i].title.en}"),
            //   duration: Duration(milliseconds: 500),
            // ));
          },
          nopeAction: () {
            print("Fail");
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Done}"),
            //   duration: Duration(milliseconds: 500),
            // ));
          },
          superlikeAction: () {
            print("Replace card");
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Something"),
            //   duration: Duration(milliseconds: 500),
            // ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Turn: ${widget.gameOptions.players[0].name}")),
      body: Container(
          child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height - kToolbarHeight - 72,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: SwipeCards(
              matchEngine: _matchEngine!,
              itemBuilder: (BuildContext context, int index) {
                return _swipeItems[index].content;
              },
              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Stack Finished"),
                  duration: Duration(milliseconds: 500),
                ));
              },
              itemChanged: (SwipeItem item, int index) {
                // print("item: ${item.content.text}, index: $index");
              },
              leftSwipeAllowed: true,
              rightSwipeAllowed: true,
              upSwipeAllowed: true,
              fillSpace: true),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _matchEngine!.currentItem?.nope();
                  },
                  child: Row(children: [Icon(Icons.clear), Text("Fail")])),
              ElevatedButton(
                  onPressed: () {
                    _matchEngine!.currentItem?.superLike();
                  },
                  child: Row(children: [Icon(Icons.loop), Text("Replace")])),
              ElevatedButton(
                  onPressed: () {
                    _matchEngine!.currentItem?.like();
                  },
                  child: Row(children: [Icon(Icons.check), Text("Done")]))
            ],
          ),
        )
      ])),
    );
  }
}
