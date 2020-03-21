import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

import '../food_log.dart';

class FoodLogPageHeader extends StatefulWidget {
  final FoodLog log;
  FoodLogPageHeader(this.log);

  @override
  _FoodLogPageHeaderState createState() => _FoodLogPageHeaderState();
}

class _FoodLogPageHeaderState extends State<FoodLogPageHeader> {
  @override
  Widget build(BuildContext context) {
    final calendarStrip = Container(
        child: CalendarStrip(
      containerDecoration: BoxDecoration(),
      iconColor: Theme.of(context).accentColor,
      addSwipeGesture: true,
      startDate: widget.log.date.subtract(Duration(days: 6)),
      endDate: widget.log.date.add(Duration(days: 6)),
      selectedDate: widget.log.date,
      onDateSelected: (date) {
        setState(() {
          widget.log.date = date;
        });
      },
    ));

    int calories = widget.log.calories;
    int max = widget.log.maxCalories;

    double initialValue = widget.log.calories.toDouble();
    double maxCalories = widget.log.maxCalories.toDouble();
    maxCalories = maxCalories == 0 ? 2000 : maxCalories;
    double maxValue = maxCalories > initialValue ? maxCalories : initialValue;

    double calPercent = (initialValue / maxValue) * 100;
    final calorieProgressBar = RoundedProgressBar(
      style: RoundedProgressBarStyle(
          // backgroundProgress: Theme.of(context).scaffoldBackgroundColor,
          // colorProgressDark: Theme.of(context).scaffoldBackgroundColor,
          // colorProgress: Theme.of(context).accentColor,
          colorBorder: Theme.of(context).cardColor),
      percent: calPercent,
      childCenter: Text("$calories kCal / $max kCal",
          style: TextStyle(color: Colors.white)),
    );

    return Card(
        elevation: 5,
        child: Container(
            child: Column(
          children: <Widget>[calendarStrip, calorieProgressBar],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        )));
  }
}
