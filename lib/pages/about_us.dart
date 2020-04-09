import 'package:flutter/material.dart';

class about_us extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text("Who We Are", style: TextStyle(color: Colors.white, fontSize: 20),),
      ),
      );
  }
}