import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:provider/provider.dart';

import '../sleep_log.dart';
import '../widgets/main_drawer.dart';

class FitIntegration extends ChangeNotifier {
  double calories = 0;
  double stepCount = 0;
  bool updating = false;

  FitIntegration() {
    update();
  }

  Future update() async {
    updating = true;

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

    updating = false;
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _topCard(BuildContext context) {
    var fit = Provider.of<FitIntegration>(context, listen: false);

    int roundedCalories = fit.calories.round();
    double calPercent = (fit.calories / 2000) * 100;
    final calorieProgressBar = RoundedProgressBar(
      style: RoundedProgressBarStyle(colorBorder: Theme.of(context).cardColor),
      percent: calPercent,
      childCenter: Text("$roundedCalories kCal Burned / 2000 kCal",
          style: TextStyle(color: Colors.white)),
    );

    int roundedSteps = fit.stepCount.round();
    double stepPercent = roundedSteps / 10000;

    final stepProgressBar = RoundedProgressBar(
      style: RoundedProgressBarStyle(
        colorBorder: Theme.of(context).cardColor,
      ),
      // theme: RoundedProgressBarTheme.green,
      percent: stepPercent,
      childCenter: Text("$roundedSteps Steps / 10000",
          style: TextStyle(color: Colors.white)),
    );

    return Card(
        elevation: 5,
        child: Container(
            child: Column(
          children: <Widget>[calorieProgressBar, stepProgressBar],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("My Health & Fitness"),
        ),
        body: Column(children: <Widget>[
          _topCard(context),
        ]),
        drawer: MainDrawer());
  }
}
