import 'package:flutter/material.dart';
// import '../widgets/calorie_goal_input_widget.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../food_log.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

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
  TextEditingController controller = TextEditingController();
  int maxCalories = 0;

  @override
  void initState() {
    updatePreferences().whenComplete(() {});
    super.initState();
  }

  Future<void> updatePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      if (!prefs.containsKey('maxCalories')) {
        prefs.setInt('maxCalories', 2000);
      }

      maxCalories = prefs.getInt('maxCalories');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'Calorie Tracking',
          tiles: [
            SettingsTile(
              title: 'Calorie Goal',
              subtitle: maxCalories.toString(),
              onTap: _showCalorieEntryDialog,
            )
          ],
        ),
      ],
    );
  }

  Future<void> _onCalorieEntryOkButtonPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      maxCalories = int.parse(controller.text);
      prefs.setInt('maxCalories', maxCalories);
      FoodLog().maxCalories = maxCalories;
    });

    Navigator.pop(context);
  }

  void _showCalorieEntryDialog() async {
    controller = TextEditingController();

    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          autofocus: true,
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: false),
          controller: controller,
          decoration: InputDecoration(hintText: "Amount"),
        ),
        actions: <Widget>[
          FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text("OK"), onPressed: _onCalorieEntryOkButtonPressed),
        ],
      ),
    );
  }
}
