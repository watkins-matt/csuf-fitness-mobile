import 'package:csuf_fitness/barcode_scanner.dart';
import 'package:csuf_fitness/food_log.dart';
import 'package:csuf_fitness/widgets/food_log_page_header_alt.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/add_food_item_widget.dart';
import '../widgets/main_drawer.dart';
import '../widgets/food_log_list_view.dart';
import '../food_log.dart';
import '../icon_library.dart';
import '../barcode_scanner.dart';

class FoodLogPage extends StatefulWidget {
  final String title;
  final FoodLog log = FoodLog();
  final BarcodeProvider provider = BarcodeProvider();

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildBody(),
        drawer: MainDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            widget.provider.scan();
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
        StreamBuilder<BarcodeInfo>(
            stream: widget.provider.itemScanned,
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return AddFoodItemWidget(widget.log, widget.provider);
              else
                return AddFoodItemWidget(widget.log, widget.provider);
            }),
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
    widget.provider.dispose();
    super.dispose();
  }

  Future _init() async {
    const int default_max_calories = 2000;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      widget.log.maxCalories =
          preferences.getInt('dailyMaxCalories') ?? default_max_calories;
    });
  }
}
