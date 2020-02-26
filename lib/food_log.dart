import 'food_log_item.dart';
import 'dart:async';

class FoodLog {
  // Private fields
  List<FoodLogItem> _items = [];
  int _calories = 0;
  int _maxCalories = 2000;

  StreamController<int> _caloriesChangedController =
      new StreamController.broadcast();
  StreamController<FoodLogItem> _itemAddedController =
      new StreamController.broadcast();
  StreamController<FoodLogItem> _itemRemovedController =
      new StreamController.broadcast();

  // Public properties
  int get calories => _calories;
  int get maxCalories => _maxCalories;
  set maxCalories(int value) => _maxCalories = value;
  int get length => _items.length;
  FoodLogItem operator [](int index) => _items[index];

  // Events
  Stream<int> get caloriesChanged => _caloriesChangedController.stream;
  Stream<FoodLogItem> get itemAdded => _itemAddedController.stream;
  Stream<FoodLogItem> get itemRemove => _itemRemovedController.stream;

  void dispose() {
    _caloriesChangedController.close();
    _itemAddedController.close();
    _itemRemovedController.close();
  }

  void add(FoodLogItem item) {
    _calories += item.calories;
    assert(_calories > 0);

    _items.add(item);

    _caloriesChangedController.add(_calories);
    _itemAddedController.add(item);
  }

  void removeAt(int index) {
    // We're beyond the maximum of 2000 calories, reduce the overall calorie
    // count but not less that 2000
    // TODO: Find a more elegant way to do this?
    if (_calories == _maxCalories) {
      _maxCalories = (_maxCalories - _items[index].calories) < 2000
          ? 2000
          : _maxCalories - _items[index].calories;
    }

    _calories -= _items[index].calories;
    assert(_calories > 0);

    FoodLogItem item = _items[index];
    _itemRemovedController.add(item);
    _items.removeAt(index);

    _caloriesChangedController.add(_calories);
  }
}
