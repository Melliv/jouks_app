import 'package:flutter/material.dart';

enum MuscleGroup {
  upperBody,
  abs,
  legs,
  universal,
}

extension MuscleGroupExtensions on MuscleGroup {
  Color getColor() {
    switch (this) {
      case MuscleGroup.upperBody:
        return Colors.green;
      case MuscleGroup.abs:
        return Colors.blue;
      case MuscleGroup.legs:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
