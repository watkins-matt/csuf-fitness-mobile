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
        title: Text("Meet The Team", style: TextStyle(color: Colors.white, fontSize: 20),),
      ),
     body: SafeArea(
       child: Padding(
         padding: EdgeInsets.all(20.0),
         
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget> [
          SizedBox(height: 10,),
          Text("Licenses, Agreements, and Attributes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey),),

           ],
         ),
       ),
     ),
      );
  }
}