class ExerciseModel {
  String name;
  String primary;
  List<String> secondary;

  ExerciseModel(this.name, this.primary, this.secondary);

  ExerciseModel createExercise() {
    ExerciseModel dbBenchPress = ExerciseModel(
      "Dumbbell Bench Press",
      "Chest",
      ["Triceps", "Shoulders"],
    );

    return dbBenchPress;
  }
}


  // Array<ExerciseModel> createList() {
  //   return [];
  // }

  // ExerciseModel dbBenchPress = ExerciseModel(
  //   "Dumbbell Bench Press",
  //   "Chest",
  //   ["Triceps", "Shoulders"],
  // );
  // ExerciseModel inclineDbBenchPress = ExerciseModel(
  //   "Incline Dumbbell Bench Press",
  //   "Chest",
  //   ["Triceps", "Shoulders"],
  // );
  // ExerciseModel dbPullover = ExerciseModel(
  //   "Dumbbell Pullover",
  //   "Chest",
  //   ["Lats"],
  // );
  // ExerciseModel dbFlyes = ExerciseModel(
  //   "Dumbbell Flyes",
  //   "Chest",
  //   ["Shoulders", "Triceps"],
  // );
  // ExerciseModel declineDbBenchPress = ExerciseModel(
  //   "Decline Dumbell Bench Press",
  //   "Chest",
  //   ["Triceps", "Shoulders"],
  // );
  // ExerciseModel standingDbCurl = ExerciseModel(
  //   "Standing Dumbbell Curl",
  //   "Biceps",
  //   [],
  // );
  // ExerciseModel seatedHammerCurl = ExerciseModel(
  //   "Seated Hammer Curl",
  //   "Bicep",
  //   ["Forearms"],
  // );
  // ExerciseModel preacherCurls = ExerciseModel(
  //   "Preacher Curls",
  //   "Biceps",
  //   ["secondary"],
  // );
  // ExerciseModel overhandBarbellCurl = ExerciseModel(
  //   "Overhand Barbell Curl",
  //   "Bicep",
  //   ["Forearms"],
  // );
  // ExerciseModel seatedCableRow = ExerciseModel(
  //   "Seated Cable Row",
  //   "Upper Back",
  //   ["Biceps", "Lats", "Shoulders"],
  // );
  // ExerciseModel bentOverRow = ExerciseModel(
  //   "Bent Over Row",
  //   "Upper Back",
  //   ["Abs", "Biceps", "Lats", "Lower Back", "Shoulders"],
  // );

