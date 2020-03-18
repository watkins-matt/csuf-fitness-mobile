import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class SleepLogPage extends StatefulWidget {
  SleepLogPage({Key key}) : super(key: key);

  @override
  _SleepLogPageState createState() => _SleepLogPageState();

  static void push(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return SleepLogPage();
      },
    ));
  }
}

class _SleepLogPageState extends State<SleepLogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.snooze),
          onPressed: () {},
        ),
        body: _body(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("My Health & Fitness"),
        ),
        drawer: MainDrawer());
  }

  Widget _header() {
    return Container(
        child: Card(
            child: Column(children: <Widget>[
      Row(children: <Widget>[
        Text(
          "Status: Awake",
          textAlign: TextAlign.left,
        ),
      ]),
      Row(children: <Widget>[
        Text("Total Sleep: "),
        CircleAvatar(radius: 30, child: Text('00:00'))
      ])
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

    Card listViewCard = Card(
        child: ExpansionTileCard(
            title: Text(titles[index]),
            // subtitle: Text(DateFormat.jm().format(widget.log[index].time)),
            trailing: CircleAvatar(child: Text('0.0'))));

    //return Dismissible(key: UniqueKey(), child: listViewCard);
    return listViewCard;
  }
}
