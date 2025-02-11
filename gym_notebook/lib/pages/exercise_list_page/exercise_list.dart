import 'package:flutter/material.dart';
import '../../models/exercise_model.dart';

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({
    super.key,
    this.exercises,
    this.exerciseFilter,
  });

  final List<ExerciseModel>? exercises;
  final List<String>? exerciseFilter;

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  List<ExerciseModel> exercises = [
    ExerciseModel(
      "Dumbbell Bench Press",
      "Chest",
      ["Triceps", "Shoulders"],
    ),
    ExerciseModel(
      "Incline Dumbbell Bench Press",
      "Chest",
      ["Triceps", "Shoulders"],
    ),
    ExerciseModel(
      "Dumbbell Pullover",
      "Chest",
      ["Lats"],
    ),
    ExerciseModel(
      "Dumbbell Flyes",
      "Chest",
      ["Shoulders", "Triceps"],
    ),
    ExerciseModel(
      "Decline Dumbell Bench Press",
      "Chest",
      ["Triceps", "Shoulders"],
    ),
    ExerciseModel(
      "Standing Dumbbell Curl",
      "Biceps",
      [],
    ),
    ExerciseModel(
      "Seated Hammer Curl",
      "Biceps",
      ["Forearms"],
    ),
    ExerciseModel(
      "Preacher Curls",
      "Biceps",
      ["secondary"],
    ),
    ExerciseModel(
      "Overhand Barbell Curl",
      "Biceps",
      ["Forearms"],
    ),
    ExerciseModel(
      "Seated Cable Row",
      "Upper Back",
      ["Biceps", "Lats", "Shoulders"],
    ),
    ExerciseModel(
      "Bent Over Row",
      "Upper Back",
      ["Abs", "Biceps", "Lats", "Lower Back", "Shoulders"],
    ),
  ];

  List<ExerciseModel> exerciseList = [];

  List<String> exercisesFilter = [];

  void filterExerciseList(key) {
    setState(
      () {
        if (key == "All") {
          exerciseList = [];
          exerciseList.addAll(exercises);
        } else {
          exerciseList = [];
          for (var i in exercises) {
            if (i.primary == key) {
              exerciseList.add(i);
            }
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    filterExerciseList("All");
    exercisesFilter.add("All");
    exercisesFilter.add("Chest");
    exercisesFilter.add("Biceps");
    exercisesFilter.add("Upper Back");
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
                actions: [
                  DropdownButton(
                      items: exercisesFilter.map((String exercise) {
                        return DropdownMenuItem(
                          value: exercise,
                          child: Text(
                            exercise,
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        filterExerciseList(v);
                      }),
                ],
              ),
              Expanded(
                child: Exercises(
                  exercises: exerciseList,
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

class ExerciseFilter extends StatefulWidget {
  const ExerciseFilter({
    super.key,
    required this.exerciseList,
  });

  final List exerciseList;

  @override
  State<ExerciseFilter> createState() => _ExerciseFilterState();
}

class _ExerciseFilterState extends State<ExerciseFilter> {
  List<String> exercisesFilter = [
    "All",
    "Chest",
    "Biceps",
    "Upper Back",
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: "All",
      dropdownMenuEntries: exercisesFilter.map((String exercise) {
        return DropdownMenuEntry(label: exercise, value: exercise);
      }).toList(),
    );
  }
}
