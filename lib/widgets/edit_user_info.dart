import 'package:csuf_fitness/widgets/edit_user_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_info.dart';

class EditUserInfo extends StatefulWidget {
  EditUserInfo({Key key}) : super(key: key);
  @override
  _EditUserInfo createState() => _EditUserInfo();
}

class _EditUserInfo extends State<EditUserInfo> {
  static String username;
  //static String lastname;
  static int age;
  static int height;
  static int weight;
  final TextEditingController _inputUserNameController =
      TextEditingController();
  /*final TextEditingController _inputLastNameController =
      TextEditingController();*/
  final TextEditingController _inputAgeController = TextEditingController();
  final TextEditingController _inputHeightController = TextEditingController();
  final TextEditingController _inputWeightController = TextEditingController();
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
                        decoration: InputDecoration(
                            labelText: "Enter your username"))),
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
                      decoration: InputDecoration(labelText: "Enter your age"),
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
                      decoration:
                          InputDecoration(labelText: "Enter your height"),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                    )),
                Expanded(
                    child: FlatButton(
                        child: Text("Set Height"), onPressed: setHeight))
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
                      decoration:
                          InputDecoration(labelText: "Enter your weight"),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                    )),
                Expanded(
                    child: FlatButton(
                        child: Text("Set Weight"), onPressed: setWeight))
              ]))
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
    age = int.parse(_inputAgeController.text);
    setState(() {
      _inputAgeController.clear();
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('userAge', age);
  }

  void setHeight() async {
    height = int.parse(_inputHeightController.text);
    setState(() {
      _inputHeightController.clear();
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('userHeight', height);
  }

  void setWeight() async {
    weight = int.parse(_inputWeightController.text);
    setState(() {
      _inputWeightController.clear();
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('userWeight', weight);
  }
}
