//import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class BMIChartPage extends StatefulWidget {
  BMIChartPage({Key key}) : super(key: key);

  @override
  _BMIChartPageState createState() => _BMIChartPageState();

  static void push(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(body: BMIChartPage());
      },
    ));
  }
}

class _BMIChartPageState extends State<BMIChartPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Body Mass Index Chart"),
        ),
        body: _wrap(),
        );
  }

Widget _wrap(){
  return Wrap(
    //alignment: WrapAlignment.end,
    direction: Axis.horizontal,
    spacing: 10.0,
    runSpacing: 30.0,
    children: <Widget>[
      _bmiDefinition(),
      _chart(),
    ],
  );
}


  Widget _bmiDefinition() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Weight that is higher than what is considered as a healthy weight for a given height is described as overweight or obese. Body Mass Index, or BMI, is used as a screening tool for overweight or obesity."),
      ),
    );
  }

// IMPLEMENT ZOOM IN FUNCTION
  /*Widget _chart() {
  return Container(
    child: PhotoView(
      imageProvider: AssetImage('graphics/BMIChart.png'),
    )
  );
}*/

// USE ASSET IMAGE INSTEAD OF ONLINE IMAGE
/*Widget _chart() {
    return Center(
      child: Image(image: AssetImage('graphics/BMIChart.png')),
    );
  }*/

  Widget _chart() {
    return Center(
      child: Image.network(
          'https://i.imgur.com/SEUBXHS.png',
    ),
    );
  }
}