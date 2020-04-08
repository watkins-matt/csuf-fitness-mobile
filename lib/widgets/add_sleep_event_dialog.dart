import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSleepEventDialog extends StatefulWidget {
  final Function _callback;
  AddSleepEventDialog(this._callback);

  static Future<String> show(BuildContext context, Function callback) async {
    return showDialog(
        context: context, builder: (context) => AddSleepEventDialog(callback));
  }

  @override
  _AddSleepEventDialogState createState() => _AddSleepEventDialogState();
}

class _AddSleepEventDialogState extends State<AddSleepEventDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Add Sleep Event:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DateTimeField(
                decoration: InputDecoration(labelText: "Start:"),
                format: DateFormat("EEEEE hh:mm aa"),
                onShowPicker: (context, currentValue) async {
                  // final time = await showTimePicker(
                  //   context: context,
                  //   initialTime:
                  //       TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  // );
                  // return DateTimeField.convert(time);
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                }),
            DateTimeField(
              decoration: InputDecoration(labelText: "End:"),
              format: DateFormat("EEEEE hh:mm aa"),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('Add'),
            onPressed: () {
              Navigator.of(context).pop();
              widget?._callback();
            },
          ),
        ]);
  }
}
