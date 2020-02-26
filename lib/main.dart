import 'package:flutter/material.dart';
import 'pages/food_log_page.dart';
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
      home: FoodLogPage(title: 'My Health & Fitness'),
    );
  }
}
