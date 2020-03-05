import 'package:csuf_fitness/barcode_scanner.dart';
import 'package:csuf_fitness/food_log.dart';
import 'package:flutter/material.dart';
import '../food_log.dart';
import '../food_log_item.dart';

class AddFoodItemWidget extends StatefulWidget {
  final FoodLog log;
  final BarcodeProvider provider;

  AddFoodItemWidget(this.log, this.provider);

  @override
  _AddFoodItemWidgetState createState() => _AddFoodItemWidgetState();
}

class _AddFoodItemWidgetState extends State<AddFoodItemWidget> {
  TextEditingController _foodNameController = TextEditingController();
  TextEditingController _calorieCountController = TextEditingController();
  // TextDecoration _foodNameDecoration = TextDecoration()

  @override
  void initState() {
    super.initState();

    widget.provider.itemScanned.listen((info) {
      setState(() {
        _foodNameController.text = info.upc;
      });
    });
  }

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
    FoodLogItem item = FoodLogItem(foodName, calorieCount, DateTime.now());

    setState(() {
      // Add the item to the food log we correspond to, which should
      // update all other classes listening to calorie changed events
      // and food item added events
      widget.log.add(item);

      // Clear the food name and calorie count so the user can enter more items in
      _foodNameController.clear();
      _calorieCountController.clear();
    });
  }
}
