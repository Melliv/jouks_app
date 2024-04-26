enum Level {
  low(0.75),
  normal(1.0),
  high(1.25),
  beast(2.0);

  const Level(this.value);
  final num value;

  @override
  String toString() {
    switch (this) {
      case Level.low:
        return "Low";
      case Level.normal:
        return "Normal";
      case Level.high:
        return "High";
      case Level.beast:
        return "Beast";
    }
  }
}

// extension LevelExtensions on Level {
//   double ratio() {
//     switch (this) {
//       case Level.low:
//         return 0.75;
//       case Level.normal:
//         return 1.0;
//       case Level.high:
//         return 1.25;
//       case Level.beast:
//         return 2.00;
//     }
//   }
// }
