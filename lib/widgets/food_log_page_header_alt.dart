import 'package:csuf_fitness/food_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:calendar_strip/calendar_strip.dart';
import '../food_log.dart';

class FoodLogPageHeaderAlt extends StatefulWidget {
  final FoodLog log;
  FoodLogPageHeaderAlt(this.log);

  @override
  _FoodLogPageHeaderAltState createState() => _FoodLogPageHeaderAltState();
}

class _FoodLogPageHeaderAltState extends State<FoodLogPageHeaderAlt> {
  @override
  Widget build(BuildContext context) {
    final calendarStrip = Container(
        child: CalendarStrip(
      addSwipeGesture: true,
      startDate: DateTime.now().subtract(Duration(days: 3)),
      endDate: DateTime.now().add(Duration(days: 3)),
      onDateSelected: () {},
      iconColor: Colors.black87,
      containerDecoration: BoxDecoration(color: Colors.black12),
    ));

    int calories = widget.log.calories;
    int max = widget.log.maxCalories;

    double initialValue = widget.log.calories.toDouble();
    double maxCalories = widget.log.maxCalories.toDouble();
    maxCalories = maxCalories == 0 ? 2000 : maxCalories;
    double maxValue = maxCalories > initialValue ? maxCalories : initialValue;

    double calPercent = (initialValue / maxValue) * 100;
    final calorieProgressBar = RoundedProgressBar(
      percent: calPercent,
      childCenter: Text("$calories kCal / $max kCal",
          style: TextStyle(color: Colors.white)),
    );

    return Container(
        child: Column(
      children: <Widget>[calendarStrip, calorieProgressBar],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
    ));
  }
}
