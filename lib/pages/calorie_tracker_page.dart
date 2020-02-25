import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:intl/intl.dart';

import '../widgets/add_food_item_widget.dart';
import '../widgets/main_drawer.dart';
import '../food_history.dart';
import '../food_item.dart';
import '../pages/settings_page.dart';
import '../database/food_database.dart';

class CalorieTrackerPage extends StatefulWidget {
  final String title;
  CalorieTrackerPage({Key key, this.title}) : super(key: key);

  @override
  _CalorieTrackerPageState createState() => _CalorieTrackerPageState();
}

class _CalorieTrackerPageState extends State<CalorieTrackerPage> {
  final dbFood = FoodDatabase.instance;

  static const int default_max_calories = 2000;
  List<FoodItem> _foodItems = [];
  int _dailyCalorieCount = 0;
  int _maxCalories = default_max_calories;

  _CalorieTrackerPageState() {
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.perm_data_setting),
              tooltip: 'Settings Page',
              onPressed: () {
                settings(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              tooltip: 'Food History',
              onPressed: () {
                openFoodHistoryPage(context);
              },
            ),
          ],
        ),
        body: _buildBody(),
        drawer: MainDrawer());
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

    final maxCaloriesSlider = SleekCircularSlider(
      appearance: CircularSliderAppearance(
          customWidths: CustomSliderWidths(progressBarWidth: 5),
          infoProperties: InfoProperties(
              bottomLabelText: "Today's Goal", modifier: calorieModifier)),
      min: 0,
      max: _maxCalories.toDouble(),
      initialValue: _maxCalories.toDouble(),
    );

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
          child: maxCaloriesSlider,
        )),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
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
                subtitle: Text(DateFormat.Hm().format(_foodItems[index].time)),
                trailing: Text(_foodItems[index].calories.toString()))));
  }

  Future _init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      _maxCalories =
          preferences.getInt('dailyMaxCalories') ?? default_max_calories;
    });
  }

  void _listViewItemDismissed(int index) {
    setState(() {
      // We're beyond the maximum of 2000 calories, reduce the overall calorie
      // count but not less that 2000
      if (_dailyCalorieCount == _maxCalories) {
        _maxCalories = (_maxCalories - _foodItems[index].calories) < 2000
            ? 2000
            : _maxCalories - _foodItems[index].calories;
      }

      _dailyCalorieCount -= _foodItems[index].calories;
      _foodItems.removeAt(index);
    });
  }

  void _onAddFoodButtonPressed(FoodItem foodItem) async {
    setState(() {
      dbFood.insert(foodItem);
      _foodItems.add(foodItem);
      int newCalorieCount = _dailyCalorieCount + foodItem.calories;

      if (newCalorieCount > 2000) {
        _maxCalories = newCalorieCount;
      }

      _dailyCalorieCount += foodItem.calories;
    });
  }
}
