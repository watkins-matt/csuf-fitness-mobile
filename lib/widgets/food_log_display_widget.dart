import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../food_log.dart';

class FoodLogDisplayWidget extends StatefulWidget {
  final FoodLog log;
  FoodLogDisplayWidget(this.log);

  @override
  _FoodLogDisplayWidgetState createState() => _FoodLogDisplayWidgetState();
}

class _FoodLogDisplayWidgetState extends State<FoodLogDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: _buildListViewItem,
      itemCount: widget.log.length,
      padding: EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
    ));
  }

  Widget _buildListViewItem(BuildContext context, int index) {
    Card listViewCard = Card(
        child: ListTile(
            title: Text(widget.log[index].name),
            subtitle: Text(DateFormat.jm().format(widget.log[index].time)),
            trailing: Text(widget.log[index].calories.toString())));

    return Dismissible(
        onDismissed: (_) {
          _listViewItemDismissed(index);
        },
        key: UniqueKey(),
        child: listViewCard);
  }

  void _listViewItemDismissed(int index) {
    setState(() {
      widget.log.removeAt(index);
    });
  }
}
