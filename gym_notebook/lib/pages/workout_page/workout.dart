import 'package:flutter/material.dart';
import 'package:word_pair/models/workout_exercise_model.dart';
import '../workout_exercise_page/workout_exercise.dart';
import '../exercise_list_page/exercise_list.dart';

// import 'package:table_calendar/table_calendar.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key, this.exercises});

  final List<WorkoutExerciseModel>? exercises;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<WorkoutExerciseModel> exercises = [];

  // Updates the exercise List
  void _addExercise(exercise) {
    setState(() {
      exercises.add(exercise);
    });
  }

  // Called when adding a new exercise to the current workout.
  void _newExercise(exercise) async {
    // If back button is clicked on the Exercise List page, don't try to add a new item.
    if (exercise != null) {
      // Create a new WorkoutExercise object with the provided exercise.
      WorkoutExerciseModel newEx = WorkoutExerciseModel(exercise, 0, 0);

      // Open the Modal to update the new exercise's reps/weight.
      var x = await _openWorkoutExercise(newEx);

      // Update the exercises list state to include the newly added exercise.
      _addExercise(x);
    }
  }

  // Opens an individual exercise in the list of exercises for the workout.
  // The opened Modal can be used to update the number of reps and weight of the exercise.
  // The function takes in a WorkoutExercise object, containing and exercise, reps, and weight.
  // The function returns a Future object which contains the WorkoutExercise which was passed to it, with updated values for reps/weight.
  // The function is run asynchronously so that the caller can update the state of exercises.
  Future _openWorkoutExercise(exercise) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(
            40,
            20,
          ),
        ),
      ),
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * .9,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.elliptical(
                40,
                20,
              ),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.grey,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: WorkoutExercisePage(
            exercise: exercise,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () => print("Adding Workout"),
                icon: Icon(Icons.add),
                label: Text("Workout"),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  var x = await Navigator.of(context).push(
                    _navigateExerciseList(),
                  );
                  _newExercise(x);
                },
                icon: Icon(Icons.add),
                label: Text("Exercise"),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: Text(
                "Today's Session",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(
                "Primary Muscles: Chest, Triceps",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(
                "Secondary Muscles: ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ExerciseList(
            exercises: exercises,
            openExercise: _openWorkoutExercise,
          ),
        ),
      ],
    );
  }
}

Route _navigateExerciseList() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ExerciseListPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}

class ExerciseList extends StatelessWidget {
  const ExerciseList({
    super.key,
    required this.exercises,
    required this.openExercise,
  });

  final List<WorkoutExerciseModel> exercises;
  final Function openExercise;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseTile(
          exercise: exercises[index],
          openExercise: openExercise,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  const ExerciseTile(
      {super.key, required this.exercise, required this.openExercise});

  final WorkoutExerciseModel exercise;
  final Function openExercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: Colors.grey,
        titleAlignment: ListTileTitleAlignment.center,
        title: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            exercise.exercise.name,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () => openExercise(exercise),
          child: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
