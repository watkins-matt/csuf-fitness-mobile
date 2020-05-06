import 'package:csuf_fitness/widgets/add_sleep_event_dialog.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../sleep_log.dart';

class WeekdayListView extends StatelessWidget {
  final ScrollController controller = ScrollController();

  WeekdayListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      reverse: true,
      controller: controller,
      itemBuilder: _buildWeekdayListViewItem,
      itemCount: 7,
      padding: EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
    ));
  }

  Widget _buildWeekdayListViewItem(BuildContext context, int index) {
    final SleepDataProvider sleepData =
        Provider.of<SleepDataProvider>(context, listen: false);
    DateTime date =
        DateTime.now().subtract(Duration(days: index - DateTime.now().weekday));
    SleepLog log = sleepData.getDate(date);

    int hours = log.length.inHours;
    int minutes = log.length.inMinutes % 60;
    // int seconds = log.length.inSeconds;
    Color textColor = hours > 6 ? Colors.green : Colors.black;

    Card listViewCard = Card(
        elevation: 2,
        child: ExpansionTileCard(
          initiallyExpanded: false,
          title: Text(DateFormat('EEEE').format(date)),
          subtitle: Text(DateFormat('MMMM, dd, yyyy').format(date)),
          // subtitle: Text(DateFormat.jm().format(widget.log[index].time)),
          trailing: Text(
            "$hours hours, $minutes minutes",
            style: TextStyle(color: textColor),
          ),
          children: <Widget>[
            Visibility(
              visible: log.events.length > 0,
              child: ListTile(title: Text(log.toString())),
            ),
            ListTile(
                title: AddSleepEventButton(date: date, sleepData: sleepData))
          ],
          onExpansionChanged: (expanded) {
            controller.animateTo(controller.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut);
          },
        ));
    return listViewCard;
  }
}

class AddSleepEventButton extends StatelessWidget {
  const AddSleepEventButton({
    Key key,
    @required this.sleepData,
    @required this.date,
  }) : super(key: key);

  final SleepDataProvider sleepData;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        AddSleepEventDialog.show(context, date, (event) {
          sleepData.addEvent(event);
        });
      },
    );
  }
}
