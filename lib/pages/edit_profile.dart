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

    /*if(metric == false) {
      heightMeasure = "(in)";
      weightMeasure = "(lbs)";
    } else 
    heightMeasure = "(cm)";
    weightMeasure = "(kg)";*/
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

  /*Widget _buildUserPage() {
    return Center(
      child: Column(
        children: <Widget>[
           FlatButton(
            child: Text("About"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return Scaffold(body: about_us());
                },
              ));
            },
          ),
          FlatButton(
            child: Text("Help Center"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return Scaffold(body: help_center());
                },
              ));
            },
          )
        ],

        
      ),
    );
  }*/

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


/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  static const String defaultSetUserName = "Enter Username";
  static const String defaultSetAge = "Enter Age";
  static const String defaultSetHeight = "Enter Height";
  static const String defaultSetWeight = "Enter Weight";
  static const String defaultBMI = "";
  // static const String defaultHealth = "";
  String username;
  //static String lastname;
  String age;
  String height;
  String weight;
  String bmi;
  String health;
  // double getBMI;

  _EditProfile() {
    _init();
  }

  final TextEditingController _inputUserNameController =
      TextEditingController();
  /*final TextEditingController _inputLastNameController =
      TextEditingController();*/
  final TextEditingController _inputAgeController = TextEditingController();
  final TextEditingController _inputHeightController = TextEditingController();
  final TextEditingController _inputWeightController = TextEditingController();

  Future _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.get("userName") ?? defaultSetUserName;
      age = prefs.get("userAge") ?? defaultSetAge;
      height = prefs.get("userHeight") ?? defaultSetHeight;
      weight = prefs.get("userWeight") ?? defaultSetWeight;
      bmi = prefs.get("userBMI") ?? defaultBMI;
      // health = prefs.get("userHealth") ?? defaultHealth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          padding: EdgeInsets.all(8),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: TextFormField(
                        controller: _inputUserNameController,
                        decoration: InputDecoration(labelText: username))),
                Expanded(
                    child: FlatButton(
                        child: Text("Set Username"), onPressed: setUserName))
              ])),
      /*Container(
          padding: EdgeInsets.all(8),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: TextFormField(
                        controller: _inputLastNameController,
                        decoration: InputDecoration(
                            labelText: "Enter your last name"))),
                Expanded(
                    child: FlatButton(
                        child: Text("Set Last Name"), onPressed: setLastName))
              ])),*/
      Container(
          padding: EdgeInsets.all(8),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _inputAgeController,
                      decoration: InputDecoration(labelText: age),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                    )),
                Expanded(
                    child:
                        FlatButton(child: Text("Set Age"), onPressed: setAge))
              ])),
      Container(
          padding: EdgeInsets.all(8),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _inputHeightController,
                      decoration: InputDecoration(labelText: height),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                    )),
                Expanded(
                    child: FlatButton(
                        child: Text("Set Height (inches)"),
                        onPressed: setHeight))
              ])),
      Container(
          padding: EdgeInsets.all(8),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _inputWeightController,
                      decoration: InputDecoration(labelText: weight),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                    )),
                Expanded(
                    child: FlatButton(
                        child: Text("Set Weight (lbs)"), onPressed: setWeight))
              ])),
      Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text("BMI: $bmi"),
              ),
            ],
          ))
    ]);
  }

  void setUserName() async {
    username = (_inputUserNameController.text);
    setState(() {
      _inputUserNameController.clear();
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userName', username);
  }

  /*void setLastName() async {
    lastname = (_inputLastNameController.text);
    setState(() {
      _inputLastNameController.clear();
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userLastName', lastname);
  }*/

  void setAge() async {
    age = /*int.parse*/ (_inputAgeController.text);
    setState(() {
      _inputAgeController.clear();
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userAge', age);
  }

  void bodyMassIndex() async {
    if (height == defaultSetHeight || weight == defaultSetWeight) {
      bmi = defaultBMI;
    } else {
      bmi = ((703 * (double.parse(weight))) /
              (((double.parse(height))) * (double.parse(height))))
          .toStringAsFixed(1);
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userBMI', bmi);
    //bmiHealth();
  }

  void setHeight() async {
    height = /*int.parse*/ (_inputHeightController.text);
    setState(() {
      _inputHeightController.clear();
    });
    bodyMassIndex();
    //bmiHealth();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userHeight', height);
  }

  void setWeight() async {
    weight = /*int.parse*/ (_inputWeightController.text);
    setState(() {
      _inputWeightController.clear();
    });
    bodyMassIndex();
    //bmiHealth();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userWeight', weight);
  }

  /*void bmiHealth() async {
    getBMI = 23.5;
    if (getBMI < 18.5) {
      health = "Underweight";
    } else if (getBMI == 18.5 && getBMI < 24.9) {
      health = "Normal Weight";
    } else if (getBMI == 25 && getBMI < 29.9) {
      health = "Overweight";
    } else if (getBMI > 29.9) {
      health = "Obese";
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userHealth', health);
  }*/
}*/
