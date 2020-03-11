import 'package:csuf_fitness/barcode_scanner.dart';
import 'package:csuf_fitness/food_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  FocusNode _calorieCountFocusNode = FocusNode();
  FocusNode _foodNameFocusNode = FocusNode();
  InputDecoration _foodNameDecoration = InputDecoration(hintText: "Food");
  bool searching = false;

  void searchingStatus(bool status) {
    setState(() {
      searching = status;
    });
  }

  void itemScanned(BarcodeInfo info) {
    setState(() {
      _foodNameController.text = info.productName;
      _foodNameController.selection = TextSelection.fromPosition(
          TextPosition(offset: _foodNameController.text.length));
    });

    if (info.calories > 0) {
      _calorieCountController.text = info.calories.toString();
    }

    // Add the item to the database if we have all the info
    if (info.productName != '' && info.calories != -1) {
      onItemAdded();
    } else if (info.productName != '' && info.calories < 0) {
      setState(() {
        // _calorieCountController.selection =
        //     TextSelection.fromPosition(TextPosition(offset: 0));
        // _foodNameFocusNode.unfocus();
        // FocusScope.of(context).requestFocus(_foodNameFocusNode);
        // FocusScope.of(context).requestFocus(_calorieCountFocusNode);
        FocusScope.of(context).nextFocus();
        _calorieCountFocusNode.requestFocus();
      });
    }

    setState(() {
      searching = false;
    });
  }

  @override
  void initState() {
    widget.provider.itemScannedCallback = itemScanned;
    widget.provider.searchingStatusCallback = searchingStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool autoFocusCalories = _foodNameController.text.isNotEmpty;

    return Card(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Visibility(
                      visible: searching,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0, 0, 12, 8),
                        child: SpinKitWave(
                          color: Theme.of(context).accentColor,
                          size: 25.0,
                        ),
                      )),
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                        controller: _foodNameController,
                        decoration: _foodNameDecoration,
                        focusNode: _foodNameFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus()),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _calorieCountController,
                        decoration: InputDecoration(hintText: "Calories"),
                        focusNode: _calorieCountFocusNode,
                        textInputAction: TextInputAction.done,
                        autofocus: autoFocusCalories,
                        onFieldSubmitted: (_) => onItemAdded(),
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                      )),
                  IconButton(
                    icon: Icon(Icons.add_circle,
                        color: Theme.of(context).accentColor),
                    onPressed: onItemAdded,
                    iconSize: 32,
                  )
                ])));
  }

  void onItemAdded() {
    String foodName = _foodNameController.text;
    var calorieCount = int.tryParse(_calorieCountController.text);
    if (calorieCount == null) return;

    DateTime now = DateTime.now();

    FoodLogItem item = FoodLogItem(
        foodName,
        calorieCount,
        DateTime(
            widget.log.date.year,
            widget.log.date.month,
            widget.log.date.day,
            now.hour,
            now.minute,
            now.second,
            now.millisecond,
            now.microsecond));

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
