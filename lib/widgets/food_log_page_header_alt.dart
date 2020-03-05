import 'package:csuf_fitness/food_log.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
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
    String calorieModifier(double value) {
      final roundedValue = value.ceil().toInt().toString();
      return '$roundedValue kCal';
    }

    double initialValue = widget.log.calories.toDouble();
    double maxCalories = widget.log.maxCalories.toDouble();
    maxCalories = maxCalories == 0 ? 2000 : maxCalories;
    double maxValue = maxCalories > initialValue ? maxCalories : initialValue;

    final c = Container(
        child: CalendarStrip(
      onDateSelected: () {},
      iconColor: Colors.black87,
      containerDecoration: BoxDecoration(color: Colors.black12),
    ));

    double calPercent = initialValue / maxValue;
    final pb = RoundedProgressBar(
      percent: calPercent,
      childCenter: Text("$initialValue / $maxCalories",
          style: TextStyle(color: Colors.white)),
    );
    // childLeft: Text("$percent%", style: TextStyle(color: Colors.white)),
    // percent: percent,
    // theme: RoundedProgressBarTheme.green);

    // final todaySlider = SleekCircularSlider(
    //   appearance: CircularSliderAppearance(
    //       customWidths: CustomSliderWidths(progressBarWidth: 5),
    //       infoProperties: InfoProperties(
    //           bottomLabelText: "Today", modifier: calorieModifier)),
    //   min: 0,
    //   max: maxValue,
    //   initialValue: initialValue,
    // );

    // final maxCaloriesSlider = SleekCircularSlider(
    //   appearance: CircularSliderAppearance(
    //       customWidths: CustomSliderWidths(progressBarWidth: 5),
    //       infoProperties: InfoProperties(
    //           bottomLabelText: "Today's Goal", modifier: calorieModifier)),
    //   min: 0,
    //   max: maxCalories,
    //   initialValue: maxCalories,
    // );

    return Container(
        child: Column(
      children: <Widget>[
        c,
        pb
        // Card(
        //     child: Padding(
        //   padding: EdgeInsets.only(top: 20, bottom: 0, left: 8, right: 8),
        //   child: todaySlider,
        // )),
        // Card(
        //     child: Padding(
        //         padding: EdgeInsets.only(top: 20, bottom: 0, left: 8, right: 8),
        //         child: maxCaloriesSlider)),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
    ));
  }
}
