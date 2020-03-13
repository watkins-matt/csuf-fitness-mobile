import 'package:flutter/material.dart';
import '../pages/settings_page.dart';
import '../pages/user_page.dart';
import "package:shared_preferences/shared_preferences.dart";

class MainDrawer extends StatefulWidget {
  @override
  MainDrawerState createState() => MainDrawerState();
}

class MainDrawerState extends State<MainDrawer> {
  static const String defaultUserName = "Default User";
  static const String defaultBMI = "";
  String userName = defaultUserName;
  String userBMI = defaultBMI;

  MainDrawerState() {
    _init();
  }

  Future _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.get("userName") ?? defaultUserName;
      userBMI = prefs.get("userBMI") ?? defaultBMI;
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
                  child: Text(userName.substring(0, 1))),
              accountName: Text("$userName"),
              accountEmail: Text("BMI: $userBMI")),
          //_initialSetupListTile(context),
          // _foodHistoryListTile(context),
          _userInfoTile(context),
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

  ListTile _userInfoTile(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.perm_identity),
        title: Text("User Info"),
        onTap: () {
          UsersPage.push(context);
        });
  }
}
