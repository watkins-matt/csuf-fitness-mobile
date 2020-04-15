/*import 'dart:html';*/

import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*import "about_us.dart";
import "help_center.dart";*/

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();

  static void push(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(body: EditProfile());
      },
    ));
  }
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController controller = TextEditingController();
  static const int defaultSetAge = 0;
  static const double defaultSetHeight = 0;
  static const double defaultSetWeight = 0;
  static const double defaultBMI = 0;


  bool metric;
  int age;
  double height;
  double weight;
  double bmi;

  String heightMeasure;
  String weightMeasure;

  @override
  void initState() {
    updatePreferences().whenComplete(() {});
    super.initState();
  }

  Future<void> updatePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      metric = prefs.getBool('metric');
      age = prefs.get("age") ?? defaultSetAge;
      height = prefs.get("height") ?? defaultSetHeight;
      weight = prefs.get("weight") ?? defaultSetWeight;
      bmi = prefs.get("BMI") ?? defaultBMI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: _buildBody()
    );
  }

  Widget _buildBody() {
    if(metric == false){
      heightMeasure = "(in)";
      weightMeasure = "(lbs)";
    } else {
      heightMeasure = "(cm)";
      weightMeasure = "(kg)";
    }
    return SettingsList(
      sections: [
        SettingsSection(
          tiles: [
            SettingsTile(
              title: 'Age',
              subtitle: age.toString(),
              onTap: _showAgeEntryDialog,
            ),
            SettingsTile(
              title: 'Height $heightMeasure',
              subtitle: height.toString(),
              onTap: _showHeightEntryDialog,
            ),
            SettingsTile(
              title: 'Weight $weightMeasure',
              subtitle: weight.toString(),
              onTap: _showWeightEntryDialog,
            ),
            SettingsTile(
              title: 'Body Mass Index',
              subtitle: bmi.toString(),
            )
          ],
        ),
      ],
    );
  }

  Future<void> _onAgeEntryOkButtonPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      age = int.parse(controller.text);
      prefs.setInt('age', age);
    });

    Navigator.pop(context);
  }

    Future<void> _onHeightEntryOkButtonPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      height = double.parse(controller.text);
      prefs.setDouble('height', height);
    });

    Navigator.pop(context);
    bodyMassIndex();
  }

      Future<void> _onWeightEntryOkButtonPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      weight = double.parse(controller.text);
      prefs.setDouble('weight', weight);
    });

    Navigator.pop(context);
    bodyMassIndex();
  }

  void _showAgeEntryDialog() async {
    controller = TextEditingController();

    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          autofocus: true,
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: false),
          controller: controller,
          decoration: InputDecoration(hintText: "Age"),
        ),
        actions: <Widget>[
          FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text("OK"), onPressed: _onAgeEntryOkButtonPressed),
        ],
      ),
    );
  }

  void _showHeightEntryDialog() async {
    controller = TextEditingController();

    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          autofocus: true,
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: false),
          controller: controller,
          decoration: InputDecoration(hintText: "Height"),
        ),
        actions: <Widget>[
          FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text("OK"), onPressed: _onHeightEntryOkButtonPressed),
        ],
      ),
    );
  }

  void _showWeightEntryDialog() async {
    controller = TextEditingController();

    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          autofocus: true,
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: false),
          controller: controller,
          decoration: InputDecoration(hintText: "Weight"),
        ),
        actions: <Widget>[
          FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text("OK"), onPressed: _onWeightEntryOkButtonPressed),
        ],
      ),
    );
  }

    void bodyMassIndex() async {
    if (height== defaultSetHeight || weight == defaultSetWeight) {
      bmi = defaultBMI;
    } else {
      bmi = (703 * weight) /(height * height);
      bmi = num.parse(bmi.toStringAsFixed(1));
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble('BMI', bmi);
  }
}