import 'package:flutter/material.dart';
import 'pages/food_log_page.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'api_key.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FitnessApp());
}

class FitnessApp extends StatelessWidget {
  static bool debugMode = Foundation.kDebugMode;

  FitnessApp() {
    _init();
  }

  Future _init() async {
    await APIKey.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Health & Fitness',
      theme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      home: FoodLogPage(title: 'My Health & Fitness'),
    );
  }
}
