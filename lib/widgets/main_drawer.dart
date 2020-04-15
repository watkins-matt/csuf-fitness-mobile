import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

import '../pages/settings_page.dart';

class MainDrawer extends StatefulWidget {
  @override
  MainDrawerState createState() => MainDrawerState();
}

class MainDrawerState extends State<MainDrawer> {
  static const String defaultUserName = "Default User";
  static const double defaultBMI = 0;
  String username = defaultUserName;
  double bmi = defaultBMI;

  MainDrawerState() {
    _init();
  }

  Future _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.get("username") ?? defaultUserName;
      bmi = prefs.get("BMI") ?? defaultBMI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).cardColor,
                  child: Text(username.substring(0, 1))),
              accountName: Text("$username"),
              accountEmail: Text("BMI: $bmi")),
          //_initialSetupListTile(context),
          // _foodHistoryListTile(context),
          /*_userInfoTile(context),*/
          _settingsListTile(context),
        ],
      )),
    );
  }

  ListTile _settingsListTile(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.perm_data_setting),
        title: Text("Settings"),
        onTap: () {
          SettingsPage.push(context);
        });
  }

  /*ListTile _userInfoTile(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.perm_identity),
        title: Text("User Info"),
        onTap: () {
          UsersPage.push(context);
        });
  }*/
}
