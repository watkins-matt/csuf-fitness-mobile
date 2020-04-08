import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../sleep_log.dart';

class WeekdayListView extends StatelessWidget {
  const WeekdayListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: _buildWeekdayListViewItem,
      itemCount: 7,
      padding: EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
    ));
  }

  Widget _buildWeekdayListViewItem(BuildContext context, int index) {
    final SleepDataProvider sleepData =
        Provider.of<SleepDataProvider>(context, listen: false);
    DateTime date = DateTime.now().subtract(Duration(days: index));
    SleepLog log = sleepData.getDate(date);

    int hours = log.length.inHours;
    int minutes = log.length.inMinutes;
    // int seconds = log.length.inSeconds;

    Card listViewCard = Card(
        elevation: 2,
        child: ExpansionTileCard(
          title: Text(DateFormat('EEEE').format(date)),
          subtitle: Text(DateFormat('MMMM, dd, yyyy').format(date)),
          // subtitle: Text(DateFormat.jm().format(widget.log[index].time)),
          trailing: Text("$hours hours, $minutes minutes"),
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            )
          ],
        ));

    //return Dismissible(key: UniqueKey(), child: listViewCard);
    return listViewCard;
  }
}
