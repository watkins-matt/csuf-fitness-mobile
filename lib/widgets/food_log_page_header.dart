import 'package:csuf_fitness/food_log.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
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
    String calorieModifier(double value) {
      final roundedValue = value.ceil().toInt().toString();
      return '$roundedValue kCal';
    }

    double initialValue = widget.log.calories.toDouble();
    double maxCalories = widget.log.maxCalories.toDouble();
    double maxValue = maxCalories > initialValue ? maxCalories : initialValue;

    final todaySlider = SleekCircularSlider(
      appearance: CircularSliderAppearance(
          customWidths: CustomSliderWidths(progressBarWidth: 5),
          infoProperties: InfoProperties(
              bottomLabelText: "Today", modifier: calorieModifier)),
      min: 0,
      max: maxValue,
      initialValue: initialValue,
    );

    final maxCaloriesSlider = SleekCircularSlider(
      appearance: CircularSliderAppearance(
          customWidths: CustomSliderWidths(progressBarWidth: 5),
          infoProperties: InfoProperties(
              bottomLabelText: "Today's Goal", modifier: calorieModifier)),
      min: 0,
      max: maxCalories,
      initialValue: maxCalories,
    );

    return Container(
        child: Row(
      children: <Widget>[
        Card(
            child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 0, left: 8, right: 8),
          child: todaySlider,
        )),
        Card(
            child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 0, left: 8, right: 8),
                child: maxCaloriesSlider)),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
    ));
  }
}
