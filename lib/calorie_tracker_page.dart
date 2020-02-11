import 'package:flutter/material.dart';

class FoodItem {
  String name;
  int calories;

  FoodItem(this.name, this.calories);
}

class CalorieTrackerPage extends StatefulWidget {
  CalorieTrackerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CalorieTrackerPageState createState() => _CalorieTrackerPageState();
}

class _CalorieTrackerPageState extends State<CalorieTrackerPage> {
  List<FoodItem> _foodItems = [];
  TextEditingController _foodNameController = TextEditingController();
  TextEditingController _calorieCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildAddFoodItemWidget(),
        Expanded(child: _buildListView()),
      ],
    ));
  }

  Widget _buildAddFoodItemWidget() {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                        controller: _foodNameController,
                        decoration: InputDecoration(labelText: "Food:")),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _calorieCountController,
                        decoration: InputDecoration(labelText: "Calories:"),
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                      )),
                  FlatButton(
                    child: Text("Add"),
                    onPressed: _onAddButtonPressed,
                  )
                ])));
  }

  void _onAddButtonPressed() {
    setState(() {
      _foodItems.add(FoodItem(
          _foodNameController.text, int.parse(_calorieCountController.text)));
      _foodNameController.clear();
      _calorieCountController.clear();
    });
  }

  ListView _buildListView() {
    return ListView.builder(
      itemBuilder: _buildListViewItem,
      itemCount: _foodItems.length,
      padding: EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
    );
  }

  Widget _buildListViewItem(BuildContext context, int index) {
    return Card(
        child: ListTile(
            title: Text(_foodItems[index].name),
            trailing: Text(_foodItems[index].calories.toString())));
  }
}
