import 'package:csuf_fitness/food_log.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/add_food_item_widget.dart';
import '../widgets/main_drawer.dart';
import '../widgets/food_log_page_header.dart';
import '../widgets/food_log_list_view.dart';
import '../database/food_database.dart';
import '../food_log.dart';

class FoodLogPage extends StatefulWidget {
  final String title;
  final FoodLog log = FoodLog();

  FoodLogPage({Key key, this.title}) : super(key: key);

  @override
  _FoodLogPageState createState() => _FoodLogPageState();
}

class _FoodLogPageState extends State<FoodLogPage> {
  _FoodLogPageState() {
    _init();
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

  Widget _buildBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        StreamBuilder<int>(
            stream: FoodLog().caloriesChanged,
            builder: (context, snapshot) {
              return FoodLogPageHeader(widget.log);
            }),

        // FoodLogPageHeader(widget.log),
        AddFoodItemWidget(widget.log),
        StreamBuilder<int>(
            stream: FoodLog().caloriesChanged,
            builder: (context, snapshot) {
              return FoodLogListView(widget.log);
            })
      ],
    ));
  }

  @override
  void dispose() {
    widget.log.dispose();
    super.dispose();
  }

  Future _init() async {
    const int default_max_calories = 2000;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // setState(() {
    //   widget.log.maxCalories =
    //       preferences.getInt('dailyMaxCalories') ?? default_max_calories;
    // });
  }
}
