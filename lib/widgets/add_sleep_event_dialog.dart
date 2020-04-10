import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../sleep_log.dart';

class AddSleepEventDialog extends StatefulWidget {
  final Function _callback;
  final DateTime initialDate;
  AddSleepEventDialog(this.initialDate, this._callback);

  @override
  _AddSleepEventDialogState createState() => _AddSleepEventDialogState();

  static Future<String> show(
      BuildContext context, DateTime initial, Function callback) async {
    return showDialog(
        context: context,
        builder: (context) => AddSleepEventDialog(initial, callback));
  }
}

class _AddSleepEventDialogState extends State<AddSleepEventDialog> {
  DateTime start;
  DateTime end;
  bool showError = false;

  bool get isValid {
    return start != null && end != null && start.isBefore(end);
  }

  String get errorMessage {
    if (!showError) return '';

    if (start == null) {
      return 'Start time cannot be empty.';
    }

    if (end == null) {
      return 'End time cannot be empty.';
    }

    if (!start.isBefore(end)) {
      return 'End time must be after the start time.';
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Add Sleep Event:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DateTimeField(
              decoration: InputDecoration(hintText: 'Start:'),
              format: DateFormat('EEEEE hh:mm aa'),
              onShowPicker: pickStartTime,
            ),
            DateTimeField(
                decoration: InputDecoration(hintText: 'End:'),
                format: DateFormat('EEEEE hh:mm aa'),
                onShowPicker: pickEndTime),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Visibility(
                  visible: showError,
                  child: Text(errorMessage,
                      style: TextStyle(color: Theme.of(context).errorColor))),
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
              if (isValid) {
                Navigator.of(context).pop();
                widget?._callback(SleepEvent(start, end));
              } else {
                setState(() {
                  showError = true;
                });
              }
            },
          ),
        ]);
  }

  Future<DateTime> pickStartTime(BuildContext context, DateTime current) async {
    start = await pickTime(context, current);
    return start;
  }

  Future<DateTime> pickEndTime(BuildContext context, DateTime current) async {
    end = await pickTime(context, current);
    return end;
  }

  Future<DateTime> pickTime(BuildContext context, DateTime current) async {
    final first = widget.initialDate.subtract(Duration(days: 2));
    final last = widget.initialDate.add(Duration(days: 2));

    final date = await showDatePicker(
        context: context,
        firstDate: first,
        initialDate: current != null && current.isAfter(first)
            ? current
            : widget.initialDate,
        lastDate: last);
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(current ?? DateTime.now()),
      );

      return DateTimeField.combine(date, time);
    } else {
      return current;
    }
  }
}
