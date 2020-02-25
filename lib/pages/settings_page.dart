import 'package:flutter/material.dart';
import '../widgets/calorie_goal_input_widget.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SettingPageState createState() => _SettingPageState();

  static void push(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(body: SettingsPage());
      },
    ));
  }
}

class _SettingPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: _buildSettingPage(),
    );
  }

  Widget _buildSettingPage() {
    return Center(
      child: Column(
        children: <Widget>[
          InputDailyCalorieGoalWidget(),
          //TODO: Start adding more settings
        ],
      ),
    );
  }
}
