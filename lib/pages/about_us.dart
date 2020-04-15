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
        title: Text("About", style: TextStyle(color: Colors.white, fontSize: 20),),
      ),
     body: SafeArea(
       child: SingleChildScrollView(
       child: Padding(
         padding: EdgeInsets.all(20.0),
         
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget> [
          SizedBox(height: 10,),
          Text("Licenses, Agreements, and Attributes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),),
           SizedBox(height: 20,),
           Text("""name: csuf_fitness
description: Allows users to track their health and fitness.

dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^0.5.6+1
  sqflite: ^1.2.1
  path_provider: ^1.6.0
  intl: ^0.16.1
  flutter_rounded_progress_bar: ^0.1.2
  calendar_strip: ^1.0.6
  recase: ^3.0.0
  http: ^0.12.0+4
  settings_ui: ^0.2.0
  openfoodfacts: ^0.1.16
  flutter_spinkit: ^4.1.2
  qrscan: ^0.2.17
  expansion_tile_card: ^1.0.2+2
  provider: ^4.0.4
  fit_kit: ^1.1.1
  datetime_picker_formfield: ^1.0.0
  

  sqflite:
Copyright (c) 2017, Alexandre Roux Tekartik.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

""", 
                 
                 
                 
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey,fontStyle: FontStyle.italic),),
           ],
           
         ),
         
       ),
       
     ),

    ),
     
    );
   
  }
}