import 'package:flutter/material.dart';
import "about_us.dart";
import "help_center.dart";
import '../widgets/edit_user_info.dart';

class UsersPage extends StatefulWidget {
  UsersPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _UserPageState createState() => _UserPageState();

  static void push(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(body: UsersPage());
      },
    ));
  }
}

class _UserPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: _buildUserPage(),
    );
  }

  Widget _buildUserPage() {
    return Center(
      child: Column(
        children: <Widget>[
          EditUserInfo(),
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
  }
}


         