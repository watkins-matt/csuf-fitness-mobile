import 'package:csuf_fitness/food_history.dart';
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
              accountName: FlatButton(
                child: Text(
                  "$userName\nBMI: $userBMI",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.white),
                ),
                onPressed: () {},
              ),
<<<<<<< HEAD
              accountEmail: Text("")),
          _initialSetupListTile(context),
=======
              accountEmail: Text(email)),
>>>>>>> bfe48b1d6a260d736c68b2cafa0ae1ae8b200084
          _foodHistoryListTile(context),
          _settingsListTile(context),
          _userInfoTile(context),
        ],
      )),
    );
  }

  ListTile _foodHistoryListTile(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text("Food History"),
        onTap: () {
          Navigator.pop(context);
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (BuildContext context) {
          //     return Scaffold(body: SettingsPage());
          //   },
          // ));
          openFoodHistoryPage(context);
        });
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
