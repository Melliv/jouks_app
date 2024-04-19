import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jouks_app/domain/exercise.dart';
import 'package:jouks_app/utils/enums/muscle_group.dart';
import 'package:jouks_app/widgets/exercise/exercise_card.dart';

const TextStyle kTitleTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  createState() => _ExercisesState();
}

class _ExercisesState extends State<ExercisesScreen> {
  List<Widget> myCards = [];
  List<Widget> myCardsFlip = [];

  Widget _myAnimatedWidget = Container();

  final PageController ctrl = PageController();
  int currentPage = 0;
  bool isFlip = false;

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      int next = ctrl.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    initExercises();
  }

  Future<void> initExercises() async {
    String exercisesJson = await rootBundle.loadString('assets/exercises.json');
    setState(() {
      var exer = (json.decode(exercisesJson) as List<dynamic>)
          .map((val) => Exercise.fromJson(val))
          .toList();
      exer.forEach((exercise) {
        myCards.add(ExerciseCard(exercise: exercise));
        myCardsFlip.add(buildCardSide(exercise));
      });
    });
  }

  Widget _buildStoryPage(List list, int index, bool active, bool value) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 50 : 125;

    return AnimatedContainer(
      key: ValueKey(value),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30, left: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: blur,
              offset: Offset(offset, offset))
        ],
      ),
      child: list[index],
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(1) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: GestureDetector(
        onDoubleTap: () {
          isFlip = !isFlip;
          setState(() {});
        },
        child: Center(
          child: AspectRatio(
            aspectRatio: 0.71428571428,
            child: PageView.builder(
              controller: ctrl,
              itemCount: myCards.length,
              itemBuilder: (context, int currentIdx) {
                bool active = currentIdx == currentPage;
                isFlip
                    ? _myAnimatedWidget =
                        _buildStoryPage(myCardsFlip, currentIdx, active, true)
                    : _myAnimatedWidget =
                        _buildStoryPage(myCards, currentIdx, active, false);
                return AnimatedSwitcher(
                    transitionBuilder: _transitionBuilder,
                    duration: Duration(milliseconds: 500),
                    child: _myAnimatedWidget);
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent[700],
          tooltip: 'Shuffle',
          child: Icon(Icons.shuffle),
          onPressed: () => {shuffle()}),
    );
  }

  void shuffle() {
    setState(() {
      myCards.shuffle();
    });
  }

  Widget buildCardSide(Exercise exercise) {
    return Container(
      padding: EdgeInsets.all(9.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(exercise.title.en,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                )),
          ),
          Container(
            height: 260,
            decoration: BoxDecoration(
                color: exercise.muscleGroup.getColor(),
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(exercise.getSideImagePath()),
                    alignment: Alignment.bottomCenter)),
          ),
          SizedBox(height: 12),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: exercise.muscleGroup.getColor(),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "Level 3 25x",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: exercise.muscleGroup.getColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Level 2 15x",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: exercise.muscleGroup.getColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Level 1 10x",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
