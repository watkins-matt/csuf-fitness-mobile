import 'package:flutter/material.dart';
import 'food_item.dart';

class AddFoodItemWidget extends StatefulWidget {
  final Function itemAddedCallback;

  AddFoodItemWidget(this.itemAddedCallback);

  @override
  _AddFoodItemWidgetState createState() => _AddFoodItemWidgetState();
}

class _AddFoodItemWidgetState extends State<AddFoodItemWidget> {
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _calorieCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    onPressed: onItemAdded,
                  )
                ])));
  }

  void onItemAdded() {
    String foodName = _foodNameController.text;
    int calorieCount = int.parse(_calorieCountController.text);
    widget.itemAddedCallback(FoodItem(foodName, calorieCount));

    setState(() {
      _foodNameController.clear();
      _calorieCountController.clear();
    });
  }
}
