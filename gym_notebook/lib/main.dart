import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Page Imports
import './pages/workout_page/workout.dart';
import 'package:word_pair/pages/profile_page/profile.dart';

// Widget Imports

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // var current = WordPair.random();

  // void getNext() {
  //   current = WordPair.random();
  //   notifyListeners();
  // }

  // var favorites = <WordPair>[];

  // void toggleFavorites() {
  //   if (favorites.contains(current)) {
  //     favorites.remove(current);
  //   } else {
  //     favorites.add(current);
  //   }

  //   notifyListeners();
  // }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Index of bottom nav bar.  Used to select the destination we are viewing.
  int index = 0;

  @override
  Widget build(BuildContext context) {
    // Below comments are for page navigation.  Does not keep state between destination changes.

    // Widget page;

    // switch (index) {
    //   case 0:
    //     page = Placeholder();
    //   case 1:
    //     page = WorkoutPage();
    //   case 2:
    //     page = ProfilePage();
    //   default:
    //     throw UnimplementedError('no widget for $index');
    // }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text("My Gym Notebook"),
          actions: [
            IconButton(
              onPressed: () => print("Hello World"),
              icon: Icon(Icons.info_outlined),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            // VerticalDivider(),
            NavigationDestination(
              icon: Icon(Icons.fitness_center),
              label: "Workouts",
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle),
              label: "Profile",
            ),
          ],
          selectedIndex: index,
          onDestinationSelected: (value) {
            setState(
              () => index = value,
            );
          },
        ),

        // Refactor at some point.
        // The Indexed Stack is used to keep state of each page while changing navigation destinations
        // It loads all destinations on app startup, which isn't necessary.
        // Okay for now, but needs update.
        body: IndexedStack(
          index: index,
          children: <Widget>[
            Placeholder(),
            WorkoutPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
