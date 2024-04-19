import 'package:flutter/material.dart';
import 'package:jouks_app/domain/exercise.dart';
import 'package:jouks_app/utils/enums/muscle_group.dart';

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;

  const ExerciseCard({required this.exercise, super.key});

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(widget.exercise.title.en,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                )),
          ),
          Container(
            height: 260,
            decoration: BoxDecoration(
                color: widget.exercise.muscleGroup.getColor(),
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(widget.exercise.getImagePath()),
                    alignment: Alignment.bottomCenter)),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.exercise.muscleGroup.getColor(),
                borderRadius: BorderRadius.circular(16)),
            child: Text(
              widget.exercise.description.en,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
