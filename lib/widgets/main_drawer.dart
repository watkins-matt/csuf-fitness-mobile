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
          ListTile(
              title: Text("Debug: Run Initial Setup"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Scaffold(body: SettingsPage());
                  },
                ));
              }),
        ],
      )),
    );
  }
}
