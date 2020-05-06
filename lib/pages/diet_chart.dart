//import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class DietChartPage extends StatefulWidget {
  DietChartPage({Key key}) : super(key: key);

  @override
  _DietChartPageState createState() => _DietChartPageState();

  static void push(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(body: DietChartPage());
      },
    ));
  }
}

class _DietChartPageState extends State<DietChartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Healthy Diet Chart"),
      ),
      body: _wrap(),
    );
  }

  Widget _wrap() {
    return Wrap(
      //alignment: WrapAlignment.end,
      direction: Axis.horizontal,
      spacing: 10.0,
      runSpacing: 30.0,
      children: <Widget>[
        _intro(),
        _chart(),
      ],
    );
  }

  Widget _intro() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
            "In order to lead a healthy life, it is essential to follow a balanced diet. Balanced diet is associated with good health, prevention of diseases and recovery from illnesses.\n\nBelow is a healthy diet chart for adults."),
      ),
    );
  }

  Widget _chart() {
    return Center(
      child: Image.network(
        'https://i.imgur.com/gtPimZp.png',
      ),
    );
  }
}
