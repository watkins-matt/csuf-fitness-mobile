import 'package:csuf_fitness/pages/home_page.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddWeightDialog extends StatefulWidget {
  final WeightTrackingLog log;
  AddWeightDialog(this.log);

  @override
  _AddWeightDialog createState() => _AddWeightDialog();

  static Future<void> show(BuildContext context, WeightTrackingLog log) async {
    return showDialog(
        context: context, builder: (context) => AddWeightDialog(log));
  }
}

class _AddWeightDialog extends State<AddWeightDialog> {
  TextEditingController _controller = TextEditingController(text: '');
  DateTime date;
  bool showError = false;

  bool get isValid {
    return date != null;
  }

  String get errorMessage {
    if (!showError) return '';

    if (date == null) {
      return 'Date cannot be empty.';
    }

    return '';
  }

  @override
  void initState() {
    date = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Add Weight:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DateTimeField(
              initialValue: DateTime.now(),
              decoration: InputDecoration(hintText: 'Date:'),
              format: DateFormat('EEEEE'),
              onShowPicker: pickDate,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Weight'),
              controller: _controller,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: false),
            ),
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
                setState(() {
                  Navigator.of(context).pop();
                  double weight = double.parse(_controller.text);
                  widget.log.addWeight(date, weight.round());
                });
              } else {
                setState(() {
                  showError = true;
                });
              }
            },
          ),
        ]);
  }

  Future<DateTime> pickDate(BuildContext context, DateTime current) async {
    date = await showDatePicker(
        context: context,
        initialDate: current,
        firstDate: DateTime.now().subtract(Duration(days: 30)),
        lastDate: DateTime.now().add(Duration(days: 30)));

    return date != null ? date : current;
  }
}
