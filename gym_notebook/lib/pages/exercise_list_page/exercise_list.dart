import 'package:flutter/material.dart';
import '../../models/exercise_model.dart';

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({
    super.key,
    this.exercises,
  });

  final List<ExerciseModel>? exercises;

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  ExerciseModel dbBenchPress = ExerciseModel(
    "Dumbbell Bench Press",
    "Chest",
    ["Triceps", "Shoulders"],
  );
  ExerciseModel inclineDbBenchPress = ExerciseModel(
    "Incline Dumbbell Bench Press",
    "Chest",
    ["Triceps", "Shoulders"],
  );
  ExerciseModel dbPullover = ExerciseModel(
    "Dumbbell Pullover",
    "Chest",
    ["Lats"],
  );
  ExerciseModel dbFlyes = ExerciseModel(
    "Dumbbell Flyes",
    "Chest",
    ["Shoulders", "Triceps"],
  );
  ExerciseModel declineDbBenchPress = ExerciseModel(
    "Decline Dumbell Bench Press",
    "Chest",
    ["Triceps", "Shoulders"],
  );
  ExerciseModel standingDbCurl = ExerciseModel(
    "Standing Dumbbell Curl",
    "Biceps",
    [],
  );
  ExerciseModel seatedHammerCurl = ExerciseModel(
    "Seated Hammer Curl",
    "Bicep",
    ["Forearms"],
  );
  ExerciseModel preacherCurls = ExerciseModel(
    "Preacher Curls",
    "Biceps",
    ["secondary"],
  );
  ExerciseModel overhandBarbellCurl = ExerciseModel(
    "Overhand Barbell Curl",
    "Bicep",
    ["Forearms"],
  );
  ExerciseModel seatedCableRow = ExerciseModel(
    "Seated Cable Row",
    "Upper Back",
    ["Biceps", "Lats", "Shoulders"],
  );
  ExerciseModel bentOverRow = ExerciseModel(
    "Bent Over Row",
    "Upper Back",
    ["Abs", "Biceps", "Lats", "Lower Back", "Shoulders"],
  );

  List<ExerciseModel> exercises = [];

  @override
  void initState() {
    super.initState();
    exercises.add(dbBenchPress);
    exercises.add(inclineDbBenchPress);
    exercises.add(dbPullover);
    exercises.add(dbFlyes);
    exercises.add(declineDbBenchPress);
    exercises.add(standingDbCurl);
    exercises.add(seatedHammerCurl);
    exercises.add(preacherCurls);
    exercises.add(overhandBarbellCurl);
    exercises.add(seatedCableRow);
    exercises.add(bentOverRow);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.blue,
                title: const Text("Exercise List"),
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                ),
                // actions: [
                //   ElevatedButton(
                //       onPressed: () => print(exercises[1].primary),
                //       child: Icon(Icons.access_time_filled_outlined))
                // ],
              ),
              Expanded(
                child: Exercises(
                  exercises: exercises,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Exercises extends StatelessWidget {
  const Exercises({
    super.key,
    required this.exercises,
  });

  final List<ExerciseModel> exercises;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseTile(
          exercise: exercises[index],
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    super.key,
    required this.exercise,
  });

  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: Colors.grey,
        titleAlignment: ListTileTitleAlignment.center,
        title: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            exercise.name,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () => Navigator.pop(context, exercise),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
