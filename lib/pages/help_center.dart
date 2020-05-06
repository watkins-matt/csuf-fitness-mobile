import 'package:flutter/material.dart';

class HelpCenterPage extends StatefulWidget {
  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();

  static void push(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(body: HelpCenterPage());
      },
    ));
  }
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  Tween<double> _scaleTween = Tween<double>(begin: 1, end: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome To The Help Center"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: TweenAnimationBuilder(
          tween: _scaleTween,
          duration: Duration(seconds: 2),
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: Text(
            'Welcome To The Help Center ',
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 0),
          )),
    );
  }
}
