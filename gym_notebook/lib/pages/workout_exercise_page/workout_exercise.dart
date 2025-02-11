import 'package:flutter/material.dart';
import 'package:word_pair/models/workout_exercise_model.dart';

const List<int> list = <int>[1, 2, 3, 4, 5, 6];

class WorkoutExercisePage extends StatefulWidget {
  const WorkoutExercisePage({
    super.key,
    required this.exercise,
  });

  final WorkoutExerciseModel exercise;

  @override
  State<WorkoutExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<WorkoutExercisePage> {
  final myController = TextEditingController();
  late WorkoutExerciseModel exercise;

  @override
  void initState() {
    super.initState();
    exercise = widget.exercise;
    // myController.addListener(_convertTextReps);
  }

  // @override
  // void dispose() {
  //   myController.dispose();
  //   super.dispose();
  // }

  // void _convertTextReps() {
  //   final newReps = myController.text;
  //   if (newReps.isNotEmpty) {
  //     _adjustReps(int.parse(newReps));
  //   }
  // }

  void _adjustReps(newReps) {
    setState(
      () {
        if (newReps < 0) {
          return;
        }
        exercise.reps = newReps;
      },
    );
  }

  void _adjustWeight(newWeight) {
    setState(
      () {
        if (newWeight < 0) {
          return;
        }
        exercise.weight = newWeight;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.transparent,
                    ),
                    iconSize: 30,
                  ),
                  onPressed: () => Navigator.pop(context, [exercise, 0]),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            textAlign: TextAlign.center,
            exercise.exercise.name,
            style: TextStyle(fontSize: 60),
          ),
          SizedBox(
            height: 50,
          ),
          Divider(
            thickness: 4,
            indent: 20,
            endIndent: 20,
            color: Colors.grey[800],
          ),
          RepsRow(
            reps: exercise.reps,
            adjustReps: _adjustReps,
            myController: myController,
          ),
          SizedBox(
            height: 50,
          ),
          WeightRow(
            weight: exercise.weight,
            adjustWeight: _adjustWeight,
          ),
          SizedBox(
            height: 50,
          ),
          DeleteExercise()
        ],
      ),
    );
  }
}

class DeleteExercise extends StatelessWidget {
  const DeleteExercise({
    super.key,
  });

  Future _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete Exercise?",
            textAlign: TextAlign.center,
          ),
          content: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                    text: 'By clicking "Confirm", you acknowledge that you '
                        'would like to delete this exercise from your workout.\n\n'),
                TextSpan(
                  text: 'Note: This action cannot be undone.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // 'By clicking the "Confirm" button, you acknowledge\n'
          //   'that you would like to delete this exercise from your workout.\n\n'
          //   'Note: This action cannot be undone.'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.grey[300],
                    ),
                  ),
                  child: Text(
                    "Cancel",
                  ),
                  onPressed: () => Navigator.of(context).pop([null, 0]),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.grey[400],
                    ),
                  ),
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.red[800]),
                  ),
                  onPressed: () => Navigator.of(context).pop(-1),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red[700]),
              ),
              onPressed: () async {
                var x = await _dialogBuilder(context);
                if (x == -1) {
                  Navigator.pop(context, [null, -1]);
                }
              },
              child: Text(
                "Delete",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RepsRow extends StatelessWidget {
  const RepsRow({
    super.key,
    required this.reps,
    required this.adjustReps,
    required this.myController,
  });

  final int reps;
  final Function adjustReps;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Reps",
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(
            width: 15,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  adjustReps(reps - 1);
                },
                child: Icon(Icons.arrow_back_ios_new_outlined),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  reps.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),

              // Update later with TextInputController.

              // SizedBox(
              //   width: 200,
              //   child: TextField(
              //     onTapOutside: (event) =>
              //         FocusManager.instance.primaryFocus?.unfocus(),
              //     textAlign: TextAlign.center,
              //     decoration: InputDecoration(
              //         border: InputBorder.none,
              //         hintText: "Hello World",
              //         suffixIcon: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             IconButton(
              //                 icon: Icon(Icons.keyboard_arrow_up),
              //                 onPressed: () => adjustReps(reps + 1),
              //                 style: ButtonStyle(
              //                   iconSize: WidgetStatePropertyAll(40),
              //                 )),
              //           ],
              //         ),
              //         prefixIcon: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             IconButton(
              //               onPressed: () => adjustReps(reps - 1),
              //               icon: Icon(Icons.keyboard_arrow_down),
              //               style: ButtonStyle(
              //                 iconSize: WidgetStatePropertyAll(40),
              //               ),
              //             ),
              //           ],
              //         )),
              //     style: TextStyle(fontSize: 40),
              //     keyboardType: TextInputType.number,
              //     controller: myController,
              //   ),
              // ),

              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () => adjustReps(reps + 1),
                child: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeightRow extends StatelessWidget {
  const WeightRow({
    super.key,
    required this.weight,
    required this.adjustWeight,
  });

  final int weight;
  final Function adjustWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Weight",
            style: TextStyle(fontSize: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => adjustWeight(weight - 1),
                onLongPress: () {
                  int offset = weight % 10;
                  if (offset == 0) {
                    adjustWeight(weight - 10);
                  } else {
                    adjustWeight(weight - offset);
                  }
                },
                child: Icon(Icons.arrow_back_ios_new_outlined),
              ),
              SizedBox(
                width: 15,
              ),
              // SizedBox(
              //   width: 100,
              //   child: TextField(
              //     textAlign: TextAlign.center,
              //     onTapOutside: (event) =>
              //         FocusManager.instance.primaryFocus?.unfocus(),
              //     decoration: InputDecoration.collapsed(
              //         border: InputBorder.none, hintText: null),
              //     style: TextStyle(fontSize: 40),
              //     keyboardType: TextInputType.number,
              //     onChanged: (val) => adjustWeight(int.parse(val)),
              //   ),
              // ),
              SizedBox(
                width: 100,
                child: Text(
                  weight.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () => adjustWeight(weight + 1),
                onLongPress: () {
                  int offset = weight % 10;

                  adjustWeight(weight + (10 - offset));
                },
                child: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
