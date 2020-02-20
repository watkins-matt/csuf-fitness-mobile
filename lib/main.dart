import 'package:flutter/material.dart';
import 'pages/calorie_tracker_page.dart';
import 'package:flutter/foundation.dart' as Foundation;

void main() => runApp(FitnessApp());

class FitnessApp extends StatelessWidget {
  static bool debugMode = Foundation.kDebugMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Health & Fitness',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalorieTrackerPage(title: 'My Health & Fitness'),
    );
  }
}
