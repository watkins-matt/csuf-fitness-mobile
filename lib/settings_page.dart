import 'package:flutter/material.dart';
import 'calorie_goal_input_widget.dart';
void settings(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
}
class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}): super(key: key);
  final String title;
  @override 
  _SettingPageState createState() => _SettingPageState();
}
class _SettingPageState extends State<SettingsPage>{

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Set daily calorie goals"),
      ),
      body: _buildSettingPage(),
    );
  }
  Widget _buildSettingPage() {
    return Center(
      child: Column(
        children: <Widget>[
          InputDailyCalorieGoalWidget(),
          //start addings the functions to make the the page
        ],
      ),
    );
  }
}
