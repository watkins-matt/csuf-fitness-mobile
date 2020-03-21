import 'dart:async';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:intl/intl.dart';
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
  Duration sleepLength = Duration();
  String length = "00:00:00";

  void timerTicked(Timer timer) {
    setState(() {
      formatDuration(Duration d) =>
          d.toString().split('.').first.padLeft(8, "0");

      sleepLength = SleepStatus().sleepLength;
      length = formatDuration(sleepLength);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        ),
        drawer: MainDrawer());
  }

  void onButtonPressed() async {
    await SleepStatus().initialized; // Ensure SleepStatus is initialized
    setState(() {
      SleepStatus().sleeping = !SleepStatus().sleeping;

      if (SleepStatus().sleeping) {
        timer = Timer.periodic(Duration(seconds: 1), timerTicked);
      } else {
        timer?.cancel();

        final SleepDataProvider sleepData =
            Provider.of<SleepDataProvider>(context, listen: false);
        SleepLog log = sleepData.getDate(DateTime.now());
        log.events.add(SleepStatus().lastEvent);
      }
    });
  }

  Widget _progressBar() {
    int ms = sleepLength.inMilliseconds;
    int msInEightHours = 1000 * 60 * 60 * 8;
    double percent = (ms / msInEightHours) * 100;

    final sleepProgressBar = RoundedProgressBar(
      style: RoundedProgressBarStyle(colorBorder: Theme.of(context).cardColor),
      percent: percent,
      childCenter: Text("$length", style: TextStyle(color: Colors.white)),
    );
    return sleepProgressBar;
  }

  Widget _header() {
    bool sleeping = SleepStatus().sleeping;
    String status = sleeping ? "Asleep" : "Awake";

    return Container(
        child: Card(
            elevation: 10,
            child: Column(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$status",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ]),
              // Row(
              //   children: <Widget>[Text("Total Sleep: ")],
              // ),
              _progressBar(),
            ])));
  }

  Widget _body() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          _header(),
          Expanded(
              child: ListView.builder(
            itemBuilder: _buildListViewItem,
            itemCount: 7,
            padding: EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
          ))
        ]));
  }

  Widget _buildListViewItem(BuildContext context, int index) {
    List<String> titles = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ];

    final SleepDataProvider sleepData =
        Provider.of<SleepDataProvider>(context, listen: false);
    DateTime date = DateTime.now().subtract(Duration(days: index));
    SleepLog log = sleepData.getDate(date);

    int hours = log.length.inHours;
    int minutes = log.length.inMinutes;
    int seconds = log.length.inSeconds;

    Card listViewCard = Card(
        elevation: 5,
        child: ExpansionTileCard(
            title: Text(DateFormat('EEEE').format(date)),
            subtitle: Text(DateFormat('MMMM, dd, yyyy').format(date)),
            // subtitle: Text(DateFormat.jm().format(widget.log[index].time)),
            trailing: Text("$hours:$minutes:$seconds")));

    //return Dismissible(key: UniqueKey(), child: listViewCard);
    return listViewCard;
  }
}
