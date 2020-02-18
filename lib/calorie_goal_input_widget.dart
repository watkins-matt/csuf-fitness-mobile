import 'package:flutter/material.dart';

class InputDailyCalorieGoalWidget extends StatefulWidget {

  @override
  _InputDailyCalorieGoalWidgetState createState() => _InputDailyCalorieGoalWidgetState();
}

class _InputDailyCalorieGoalWidgetState extends State<InputDailyCalorieGoalWidget> {
  static int dailyGoal;
  final TextEditingController _inputDailyCaloriesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      child:Padding(
        padding: EdgeInsets.all(10),
        child: Row(children: <Widget>[
          Expanded(
            flex: 8,
            child: TextFormField(
              controller: _inputDailyCaloriesController,
              decoration: InputDecoration(labelText: "Enter today's calorie goal"),
              keyboardType: TextInputType.numberWithOptions(
                signed: false, decimal: false
              ),
            ),
          ),
          FlatButton(
            child:Text("Set Calorie Goal"),
            onPressed: setCalorieGoal,
          ),
        ],)
      ),
    //create the input for daily calorie goal
    );
  }
  void setCalorieGoal(){
     dailyGoal = int.parse(_inputDailyCaloriesController.text);
    setState(() {
      _inputDailyCaloriesController.clear();
    });
  }
}

