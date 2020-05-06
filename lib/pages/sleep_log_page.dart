import 'dart:async';

import 'package:csuf_fitness/widgets/weekday_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:provider/provider.dart';

import '../sleep_log.dart';
import '../widgets/main_drawer.dart';

class SleepLogPage extends StatefulWidget {
  SleepLogPage({Key key}) : super(key: key);

  @override
  _SleepLogPageState createState() => _SleepLogPageState();
}

class _SleepLogPageState extends State<SleepLogPage> {
  Timer timer;
  String length = "";

  void timerTicked(Timer timer) {
    final status = Provider.of<SleepStatus>(context, listen: false);

    setState(() {
      formatDuration(Duration d) =>
          d.toString().split('.').first.padLeft(8, "0");
      length = formatDuration(status.sleepLength);
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await updateTimerState());

    final dataProvider = Provider.of<SleepDataProvider>(context, listen: false);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          heroTag: "SleepButton",
          child: Icon(Icons.snooze),
          onPressed: onButtonPressed,
        ),
        body: _body(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("My Health & Fitness"),
          actions: <Widget>[
            AddSleepEventButton(date: DateTime.now(), sleepData: dataProvider)
          ],
        ),
        drawer: MainDrawer());
  }

  Future<void> updateTimerState() async {
    final status = Provider.of<SleepStatus>(context, listen: false);

    setState(() {
      if (status.sleeping) {
        timer = Timer.periodic(Duration(seconds: 1), timerTicked);
      } else {
        timer?.cancel();
      }
    });
  }

  void onButtonPressed() async {
    final status = Provider.of<SleepStatus>(context, listen: false);

    setState(() {
      status.sleeping = !status.sleeping;

      if (status.sleeping) {
        timer = Timer.periodic(Duration(seconds: 1), timerTicked);
      } else {
        timer?.cancel();

        final SleepDataProvider sleepData =
            Provider.of<SleepDataProvider>(context, listen: false);
        SleepLog log = sleepData.getDate(DateTime.now());
        log.events.add(status.lastEvent);
      }
    });
  }

  Widget _progressBar(String status) {
    final statusProvider = Provider.of<SleepStatus>(context, listen: false);
    int ms = statusProvider.sleepLength.inMilliseconds;
    int msInEightHours = 1000 * 60 * 60 * 8;
    double percent = (ms / msInEightHours) * 100;

    if (ms == 0) {
      length = "";
    }

    final sleepProgressBar = RoundedProgressBar(
      style: RoundedProgressBarStyle(colorBorder: Theme.of(context).cardColor),
      percent: percent,
      childCenter:
          Text("$status $length", style: TextStyle(color: Colors.white)),
    );
    return sleepProgressBar;
  }

  Widget _header() {
    final statusProvider = Provider.of<SleepStatus>(context, listen: false);
    bool sleeping = statusProvider.sleeping;
    String status = sleeping ? "Asleep" : "Awake";

    return Container(
        child: Card(
            elevation: 10,
            child: Column(children: <Widget>[
              _progressBar(status),
            ])));
  }

  Widget _body() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          _header(),
          Consumer<SleepDataProvider>(builder: (context, cart, child) {
            return WeekdayListView();
          })
        ]));
  }
}
