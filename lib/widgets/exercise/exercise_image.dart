import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jouks_app/domain/exercise.dart';

class ExerciseImage extends StatefulWidget {
  const ExerciseImage({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<ExerciseImage> createState() => _ExerciseImageState();
}

class _ExerciseImageState extends State<ExerciseImage> {
  late String _image;
  late Timer _timer;
  int imgIndex = 0;

  @override
  void initState() {
    setState(() {
      _image = widget.exercise.getImagePath();
    });

    _timer = Timer.periodic(new Duration(seconds: 5), (Timer t) {
      imgIndex++;
      if (imgIndex % 2 == 0) {
        _image = widget.exercise.getImagePath();
      } else {
        _image = widget.exercise.getSideImagePath();
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(_image), alignment: Alignment.bottomCenter)));
  }
}
