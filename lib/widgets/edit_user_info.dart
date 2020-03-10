import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserInfo extends StatefulWidget {
  EditUserInfo({Key key}) : super(key: key);
  @override
  _EditUserInfo createState() => _EditUserInfo();
}

class _EditUserInfo extends State<EditUserInfo> {
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

  _EditUserInfo() {
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
}
