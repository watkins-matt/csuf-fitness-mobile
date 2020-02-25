import 'package:flutter/material.dart';

void openFoodHistoryPage(BuildContext context) {
  final _historyPeriod = [
    'Today',
    'Yesterday',
    'Past Week',
    'Past Two Weeks',
    'Past Month'
  ];
  String currentPeriodSelected = _historyPeriod[0];

  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Calorie Intake History'),
        ),
        body: Column(children: <Widget>[
          Container(
              child: Text('Intake History',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.black)),
              padding: EdgeInsets.only(top: 10, left: 5)),
          DropdownButton<String>(
              items: _historyPeriod.map((String menuItem) {
                return DropdownMenuItem<String>(
                    value: menuItem, child: Text(menuItem));
              }).toList(),
              onChanged: (String newPeriodSelected) {
                //setState( () {
                // currentPeriodSelected = newPeriodSelected;
                //} );
              },
              value: currentPeriodSelected)
        ]),
      );
    },
  ));
}
