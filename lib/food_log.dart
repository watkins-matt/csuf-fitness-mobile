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
  DateTime _date = DateTime.now();

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
  DateTime get date => _date;
  set date(value) => _updateDate(value);

  List<FoodLogItem> get breakfast => getItemsBetween(
      DateTime(_date.year, _date.month, _date.day, 0),
      DateTime(_date.year, _date.month, _date.day, 11));
  List<FoodLogItem> get lunch => getItemsBetween(
      DateTime(_date.year, _date.month, _date.day, 11),
      DateTime(_date.year, _date.month, _date.day, 4));
  List<FoodLogItem> get dinner => getItemsBetween(
      DateTime(_date.year, _date.month, _date.day, 4),
      DateTime(_date.year, _date.month, _date.day + 1)
          .subtract(Duration(microseconds: 1)));
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

    // Update the storage provider/database
    _provider.write(item);

    // Send events to event listeners
    _caloriesChangedController.add(_calories);
    _itemAddedController.add(item);
  }

  void removeAt(int index) {
    _calories -= _items[index].calories;
    assert(_calories >= 0);

    FoodLogItem item = _items[index];
    _items.removeAt(index);

    // Update the storage provider/database
    _provider.delete(item);

    // Send events to event listeners
    _itemRemovedController.add(item);
    _caloriesChangedController.add(_calories);
  }

  List<FoodLogItem> getItemsBetween(DateTime startTime, DateTime endTime) {
    List<FoodLogItem> itemsBetween = List<FoodLogItem>();

    // Loop over all the items in the food log and find all of the items that are >= startTime
    // and < endTime
    _items.forEach((item) {
      if ((item.time.compareTo(startTime) != 0 ||
              item.time.isAfter(startTime)) &&
          item.time.isBefore(endTime)) {
        itemsBetween.add(item);
      }
    });

    return itemsBetween;
  }

  void _updateDate(DateTime value) async {
    _date = value;
    _items = await _provider.read(value);
    _calories = 0;

    _items.forEach((item) {
      _calories += item.calories;
    });

    _caloriesChangedController.add(_calories);
  }
}
