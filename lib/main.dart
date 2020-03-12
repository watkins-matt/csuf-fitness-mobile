import 'package:flutter/material.dart';
import 'pages/food_log_page.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_key.dart';
import 'package:flutter/services.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Default to portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(FitnessApp());
  });
}

class FitnessApp extends StatelessWidget {
  static bool debugMode = Foundation.kDebugMode;
  static bool darkMode = false;

  FitnessApp() {
    _init();
  }

  Future _init() async {
    await APIKey.init();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    darkMode = prefs.getBool('darkMode');
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
      home: MainBottomNavBarController(),
    );
  }
}
