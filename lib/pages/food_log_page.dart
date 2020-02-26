import 'package:csuf_fitness/food_log.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../widgets/add_food_item_widget.dart';
import '../widgets/main_drawer.dart';
import '../widgets/food_log_page_header.dart';
import '../database/food_database.dart';

import '../food_log.dart';
import '../food_log_item.dart';

class FoodLogPage extends StatefulWidget {
  final String title;
  final FoodLog log = FoodLog();

  FoodLogPage({Key key, this.title}) : super(key: key);

  @override
  _FoodLogPageState createState() => _FoodLogPageState();
}

class _FoodLogPageState extends State<FoodLogPage> {
  // FoodLog log = FoodLog();
  final dbFood = FoodDatabase.instance;

  _FoodLogPageState() {
    _init();

    // // Make sure we refresh the view every time a log item is added
    // widget.log.itemAdded.listen(onFoodItemAdded);
  }

  // void onFoodItemAdded(FoodLogItem item) {
  //   // setState(() {});
  // }

  @override
  void dispose() {
    widget.log.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildBody(),
        drawer: MainDrawer());
  }

  // Widget builder1(BuildContext context, AsyncSnapshot<int> snapshot) {
  //   return FoodLogPageHeader(widget.log);
  // }

  Widget _buildBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // FoodLogPageHeader(widget.log),
        AddFoodItemWidget(widget.log),
        Expanded(child: _buildListView()),
      ],
    ));
  }

  // Widget _buildCalorieCountHeader() {
  //   String calorieModifier(double value) {
  //     final roundedValue = value.ceil().toInt().toString();
  //     return '$roundedValue kCal';
  //   }

  //   final todaySlider = SleekCircularSlider(
  //     appearance: CircularSliderAppearance(
  //         customWidths: CustomSliderWidths(progressBarWidth: 5),
  //         infoProperties: InfoProperties(
  //             bottomLabelText: "Today", modifier: calorieModifier)),
  //     min: 0,
  //     max: _maxCalories.toDouble(),
  //     initialValue: _dailyCalorieCount.toDouble(),
  //   );

  //   final maxCaloriesSlider = SleekCircularSlider(
  //     appearance: CircularSliderAppearance(
  //         customWidths: CustomSliderWidths(progressBarWidth: 5),
  //         infoProperties: InfoProperties(
  //             bottomLabelText: "Today's Goal", modifier: calorieModifier)),
  //     min: 0,
  //     max: _maxCalories.toDouble(),
  //     initialValue: _maxCalories.toDouble(),
  //   );

  //   return Row(
  //     children: <Widget>[
  //       Card(
  //           child: Padding(
  //         padding: EdgeInsets.only(top: 20, bottom: 0, left: 8, right: 8),
  //         child: todaySlider,
  //       )),
  //       Card(
  //           child: Padding(
  //         padding: EdgeInsets.only(top: 20, bottom: 0, left: 8, right: 8),
  //         child: maxCaloriesSlider,
  //       )),
  //     ],
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //   );
  // }

  ListView _buildListView() {
    return ListView.builder(
      itemBuilder: _buildListViewItem,
      itemCount: widget.log.length,
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
                title: Text(widget.log[index].name),
                subtitle: Text(DateFormat.Hm().format(widget.log[index].time)),
                trailing: Text(widget.log[index].calories.toString()))));
  }

  Future _init() async {
    const int default_max_calories = 2000;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // setState(() {
    //   widget.log.maxCalories =
    //       preferences.getInt('dailyMaxCalories') ?? default_max_calories;
    // });
  }

  void _listViewItemDismissed(int index) {
    setState(() {
      // We're beyond the maximum of 2000 calories, reduce the overall calorie
      // count but not less that 2000
      // if (_dailyCalorieCount == _maxCalories) {
      //   _maxCalories = (_maxCalories - _foodItems[index].calories) < 2000 ? 2000
      //
      //       : _maxCalories - _foodItems[index].calories;
      // }

      // _dailyCalorieCount -= _foodItems[index].calories;
      // _foodItems.removeAt(index);
      widget.log.removeAt(index);
    });
  }

  // void _onAddFoodButtonPressed(FoodLogItem foodItem) async {
  //   setState(() {
  //     dbFood.insert(foodItem);
  //     _foodItems.add(foodItem);
  //     int newCalorieCount = _dailyCalorieCount + foodItem.calories;

  //     if (newCalorieCount > 2000) {
  //       _maxCalories = newCalorieCount;
  //     }

  //     _dailyCalorieCount += foodItem.calories;
  //   });
  // }
}
