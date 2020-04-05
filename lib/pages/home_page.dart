import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../sleep_log.dart';
import '../widgets/main_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double calories = 0;
  double stepCount = 0;
  bool updating = false;

  @override
  void initState() {
    updateData();
    super.initState();
  }

  Future updateData() async {
    setState(() {
      updating = true;
    });

    bool fitConnected =
        await FitKit.hasPermissions([DataType.ENERGY, DataType.STEP_COUNT]);

    if (fitConnected) {
      // if (await FitKit.requestPermissions(
      //     [DataType.ENERGY, DataType.STEP_COUNT])) {
      List<FitData> data = await FitKit.read(DataType.ENERGY,
          dateFrom: DateTime.now().normalize(), dateTo: DateTime.now());
      calories = 0;

      for (int i = 0; i < data.length; i++) {
        FitData item = data[i];
        calories += item.value;
      }

      data = await FitKit.read(DataType.STEP_COUNT,
          dateFrom: DateTime.now().normalize(), dateTo: DateTime.now());
      stepCount = 0;

      for (int i = 0; i < data.length; i++) {
        FitData item = data[i];
        stepCount += item.value;
      }
    }

    setState(() {
      updating = false;
    });
  }

  Widget _topCard(BuildContext context) {
    int roundedCalories = calories.round();
    double calPercent = (calories / 2000) * 100;
    final calorieProgressBar = RoundedProgressBar(
      style: RoundedProgressBarStyle(colorBorder: Theme.of(context).cardColor),
      percent: calPercent,
      childCenter: Text("$roundedCalories kCal Burned",
          style: TextStyle(color: Colors.white)),
    );

    return Card(
        elevation: 5,
        child: Container(
            child: Column(
          children: <Widget>[calorieProgressBar],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        )));
  }

  @override
  Widget build(BuildContext context) {
    int roundedCalories = calories.round();
    int roundedSteps = stepCount.round();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("My Health & Fitness"),
        ),
        body: Column(children: <Widget>[
          _topCard(context),
          Row(children: <Widget>[
            Visibility(
                visible: updating,
                child: Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.fromLTRB(0, 0, 12, 8),
                  child: SpinKitWave(
                    color: Theme.of(context).accentColor,
                    size: 25.0,
                  ),
                )),
          ]),
          Row(children: <Widget>[
            Visibility(
              visible: !updating,
              child: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: updateData,
              ),
            ),
            Expanded(
              child: Card(
                child: Text("Calories Burned Today: $roundedCalories"),
              ),
            ),
          ]),
          Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  child: Text("Steps Today: $roundedSteps"),
                ),
              )
            ],
          ),
        ]),
        drawer: MainDrawer());
  }
}
