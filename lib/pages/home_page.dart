import 'package:charts_flutter/flutter.dart' as charts;
import 'package:csuf_fitness/widgets/add_weight_dialog.dart';
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
    final fit = Provider.of<FitIntegration>(context, listen: false);

    int roundedCalories = fit.calories.round();
    double calPercent = (fit.calories / 2000) * 100;
    final calorieProgressBar = RoundedProgressBar(
      style: RoundedProgressBarStyle(colorBorder: Theme.of(context).cardColor),
      percent: calPercent,
      childCenter: Text("$roundedCalories kCal Burned / 2000 kCal",
          style: TextStyle(color: Colors.white)),
    );

    int roundedSteps = fit.stepCount.round();
    double stepPercent = (roundedSteps / 10000) * 100;

    final stepProgressBar = RoundedProgressBar(
      style: RoundedProgressBarStyle(
        colorBorder: Theme.of(context).cardColor,
      ),
      // theme: RoundedProgressBarTheme.green,
      percent: stepPercent,
      childCenter: Text("$roundedSteps Steps / 10000 Steps",
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

  Widget _bottomCard(BuildContext context) {
    return Expanded(
        child: Card(
            elevation: 5,
            child: Container(
                child: Column(children: <Widget>[
              _chart(context),
            ]))));
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
          // _altChart(context),
          _bottomCard(context),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 30, right: 30),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                final weightLog =
                    Provider.of<WeightTrackingLog>(context, listen: false);
                //weightLog.addWeight(DateTime.now(), Random().nextInt(25) + 150);
                AddWeightDialog.show(context, weightLog);
              },
            )),
        drawer: MainDrawer());
  }

  // List<FlSpot> buildWeightData(List<WeightDataPoint> data) {
  //   List<FlSpot> list = <FlSpot>[];

  //   for (final datum in data) {
  //     list.add(FlSpot(datum.date.millisecondsSinceEpoch.toDouble(),
  //         datum.weight.toDouble()));
  //   }

  //   return list;
  // }

  // Widget _altChart(BuildContext context) {
  //   final weightLog = Provider.of<WeightTrackingLog>(context, listen: false);
  //   List<FlSpot> list = buildWeightData(weightLog.data);

  //   return Expanded(
  //       child: Padding(
  //           padding: EdgeInsets.all(8),
  //           child: LineChart(LineChartData(
  //               maxX: DateTime.now().millisecondsSinceEpoch.toDouble(),
  //               minX: DateTime.now()
  //                   .subtract(Duration(days: 10))
  //                   .millisecondsSinceEpoch
  //                   .toDouble(),
  //               lineBarsData: <LineChartBarData>[LineChartBarData(spots: list)],
  //               titlesData: FlTitlesData(
  //                   bottomTitles: SideTitles(
  //                       showTitles: true,
  //                       reservedSize: 30,
  //                       margin: 8,
  //                       textStyle: const TextStyle(
  //                         color: Color(0xff75729e),
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 14,
  //                       ),
  //                       interval: 5000,
  //                       getTitles: getXAxisTitle))))));
  // }

  // String getXAxisTitle(double value) {
  //   int timestamp = value.toInt();
  //   DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp);
  //   return "Test";
  // }

  Widget _chart(BuildContext context) {
    final weightLog = Provider.of<WeightTrackingLog>(context, listen: false);

    return Consumer<WeightTrackingLog>(builder: (context, cart, child) {
      return Expanded(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: charts.TimeSeriesChart(buildSeries(weightLog.data),
            behaviors: [
              charts.ChartTitle('Weight: ${weightLog.current}',
                  innerPadding: 18)
            ],
            primaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    desiredTickCount: 10, zeroBound: false))),
      ));
    });
  }

  List<charts.Series<WeightDataPoint, DateTime>> buildSeries(
      List<WeightDataPoint> data) {
    return [
      charts.Series<WeightDataPoint, DateTime>(
        id: 'Weight',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (WeightDataPoint data, _) => data.date,
        measureFn: (WeightDataPoint data, _) => data.weight,
        data: data,
      )
    ];
  }
}

class WeightDataPoint implements Comparable<WeightDataPoint> {
  int weight;
  DateTime date;

  WeightDataPoint({@required this.date, @required this.weight});

  @override
  int compareTo(WeightDataPoint other) {
    return date.compareTo(other.date);
  }
}

class WeightTrackingLog extends ChangeNotifier {
  List<WeightDataPoint> data = <WeightDataPoint>[];

  WeightTrackingLog() {
    populateTestData();
  }

  int get current {
    return data.last.weight;
  }

  void addWeight(DateTime date, int weight) {
    data.add(WeightDataPoint(date: date, weight: weight));
    data.sort();
    notifyListeners();
  }

  void populateTestData() {
    data.clear();
    final list = [
      WeightDataPoint(
          date: DateTime.now().subtract(Duration(days: 5)), weight: 188),
      WeightDataPoint(
          date: DateTime.now().subtract(Duration(days: 4)), weight: 185),
      WeightDataPoint(
          date: DateTime.now().subtract(Duration(days: 3)), weight: 184),
      // WeightDataPoint(
      //     date: DateTime.now().subtract(Duration(days: 15)), weight: 185),
      // WeightDataPoint(
      //     date: DateTime.now().subtract(Duration(days: 10)), weight: 183),
      // WeightDataPoint(
      //     date: DateTime.now().subtract(Duration(days: 5)), weight: 180),
    ];
    data.addAll(list);
    notifyListeners();
  }
}
