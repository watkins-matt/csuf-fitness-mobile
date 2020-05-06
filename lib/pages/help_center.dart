import 'package:flutter/material.dart';

class help_center extends StatelessWidget{
  Tween<double> _scaleTween = Tween<double>(begin: 1, end:2 );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome To The Help Center ',
      home: Scaffold (
        backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text("About", style: TextStyle(color: Colors.white, fontSize: 20),),
      ),
        body: Center (
        
          child: TweenAnimationBuilder(
            tween: _scaleTween,
            duration: Duration (seconds: 2),
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
                
                child: Text(
                'Welcome to our Licenses'
                
                ,
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold,color: Colors.black,height: 0),
              )
            
   
         ),

      
        
    ),
    
    ),
    
    );
    
    
}
}