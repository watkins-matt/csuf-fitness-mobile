import 'package:flutter/material.dart';
import 'calorie_tracker_page.dart';

void main() => runApp(FitnessApp());

class FitnessApp extends StatelessWidget {
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
