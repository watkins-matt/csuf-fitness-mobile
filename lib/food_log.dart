import 'food_log_item.dart';
import 'database/storage_provider.dart';
import 'dart:async';

/// A log of food items consumed over a certain day.
///
/// Maintains state information about items consumed as well as
/// the total number of calories consumed. Dispatches events as
/// items are added and removed as well as when the total calorie counts
/// changes.
///
/// This class exists to reduce coupling between components and to
/// keep data separate from the UI code and database code.
class FoodLog {
  // Private fields
  List<FoodLogItem> _items = [];
  int _calories = 0;

  StreamController<int> _caloriesChangedController =
      new StreamController.broadcast();
  StreamController<FoodLogItem> _itemAddedController =
      new StreamController.broadcast();
  StreamController<FoodLogItem> _itemRemovedController =
      new StreamController.broadcast();

  StorageProvider _provider = StorageProvider.instance;

  // Public properties
  FoodLogItem operator [](int index) => _items[index];
  int get calories => _calories;
  int get length => _items.length;
  int maxCalories = 2000;

  // Events
  Stream<int> get caloriesChanged => _caloriesChangedController.stream;
  Stream<FoodLogItem> get itemAdded => _itemAddedController.stream;
  Stream<FoodLogItem> get itemRemoved => _itemRemovedController.stream;

  static final FoodLog _singleton = FoodLog._internal();
  FoodLog._internal();

  factory FoodLog() {
    return _singleton;
  }

  void dispose() {
    _caloriesChangedController.close();
    _itemAddedController.close();
    _itemRemovedController.close();
  }

  void add(FoodLogItem item) {
    _calories += item.calories;
    assert(_calories >= 0);

    _items.add(item);

    _caloriesChangedController.add(_calories);
    _itemAddedController.add(item);

    _provider.write(item);
  }

  void removeAt(int index) {
    _calories -= _items[index].calories;
    assert(_calories >= 0);

    FoodLogItem item = _items[index];
    _items.removeAt(index);

    _itemRemovedController.add(item);
    _caloriesChangedController.add(_calories);
  }
}
