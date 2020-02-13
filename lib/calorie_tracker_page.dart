import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'food_item.dart';
import 'add_food_item_widget.dart';

class CalorieTrackerPage extends StatefulWidget {
  CalorieTrackerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CalorieTrackerPageState createState() => _CalorieTrackerPageState();
}

class _CalorieTrackerPageState extends State<CalorieTrackerPage> {
  List<FoodItem> _foodItems = [];
  int _dailyCalorieCount = 0;
  int _maxCalories = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildCalorieCountHeader() {
    String calorieModifier(double value) {
      final roundedValue = value.ceil().toInt().toString();
      return '$roundedValue kCal';
    }

    final todaySlider = SleekCircularSlider(
      appearance: CircularSliderAppearance(
          customWidths: CustomSliderWidths(progressBarWidth: 5),
          infoProperties: InfoProperties(
              bottomLabelText: "Today", modifier: calorieModifier)),
      min: 0,
      max: _maxCalories.toDouble(),
      initialValue: _dailyCalorieCount.toDouble(),
    );

    final yesterdaySlider = SleekCircularSlider(
        appearance: CircularSliderAppearance(
            customWidths: CustomSliderWidths(progressBarWidth: 5),
            infoProperties: InfoProperties(
                bottomLabelText: "Yesterday", modifier: calorieModifier)),
        min: 0,
        max: 2000,
        initialValue: 1000);

    return Row(
      children: <Widget>[
        Card(
            child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 0, left: 8, right: 8),
          child: todaySlider,
        )),
        Card(
            child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 0, left: 8, right: 8),
          child: yesterdaySlider,
        )),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget _buildBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildCalorieCountHeader(),
        AddFoodItemWidget(_onAddFoodButtonPressed),
        Expanded(child: _buildListView()),
      ],
    ));
  }

  void _onAddFoodButtonPressed(FoodItem foodItem) {
    setState(() {
      _foodItems.add(foodItem);
      int newCalorieCount = _dailyCalorieCount + foodItem.calories;

      if (newCalorieCount > 2000) {
        _maxCalories = newCalorieCount;
      }

      _dailyCalorieCount += foodItem.calories;
    });
  }

  ListView _buildListView() {
    return ListView.builder(
      itemBuilder: _buildListViewItem,
      itemCount: _foodItems.length,
      padding: EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
    );
  }

  Widget _buildListViewItem(BuildContext context, int index) {
    return Dismissible(
        onDismissed: (_) {
          _listViewItemDismissed(index);
        },
        key: UniqueKey(),
        child: Card(
            child: ListTile(
                title: Text(_foodItems[index].name),
                trailing: Text(_foodItems[index].calories.toString()))));
  }

  void _listViewItemDismissed(int index) {
    setState(() {
      // We're beyond the maximum of 2000 calories, reduce the overall calorie
      // count but not less that 2000
      if (_dailyCalorieCount == _maxCalories) {
        _maxCalories = _maxCalories > 2000
            ? _maxCalories - _foodItems[index].calories
            : 2000;
      }

      _dailyCalorieCount -= _foodItems[index].calories;
      _foodItems.removeAt(index);
    });
  }
}
