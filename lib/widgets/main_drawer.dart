import 'package:csuf_fitness/pages/about_us.dart';
import 'package:csuf_fitness/pages/body_mass_index_chart.dart';
import 'package:csuf_fitness/pages/help_center.dart';
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
                  child: Text(
                      username.isNotEmpty ? username.substring(0, 1) : '')),
              accountName: Text("$username"),
              accountEmail: Text("BMI: $bmi")),
          //_initialSetupListTile(context),
          // _foodHistoryListTile(context),
          /*_userInfoTile(context),*/
          _settingsListTile(context),
          _bmiChartTile(context),
          _aboutUsTile(context),
          _helpCenterTile(context),
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

 ListTile _bmiChartTile(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.perm_data_setting),
        title: Text("BMI Chart"),
        onTap: () {
          BMIChartPage.push(context);
        });
  }
  ListTile _aboutUsTile(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.perm_data_setting),
        title: Text("About Us"),
        onTap: () {
          AboutUsPage.push(context);
        });
  }

  ListTile _helpCenterTile(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.perm_data_setting),
        title: Text("Help Center"),
        onTap: () {
          HelpCenterPage.push(context);
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
