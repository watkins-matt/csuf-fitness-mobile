import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../barcode_scanner.dart';
import '../food_log.dart';
import '../icon_library.dart';
import '../widgets/add_food_item_widget.dart';
import '../widgets/food_log_list_view.dart';
import '../widgets/food_log_page_header_alt.dart';
import '../widgets/main_drawer.dart';

class FoodLogPage extends StatefulWidget {
  final String title;
  final FoodLog log = FoodLog();

  FoodLogPage({Key key, this.title}) : super(key: key);

  static void push(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(body: FoodLogPage(title: "My Health & Fitness"));
      },
    ));
  }

  @override
  _FoodLogPageState createState() => _FoodLogPageState();
}

class _FoodLogPageState extends State<FoodLogPage> {
  @override
  void initState() {
    init().whenComplete(() {});
    super.initState();
  }

  Future init() async {
    const int default_max_calories = 2000;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      widget.log.maxCalories =
          preferences.getInt('maxCalories') ?? default_max_calories;
      widget.log.date = DateTime.now(); // Forces reload of the database
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("My Health & Fitness"),
        ),
        body: _buildBody(),
        drawer: MainDrawer(),
        floatingActionButton: FloatingActionButton(
          heroTag: "BarcodeScan",
          onPressed: () {
            Provider.of<BarcodeProvider>(context, listen: false).scan();
          },
          tooltip: 'Scan Barcode',
          child: Icon(IconLibrary.barcode),
        ));
  }

  Widget _buildBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        StreamBuilder<int>(
            stream: FoodLog().caloriesChanged,
            builder: (context, snapshot) {
              return FoodLogPageHeaderAlt(widget.log);
            }),
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
    // widget.log.dispose();
    super.dispose();
  }
}
