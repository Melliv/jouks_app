import 'package:jouks_app/domain/sub_domains/language.dart';
import 'package:jouks_app/utils/enums/muscle_group.dart';

class Exercise {
  String id = "";
  int nr = 99;
  MuscleGroup muscleGroup = MuscleGroup.universal;
  Language title = Language();
  Language description = Language();
  List<String> imageNames = [];

  Exercise();

  factory Exercise.fromJson(Map<String, dynamic> json) {
    Exercise exercise = Exercise();
    exercise.nr = json["nr"];
    exercise.muscleGroup = MuscleGroup.values.byName(json["muscleGroup"]);
    exercise.title = Language.fromJson(json["title"]);
    exercise.description = Language.fromJson(json["description"]);
    exercise.imageNames =
        (json['imageNames'] as List).map((item) => item as String).toList();

    return exercise;
  }

  getImagePath() {
    return "assets/images/exercises/${imageNames[0]}.png";
  }

  getSideImagePath() {
    return "assets/images/exercises/${imageNames[1]}.png";
  }
}
