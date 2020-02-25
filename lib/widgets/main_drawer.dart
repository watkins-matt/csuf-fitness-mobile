import 'package:csuf_fitness/food_history.dart';
import 'package:flutter/material.dart';
import '../pages/settings_page.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("Example User Name"),
              accountEmail: Text("username@example.com")),
          _initialSetupListTile(context),
          _foodHistoryListTile(context),
          _settingsListTile(context)
        ],
      )),
    );
  }

  ListTile _initialSetupListTile(BuildContext context) {
    return ListTile(
        title: Text("Debug: Run Initial Setup"),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(body: SettingsPage());
            },
          ));
        });
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
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(body: SettingsPage());
            },
          ));
        });
  }
}
